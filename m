Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613F84BDDB5
	for <lists+linux-can@lfdr.de>; Mon, 21 Feb 2022 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352890AbiBUKFJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Feb 2022 05:05:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352224AbiBUKE2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Feb 2022 05:04:28 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A545131C
        for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022 01:29:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKarXoHh+OYM/IU+znoaOoSCik3s+mK4LMqW1r8JB9PshHmElY3ZOn4AF6VtJXF1WHjJsNbsyRZxQmyui7IcjReyAuqznF3SahZWzm3yJJxSdOTM9KzeTqAn7jNhlYzVuxZYRIMl0o+nxHoAp0JM68y1GqPC42xXuKCXa5Znb6qy4O6IqDYJbpFIBDURq8IkBhBOEmYevphqkg2v2e84srizpU+R1STiawh0ZbcRqUxStC5MNHpmT143T44y3qRlR7r7YR8az+VJJOa3arPg0cycM2J30QAU4tE7Ufh+4L+HDxXFMgoihdgkK0tvKxcOrklF1mMLLIT1ZIPnso0HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xH446WG6aEldbLicukGixyJ0Ge8hinepiOYpfU9vWc=;
 b=g1EMztGZuAwkzMZQRrQzZ7/5d2HdiDTRAvSanOjX4fjaCBi0LuRiQQZdyQQxTPpxinoLqjzaW7AfP4hUSJE5ew/7rsucwf2teqk742LVEEiB2m9C3m04Njql5Jh+UYUlL/uNnsGEHVLBScwrWp0UYHuCDXsd9WVhCgjrDb320ja6KVo1PBXGsG4yujCoaeilhdWFkgpKTFlcJzoYYFgs/MkmxqNMAIOg1vZvVKUAjIhclPwabMlW0UCWAFNZeiaZBqhTivQId37mRjXZL4hvnVjd38nuoFhmUcM/3Cfbpjv8C7PC78qAoze1y3XARkewgqAHMC/1g2wL6odzMrIPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xH446WG6aEldbLicukGixyJ0Ge8hinepiOYpfU9vWc=;
 b=sFhndHtZidcfVc8OUb2UJ0hk+bgPJKatqqc1QYHEh1FMoT/7JvJDFNGcuYhzLTABaYOi+JOlRuQwu8/iKFDjkQ5oD5o+GkiMjtMiL8lDSBR6+DZHAT7BF3ZTCqqsgNnb08dKtdoQyYhfSB63QWIA3PLw/njXvjvkNkYi1xd9kIw=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by VE1PR03MB5743.eurprd03.prod.outlook.com (2603:10a6:803:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Mon, 21 Feb
 2022 09:29:55 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::3460:fc17:db04:a018]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::3460:fc17:db04:a018%7]) with mapi id 15.20.4995.016; Mon, 21 Feb 2022
 09:29:55 +0000
