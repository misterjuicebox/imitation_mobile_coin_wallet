import './account_constants.dart';
import '../models/contact.model.dart';

const String feePmob = "400000000";

const String mob = "MOB";
const String usd = "USD";
const List<String> currencyOptions = [mob, usd];

final List<Contact> ogContacts = [
  Contact(firstName: "Soon", lastName: "TM", id: '6', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Madrone", lastName: "Cherry", id: '3', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Camellia", lastName: "N", id: '4', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "The", lastName: "Mandalorian", id: '5', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Satoshi", lastName: "Nakamoto", id: '6', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Michael", lastName: "Jeppesen", id: '0', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Andrew", lastName: "P", id: '1', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Xerical", lastName: "P", id: '2', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "D", lastName: "Darling", id: '7', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Ginger", lastName: "Sloth", id: '7', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Goose", lastName: "Berry", id: '8', mainAddress: SecondaryAccount.mainAddress),
  Contact(firstName: "Zooki", lastName: "Knee", id: '9', mainAddress: SecondaryAccount.mainAddress),
];
