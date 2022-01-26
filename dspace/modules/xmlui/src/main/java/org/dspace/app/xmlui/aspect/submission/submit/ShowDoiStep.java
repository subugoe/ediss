/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.app.xmlui.aspect.submission.submit;

import java.io.IOException;
import java.sql.SQLException;

import org.apache.cocoon.ProcessingException;
import org.apache.log4j.Logger;
import org.dspace.app.xmlui.aspect.submission.AbstractSubmissionStep;
import org.dspace.app.xmlui.utils.UIException;
import org.dspace.app.xmlui.wing.Message;
import org.dspace.app.xmlui.wing.WingException;
import org.dspace.app.xmlui.wing.element.Body;
import org.dspace.app.xmlui.wing.element.Button;
import org.dspace.app.xmlui.wing.element.Division;
import org.dspace.app.xmlui.wing.element.List;
import org.dspace.authorize.AuthorizeException;
import org.dspace.content.Collection;
import org.dspace.content.Item;
import org.dspace.core.ConfigurationManager;
import org.dspace.identifier.IdentifierException;
import org.dspace.utils.DSpace;
import org.xml.sax.SAXException;

/**
 * Submission step that shows future DOI of item.
 * 
 * @author M. Muehlhoelzer
 *
 */
public class ShowDoiStep extends AbstractSubmissionStep {

    private static Logger log = Logger.getLogger(ShowDoiStep.class);
    
    protected static final Message T_head = message("xmlui.Submission.submit.ShowDoiStep.head");
    protected static final Message T_section_head = message("xmlui.Submission.submit.ShowDoiStep.section_head");
    protected static final Message T_itemDoi_infotext = message("xmlui.Submission.submit.showitemDOI.infotext");

    public ShowDoiStep() {
        this.requireSubmission = true;
        this.requireStep = true;
    }

    @Override
    public void addBody(Body body) throws SAXException, WingException, UIException, SQLException, IOException,
            AuthorizeException, ProcessingException {

        Item item = submission.getItem();
        Collection collection = submission.getCollection();
        String actionURL = contextPath + "/handle/" + collection.getHandle() + "/submit/" + knot.getId() + ".continue";

        Division div = body.addInteractiveDivision("submit-doi", actionURL, Division.METHOD_POST, "primary submission");
        div.setHead(T_head);

        addSubmissionProgressList(div);

        List list = div.addList("submit-describe", List.TYPE_FORM);

	String pref = (ConfigurationManager.getProperty("identifier.doi.prefix") != null) ? ConfigurationManager.getProperty("identifier.doi.prefix") : "";
	String nssep = (ConfigurationManager.getProperty("identifier.doi.namespaceseparator") != null) ? ConfigurationManager.getProperty("identifier.doi.namespaceseparator") : "dspace-";	
       	
		
	String itemDoi = pref + "/" + nssep + item.getID();
	list.setHead(T_section_head.parameterize(itemDoi));

        list.addItem().addContent(T_itemDoi_infotext);

	addControlButtons(list);
    }

    @Override
    public List addReviewSection(List reviewList)
            throws SAXException, WingException, UIException, SQLException, IOException, AuthorizeException {
        /* uncomment this code and remove the final "return null;" to show 
         * the addDoiStep as part of the verifyStep.
         * // Create a new list section for this step (and set its heading)
         * List doiSection = reviewList.addList("submit-review-" + this.stepAndPage, List.TYPE_FORM);
         * doiSection.setHead(T_head);
         * 
         * Item item = submission.getItem();
         * String itemDoi = DOIIdentifierProvider.getDOIByObject(context, item);
         * if (itemDoi != null && !itemDoi.isEmpty()) {
         *     doiSection.addItem().addContent(T_itemDoi.parameterize(itemDoi));
         * } else {
         *     doiSection.addItem().addContent(T_itemDoi_no_doi);
         * }
         * return doiSection;
        */
        return null;
    }

}
