/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-27-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger UpdateAccountCA on Order (after update) {
        UpdateAllAccountBatch bh = new UpdateAllAccountBatch();
        Database.executeBatch(bh);
}