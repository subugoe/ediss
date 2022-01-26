/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.embargo;

import java.sql.SQLException;
import java.io.IOException;

import org.dspace.authorize.AuthorizeException;
import org.dspace.content.Item;
import org.dspace.core.Context;

import org.dspace.core.ConfigurationManager;

/**
 * Default plugin implementation of the embargo lifting function.
 *
 * @author Marianna Muehlhoelzer
 */
public class  RemoveLiftFieldEmbargoLifter implements EmbargoLifter
{
    public RemoveLiftFieldEmbargoLifter()
    {
        super();
    }

    /**
     * Enforce lifting of embargo by turning read access to bitstreams in
     * this Item back on. Delete embargo.field.lift after lifting.
     *
     * @param context the DSpace context
     * @param item    the item to embargo
     */
    public void liftEmbargo(Context context, Item item)
            throws SQLException, AuthorizeException, IOException
    {
        // remove the item's policies and replace them with
        // the defaults from the collection
        item.inheritCollectionDefaultPolicies(item.getOwningCollection());
	String fieldLift = ConfigurationManager.getProperty("embargo.field.lift");
	if (fieldLift == null) 
		fieldLift = "dc.date.embargoed";
	String[] tokens = fieldLift.split("\\.");
	item.clearDC(tokens[1], tokens[2], Item.ANY);
    }
}