From:   =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Thread-Topic: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Thread-Index: AQHYJwIL1m3wS4zZTUumITpN1+oOHA==
Date:   Mon, 21 Feb 2022 09:29:55 +0000
Message-ID: <PA4PR03MB67970BDE7AB5545F3425264AD63A9@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: a8c46a83-9e9d-16ff-ffa4-3e16497b838e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 507c525a-4f4b-4be1-3b92-08d9f51cb872
x-ms-traffictypediagnostic: VE1PR03MB5743:EE_
x-microsoft-antispam-prvs: <VE1PR03MB5743110051ABF3F84055CE2BD63A9@VE1PR03MB5743.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxLlLQrrMRBRBWPQsYlbalDehv1wOUMXayQABLhlD4FJ7sh3egCdA3zuPEWdm45ot8bJP6IVjzWlf+ckauQ3REDgq+MR604qwnvx8GRWnLKAotELtxMxwj42GpcvNKOCTRRCxZJN3Iq7b0Xotqy1QLWBoEDqsksqOM07Dcq0ItuUOv0kt5/IG8ql5rKf7CyxiK8yaBvDDHSstUcCsrRDuXCHL2b4oyaC+t/jk/h43DZpTkjcJVFC9/HSCgMI1+U+JWv8ZA/dzEYUnI3FYbSe3CamSThiW+03HFFE4OFnWRW4ohHDFgISMRC3Bz+y+8rHTjfvHpbh0HSAnc+/ASJ0GIb3vpnPNuUOg3RlSjD4qkC5BcmiME1Htxnjjjgu7g2utZlFE1uQ3Jh2RgTO8gEXlD9ySrKBcvUAoph29/9o4yQpy2xReTOQ8c+GF6doAmhfS535+NKvCh+gikh+YdZl+MO3VG19yW//F3xy8xf/X/hGtRdn0/bt8h8RFR5Il24oQ10EqVmalP3Axx6fv9NTnf+/4nWlHg4t2kLR46P0Z0jjV3ScPxbb2T3y282QuRmDHOz73tHiDb6hCJ60KQOvSWpvmk7L/pJAHkfFZrqn1DLlKJONlnlnf9OJZBZ4bncXPaR/c13LIJc0rkRd19c8qrot9MkrDPbO+/XCe1wmnIEA+pU6rFkP57FKGlHNQlIvrAV4iLjDghRYEsubWZTFB07iOyo1HxGGXRGYaQMs2YJFf6B3Y/8Q8CLsqXC/3hNu3nx/aRad9ka2H2wOQDkgJzdZ4iY7DgtnXs63FjhEVPA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39840400004)(136003)(366004)(396003)(346002)(64756008)(66946007)(66476007)(66446008)(66556008)(76116006)(8676002)(4326008)(2906002)(83380400001)(15974865002)(33656002)(38100700002)(5660300002)(52536014)(53546011)(6506007)(7696005)(8936002)(186003)(966005)(122000001)(9686003)(71200400001)(26005)(55016003)(86362001)(66574015)(6916009)(508600001)(85182001)(85202003)(38070700005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJudzdIY2Q1Vzc4Z0hXbnB0Yk1IcjZZVEJQTFBtQkFnQzBiS1JGSDRZZVlK?=
 =?utf-8?B?ZlNnZytmQmtYQ1FMZHZ5am1acE9uVDZCMG0rY2l3VHBac1VHRUt2MzBMZ3Q3?=
 =?utf-8?B?SHBvSVFKaFNkSlk4WER4NGtBY3JNdyt6UURUUy85VlltLzNRUVpCdFFqMEc0?=
 =?utf-8?B?S3prRi9RWktRdVVJWm5IdG9kb0VXdnVtbHJiZHdwRmhFZVZUT1R3SVlpT2t3?=
 =?utf-8?B?SmhUak5HWlJidkErcjN5Q1JUMlpadGhpTWkvbnEzVmFRQkVHRlpqeU9HKzhN?=
 =?utf-8?B?eS9oa0tHZ3dPaDNNbWxxVTVJZEh1QWtBckpRVE84Q2VGZXRLMzVRMlNvcXpM?=
 =?utf-8?B?a1BrZzVtSCtSeTZEU3VkUC9UcG5GbkhQVjZSWHlsb09lVHJxWUV6MmFZamZn?=
 =?utf-8?B?NDJSUlo1ZE91dEJPTTNhRmpqQUxVb0hmSk9ROFZaU0tsMllHd2t1OSsrU21W?=
 =?utf-8?B?QWZaRnZVQloralBuQ29ZTHgvR0hoMFhGcWd5OXQ2UG1ha0czaWR1RzhSYTZL?=
 =?utf-8?B?U2N5eXlaNTNJN0dOdTBJYjEyWXVISlcxakVybmQ1WXVLL2xjMFNmTFFhUGNv?=
 =?utf-8?B?RHF4UnAwU0llT2RjRExKU293Zlk5WTRnZmdaalZSRmw5VW5SdGNGL00yTlFt?=
 =?utf-8?B?bzlub2F2WnhWMjViV2hyWUczS2s4dVV1MENhenlQT2V2TnZ1QnNwM05RU3Y1?=
 =?utf-8?B?TzY2N2RVaGZVRkdlRmpFQ0hCRkF1a200VVZDNU82TGNlcGJEbDVXU0p5ODIy?=
 =?utf-8?B?Q3Z1NzI0MjIwby90eGxMNlFpZFpTVzAvUjBvV2xxWVI1Smd4ZnM3eE9aREZz?=
 =?utf-8?B?QWR4M1dnV3NyTzJNMVdUaTBaaFhyK0Q0aDU0UWV0dGZ2bGdwU0Y0cUlHRkVS?=
 =?utf-8?B?ejhselpJdk9PVnZWLzhnL0htUDBTbGE2ZzViK096Qm91SEVJU0JJYjVWV1hj?=
 =?utf-8?B?Mjd4NGNDZWorMzZqMHFXZWlVUWd5dTB5QTQycHFLdWhiK09rZWQ5SFVmdktD?=
 =?utf-8?B?bkZkWGxVc2FLODZpZ3dqWDl0WHkxS0o0ZjZWTGpMUzlyNmZUVnVPTDJYYjFV?=
 =?utf-8?B?U2ZlTnI2THNyLzliUlZ5WElEQzkvNFFzZEpnZG43UnI1WEpIVDVrSTMrUThz?=
 =?utf-8?B?WWRNbHdXV1gvbGdNbWxsUDlEby83cGVvZzdMdEpsT25qa3J0TEt2TG01alRR?=
 =?utf-8?B?QTVSN283WjI0QXgrdmtIU0Nwb2JDa2Q3aWlCQy9uU3N6cnpsdEdiQUhUSXRX?=
 =?utf-8?B?Z3VkK2l2cnZEaitMbDlGdDNNVlVPN3pzdUhQcDJzdUx2UGlLNmFGUjhJSWlS?=
 =?utf-8?B?bEkyNVh3VmxKWFFxc1dzMktMK3hNQWZIQ1lCVkZaTDlCSWI0eWhST2VsZURq?=
 =?utf-8?B?RjNyYjFPRGdkVSs1L0lrZWxBT1hXZmVVTzh4NWgwM1FPYytXdzFWaTRIa2tG?=
 =?utf-8?B?ck5HSHVxczZ6WStieXdrOWkvQmdnNysySmIvL05pWFllSXRqWHZ1RVhrbVZP?=
 =?utf-8?B?QjdmTGc1S0Y3anQ3RE0vODFEaWUxVTN0c2FrY1NjeURTbG5USGxSUkJPMnph?=
 =?utf-8?B?SkkzVFEvYng0MERiejVsNFluM2JZYmZHQXQxdkN0UjByaEpPS2JOczFJaStY?=
 =?utf-8?B?Kytsd1luLy9CcFNVK1NZaGZjdG9wYlBsMVZTc3FGSUd2S294Vm81L1UvVHhK?=
 =?utf-8?B?YWVoY0hWSm0wWGZocm92WVQ4U2t4d1M1aW1JOXBZa3dsYnZPaTlsaGQ4VzVo?=
 =?utf-8?B?dFhRekt4ZWU4cklKdmhtVlNHSGc2V0RpQmN0WC90NytFcURXYXBMc29FYWNP?=
 =?utf-8?B?WWxieTlmT2dERjRJRVlwaWxRQVpsTmZ4dUdRalZWYmo0ckNsaW5qS0hEUzVy?=
 =?utf-8?B?Mk1GenhVbDVzTDBteEcyQVd5SkFHVVdMSy9IU2lmMytaUmxIeE9hcmN4d2c5?=
 =?utf-8?B?UDFXUE9MbGVlOURiWVl1K0NLK2dJLzk5K1MwVkliMGdvcTdrSXlBdWFnckZY?=
 =?utf-8?B?clU2ZEFIWEM1WUxrcERubFkyUmowaEw5MVJuRTlPRGZoejZqMVZ3TDhxV25V?=
 =?utf-8?B?M0dpdEllUk9oZ25DUWJIN0dXSFdjQlJwc2c1NHVlR1NlWkNOZDVmM0RGcVl4?=
 =?utf-8?B?clkzeW1iTmQ1UWpPSm5CYm9kRlRjOEpjdXAvMWsrbnZlaUV1alVTelIyNjNG?=
 =?utf-8?B?ckk2RUtlaTZoSS9zM3FnbUFXWFZCRTFpQ3IwU3lIMnN3MHBLM1pmSmllUmx2?=
 =?utf-8?B?aG5tdDNSUk5WU1Z1TExlcjJtQU5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507c525a-4f4b-4be1-3b92-08d9f51cb872
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 09:29:55.1237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11pQvMD5HLSMZWTrYVnle+yl9IX7bFHxqnz5rqWC1lcHKHeW8z8RKXTFwDsRe/1ZG2H9TE1BV891zQ7tmRLCd6q6LGDBHUYas5z4/DD0xw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5743
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KPk9uIDE1LjAyLjIwMjIgMTY6MTA6NDUsIE1hcmMgS2xlaW5lLUJ1ZGRlIHdy
b3RlOg0KPj4gT24gMTEuMDIuMjAyMiAxMDo1NzozNCwgU3TDqXBoYW5lIEdyb3NqZWFuIHdyb3Rl
Og0KPj4gPiBlbmRpYW5lc3MgaXMgaGFuZGxlZCBieSBsb3dlciBsZXZlbCBmdW5jdGlvbnMgKHNl
ZSBmb3IgZXgNCj4+ID4gcGNhbl91c2JfZmRfZ2V0X3VzZXJfZGV2aWQoKS9wY2FuX3VzYl9mZF9z
ZXRfdXNlcl9kZXZpZCgpIGluIFBBVENIDQo+PiA+IDIvNikuDQo+PiA+DQo+PiA+IFRoaXMgZGF0
YSBpcyByZWFsbHkgYSBudW1iZXIgYW5kIG11c3QgYmUgdHJlYXRlZCBhcyBzdWNoLg0KPj4NCj4+
IFdoYXQncyB0aGUgdXNlIGNhc2UgZm9yIHRoZSBkYXRhL251bWJlcj8gV2hhdCdzIHRoZSBiaWcg
cGljdHVyZT8NCg0KPnwgSmFuIDAxIDA1OjE2OjIxIERpc3Ryb0tpdCBrZXJuZWw6IHBlYWtfdXNi
IDEtMToxLjA6IFBFQUstU3lzdGVtIFBDQU4tVVNCIEZEIHYxIGZ3IHYzLjIuMCAoMSBjaGFubmVs
cykNCj58IEphbiAwMSAwNToxNjoyMSBEaXN0cm9LaXQga2VybmVsOiBwZWFrX3VzYiAxLTE6MS4w
IGNhbjA6IGF0dGFjaGVkIHRvIFBDQU4tVVNCIEZEIGNoYW5uZWwgMCAoZGV2aWNlIDExNDQyMDE3
NDUpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5e
Xl5eDQoNCj5CdXQgdGhhdCBpcyBzb21ldGhpbmcgZGlmZmVyZW50IHRoYW4gdGhlIHNlcmlhbCBu
dW1iZXIsIHJpZ2h0Pw0KDQpZZXAhIFRoaXMgaXMgYSBudW1iZXIgdGhhdCBjYW4gYmUgdXNlZCB0
byB1bmlxdWVseSBpZGVudGlmeSB0aGUgZGV2aWNlLCByZWdhcmRsZXNzIG9mIHRoZSBVU0IgcG9y
dCBvciB0aGUgb3JkZXIgaW4gd2hpY2ggaXQgaXMgY29ubmVjdGVkLiBUaGUgcHVycG9zZSBpcyB0
byBhbGxvdyB0aGUgdXNlciB0byBuYW1lIHRoZSBuZXR3b3JrIGludGVyZmFjZSBhY2NvcmRpbmcg
dG8gdGhpcyBudW1iZXIuIFRoaXMgaXMgZm9yIGV4YW1wbGUgd2hhdCBpcyBkb25lIGJ5IHRoZSAi
aGlzdG9yaWNhbCIgZHJpdmVyICJwY2FuIiB3aGljaCBpcyBmcmVlbHkgZG93bmxvYWRhYmxlIGZy
b20gd3d3LnBlYWstc3lzdGVtLmNvbS4NCg0KPk9uIGEgbGl0dGxlIGVuZGlhbiBzeXN0ZW0gdGhp
cyBnaXZlczoNCj4NCj58IOKenCAocHRzLzApIGZyb2dnZXJAcnBpNGI0On4gKG1hc3Rlcikgc3Vk
byBldGh0b29sIC1lIGNhbjANCj58IE9mZnNldCAgICAgICAgICBWYWx1ZXMNCj58IC0tLS0tLSAg
ICAgICAgICAtLS0tLS0NCj58IDB4MDAwMDogICAgICAgICAxMSAyMiAzMyA0NA0KPg0KPk9uIGEg
YmlnIGVuZGlhbiB3ZSBzZWU6DQo+DQo+fCByb290QERpc3Ryb0tpdDp+IGV0aHRvb2wgLWUgY2Fu
MA0KPnwgT2Zmc2V0ICAgICAgICAgICAgICAgIFZhbHVlcw0KPnwgLS0tLS0tICAgICAgICAgICAg
ICAgIC0tLS0tLQ0KPnwgMHgwMDAwOiAgICAgICAgICAgICAgIDQ0IDMzIDIyIDExDQoNCkkgYWRt
aXQgdGhhdCBpdCBpcyBxdWl0ZSBkaXN0dXJiaW5nIGluZGVlZCB0byBpbWFnaW5lIHRoYXQgMHgx
MSBpcyBub3QgbmVjZXNzYXJpbHkgaW4gZWVwcm9tWzBdLi4uIEJ1dDoNCg0KPnwgcm9vdEBEaXN0
cm9LaXQ6fiBldGh0b29sIC1lIGNhbjAgcmF3IG9ufGhleGR1bXAgLXYgLWUgJzEgIiV1XG4iJw0K
PnwgMTE0NDIwMTc0NQ0KPnwg4p6cIChwdHMvMCkgZnJvZ2dlckBycGk0YjQ6fiAobWFzdGVyKSBz
dWRvIGV0aHRvb2wgLWUgY2FuMCByYXcgb258aGV4ZHVtcCAtdiAtZSAnMSAiJXVcbiInDQo+fCAx
MTQ0MjAxNzQ1DQoNCmlzIHRoZSBnb2FsOiBjYW4gaW50ZXJmYWNlIG5hbWUgd2lsbCBiZSB0aGUg
c2FtZSBpbiBib3RoIHN5c3RlbXMuDQoNCkluIGFueSBjYXNlLCB0aGFua3MgZm9yIHRoZSB0ZXN0
cy4NCg0KLS0tIFN0ZXBoYW5lDQoNCg0KICAgICAgICAgICAgRGU6IE1hcmMgS2xlaW5lLUJ1ZGRl
DQpFbnZvecOpOiBNZXJjcmVkaSAxNiBmw6l2cmllciAyMDIyIDEwOjUxDQrDgDogU3TDqXBoYW5l
IEdyb3NqZWFuDQpDYzogbGludXgtY2FuIE1haWxpbmcgTGlzdA0KT2JqZXQ6IFJlOiBbUEFUQ0gg
Ni82XSBjYW46IHBlYWtfdXNiOiBhZGQgZXRodG9vbCBpbnRlcmZhY2UgdG8gdXNlciBkZWZpbmVk
IGZsYXNoZWQgZGV2aWNlIG51bWJlcg0KDQoNCg0KDQpPbiAxNS4wMi4yMDIyIDE2OjEwOjQ1LCBN
YXJjIEtsZWluZS1CdWRkZSB3cm90ZToNCg0KPiBPbiAxMS4wMi4yMDIyIDEwOjU3OjM0LCBTdMOp
cGhhbmUgR3Jvc2plYW4gd3JvdGU6DQoNCj4gPiBlbmRpYW5lc3MgaXMgaGFuZGxlZCBieSBsb3dl
ciBsZXZlbCBmdW5jdGlvbnMgKHNlZSBmb3IgZXgNCg0KPiA+IHBjYW5fdXNiX2ZkX2dldF91c2Vy
X2RldmlkKCkvcGNhbl91c2JfZmRfc2V0X3VzZXJfZGV2aWQoKSBpbiBQQVRDSA0KDQo+ID4gMi82
KS4NCg0KPiA+DQoNCj4gPiBUaGlzIGRhdGEgaXMgcmVhbGx5IGEgbnVtYmVyIGFuZCBtdXN0IGJl
IHRyZWF0ZWQgYXMgc3VjaC4NCg0KPg0KDQo+IFdoYXQncyB0aGUgdXNlIGNhc2UgZm9yIHRoZSBk
YXRhL251bWJlcj8gV2hhdCdzIHRoZSBiaWcgcGljdHVyZT8NCg0KDQoNCnwgSmFuIDAxIDA1OjE2
OjIxIERpc3Ryb0tpdCBrZXJuZWw6IHBlYWtfdXNiIDEtMToxLjA6IFBFQUstU3lzdGVtIFBDQU4t
VVNCIEZEIHYxIGZ3IHYzLjIuMCAoMSBjaGFubmVscykNCg0KfCBKYW4gMDEgMDU6MTY6MjEgRGlz
dHJvS2l0IGtlcm5lbDogcGVha191c2IgMS0xOjEuMCBjYW4wOiBhdHRhY2hlZCB0byBQQ0FOLVVT
QiBGRCBjaGFubmVsIDAgKGRldmljZSAxMTQ0MjAxNzQ1KQ0KDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl4NCg0KDQoNCkJ1dCB0aGF0IGlzIHNv
bWV0aGluZyBkaWZmZXJlbnQgdGhhbiB0aGUgc2VyaWFsIG51bWJlciwgcmlnaHQ/DQoNCg0KDQpy
ZWdhcmRzLA0KDQpNYXJjDQoNCg0KDQotLQ0KDQpQZW5ndXRyb25peCBlLksuICAgICAgICAgICAg
ICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQoNCkVtYmVkZGVkIExpbnV4ICAg
ICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgIHwNCg0KVmVydHJl
dHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAg
fA0KDQpBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0y
MDY5MTctNTU1NSB8DQoNCg0KLS0NClBFQUstU3lzdGVtIFRlY2huaWsgR21iSA0KU2l0eiBkZXIg
R2VzZWxsc2NoYWZ0IERhcm1zdGFkdCAtIEhSQiA5MTgzDQpHZXNjaGFlZnRzZnVlaHJ1bmc6IEFs
ZXhhbmRlciBHYWNoIC8gVXdlIFdpbGhlbG0NClVuc2VyZSBEYXRlbnNjaHV0emVya2xhZXJ1bmcg
bWl0IHdpY2h0aWdlbiBIaW53ZWlzZW4NCnp1ciBCZWhhbmRsdW5nIHBlcnNvbmVuYmV6b2dlbmVy
IERhdGVuIGZpbmRlbiBTaWUgdW50ZXINCnd3dy5wZWFrLXN5c3RlbS5jb20vRGF0ZW5zY2h1dHou
NDgzLjAuaHRtbA0K
