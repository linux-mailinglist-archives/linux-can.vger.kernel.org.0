Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237065A7A17
	for <lists+linux-can@lfdr.de>; Wed, 31 Aug 2022 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiHaJXN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Aug 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiHaJXI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Aug 2022 05:23:08 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 02:23:04 PDT
Received: from wx-euc1.prod.hydra.sophos.com (wx-euc1.prod.hydra.sophos.com [94.140.18.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661907C74A
        for <linux-can@vger.kernel.org>; Wed, 31 Aug 2022 02:23:04 -0700 (PDT)
Received: from wd-euc1.prod.hydra.sophos.com (ip-172-20-0-7.eu-central-1.compute.internal [172.20.0.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by wx-euc1.prod.hydra.sophos.com (Postfix) with ESMTPS id 4MHdpC1HmRzGDr
        for <linux-can@vger.kernel.org>; Wed, 31 Aug 2022 09:16:19 +0000 (UTC)
Received: from ip-172-20-0-127.eu-central-1.compute.internal (ip-172-20-0-127.eu-central-1.compute.internal [127.0.0.1])
        by wd-euc1.prod.hydra.sophos.com (Postfix) with ESMTP id 4MHdp839pMzsR5C
        for <linux-can@vger.kernel.org>; Wed, 31 Aug 2022 09:16:16 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: cd8d311a4dd94a4e997baf2b79a2b1de
Received: from BEXBE02.christ.local
 (dslb-002-207-151-166.002.207.pools.vodafone-ip.de [2.207.151.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by relay-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4MHdp30zGpz9rwJ; Wed, 31 Aug 2022 09:16:11 +0000 (UTC)
Received: from BEXBE02.christ.local (172.16.100.133) by BEXBE02.christ.local
 (172.16.100.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 31 Aug
 2022 11:16:10 +0200
Received: from BEXBE02.christ.local ([fe80::5d1a:c8fd:34c2:2b54]) by
 BEXBE02.christ.local ([fe80::5d1a:c8fd:34c2:2b54%3]) with mapi id
 15.01.2375.031; Wed, 31 Aug 2022 11:16:10 +0200
From:   "Fink, Peter" <pfink@christ-es.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     John Whittington <git@jbrengineering.co.uk>
Subject: AW: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Thread-Topic: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Thread-Index: AQHYumOUcR13cv//O0qJSChMAB+XWK3IuTbw
Date:   Wed, 31 Aug 2022 09:16:10 +0000
Message-ID: <0455cdf16ab7430291b2691f3f00854a@christ-es.de>
References: <20220827221548.3291393-1-mkl@pengutronix.de>
 <20220827222253.2r7nydujnquubsgy@pengutronix.de>
In-Reply-To: <20220827222253.2r7nydujnquubsgy@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.25.64]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661937370; 
 s=v1; d=mail-dkim-eu-central-1.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=8CewSbRt6SeVJvHCft+zuKtq+C2K2ljHNYmBz07O6L8=;
 b=USFVgLTm3RkXNcM8oGdIofrKig1O72BYCjaUFVCfftHHPIGUJ4gK4US+syialkTK
 Q7GObUd2rr2dEngqACwHoZZeMRIC1J0ng3stsaVDUzZLvjYLBdyRWGe1mcRECI9asbv
 ecGlddHxITftFo1buWP4b9jRUETMgFfT2Vx6ys0y0JxFVExJWySTfhos6tQjJixyVmo
 cWlnu3vezQ0ef0SCsBsrn08RfQhHMczJViCiVciTllMbVlMzQLtK4rV9tkkOmCtCJj6
 l2j+YnBdNXt/PHM+6knc1cAZJW6Ic+J62mADwo2EtXa0WnEFcfjFkWcRC1yx3RFTbW3
 GJryvzP45g==
X-Sophos-Email: [eu-central-1] Antispam-Engine: 5.1.1,
 AntispamData: 2022.8.31.85118
X-LASED-SpamProbability: 0.081286
X-LASED-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_2000_2999 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_BASE64 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000, MSG_THREAD 0.000000,
 NO_FUR_HEADER 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
 REFERENCES 0.000000, SENDER_NO_AUTH 0.000000, SUPERLONG_LINE 0.050000,
 WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000, WEBMAIL_X_IP_HDR 0.000000,
 __ANY_URI 0.000000, __BEC_PHRASE 0.000000, __BODY_NO_MAILTO 0.000000,
 __BOUNCE_CHALLENGE_SUBJ 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000,
 __CP_URI_IN_BODY 0.000000, __CT 0.000000, __CTE 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000, __FRAUD_CONTACT_NUM 0.000000,
 __FRAUD_REFNUM 0.000000, __FROM_NAME_NOT_IN_BODY 0.000000,
 __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
 __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000, __HAS_XOIP 0.000000,
 __HTTPS_URI 0.000000, __IMP_FROM_MY_ORG 0.000000, __IMP_FROM_NOTSELF 0.000000,
 __IN_REP_TO 0.000000, __JSON_HAS_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_DOMAINS 0.000000, __JSON_HAS_TENANT_ID 0.000000,
 __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_VIPS 0.000000,
 __JSON_HAS_TRACKING_ID 0.000000, __MAIL_CHAIN 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MSGID_32HEX 0.000000,
 __MULTIPLE_RCPTS_TO_X2 0.000000, __MULTIPLE_URI_TEXT 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_SPEAR_SUBJ_TEAM 0.000000,
 __REFERENCES 0.000000, __RUS_OBFU_PHONE 0.000000, __SANE_MSGID 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_REPLY 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NAME 0.000000, __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
 __URI_ENDS_IN_SLASH 0.000000, __URI_HAS_HYPHEN_USC 0.000000,
 __URI_IN_BODY 0.000000, __URI_NOT_IMG 0.000000, __URI_NO_MAILTO 0.000000,
 __URI_NO_PATH 0.000000, __URI_NS 0.000000, __URI_WITHOUT_PATH 0.000000
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-MH-Mail-Info-Key: NE1IZHBDMUhtUnpHRHItMTcyLjIwLjAuODc=
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KY3VycmVudGx5IENBTmV4dCBGRCBkb2VzIG5vdCBzdXBwb3J0IHRpbWVzdGFt
cHMuDQpXZSBhbHNvIGhhdmUgbm8gYWN0aXZlIHBsYW5zIG9uIGFkZGluZyB0aW1lc3RhbXAgc3Vw
cG9ydCwgYnV0IEkgd291bGRuJ3QgcnVsZSBpdCBvdXQgY29tcGxldGVseSB0aGF0IHRoaXMgbWln
aHQgY29tZSB1cCBhdCBzb21lIHBvaW50IGFuZCB3ZSB3aWxsIGFkZCBpdC4NCg0KQmVzdCByZWdh
cmRzLA0KUGV0ZXINCg0KPiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IEJl
dHJlZmY6IFJlOiBbUEFUQ0ggdjMgMC8yXSBjYW46IGdzX3VzYjogaGFyZHdhcmUgdGltZXN0YW1w
IHN1cHBvcnQNCj4NCj4gQWRkaW5nIFBldGVyIGFuZCBDaHJpc3RvcGggb24gQ2MuDQo+DQo+IE9u
IDI4LjA4LjIwMjIgMDA6MTU6NDYsIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOg0KPiA+IGFmdGVy
IG5vdGljaW5nIHRoYXQgdGhlIGdzX3VzYiBmaXJtd2FyZSBzZW5kcyB0aW1lc3RhbXBzIG9uIHRo
ZSBUWCwNCj4gPiB0b28sIEkgdXBkYXRlZCB0aGUgZHJpdmVyIGFuZCBzcXVhc2hlZCB0aGUgMm5k
IHBhdGNoLiBBbHNvIGFkZGVkDQo+ID4gcHJvcGVyIGVuZGlhbm5lc3MgaGFuZGxpbmcgdG8gZ3Nf
dXNiX2dldF90aW1lc3RhbXAoKS4gSSBhbGxvd2VkIHRvIGFkZA0KPiA+IG15c2VsZiBhcyBDby1k
ZXZlbG9wZWQtYnkuDQo+DQo+IFBldGVyLCBDaHJpc3RvcGgsIGRvZXMgdGhlIENFUyBDQU5leHQg
RkQgc3VwcG9ydCB0aW1lc3RhbXBzPyBBcmUgeW91DQo+IHBsYW5pbmcgdG8gYWRkIFRTIHN1cHBv
cnQ/DQo+DQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4NCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAg
ICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBFbWJlZGRl
ZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlICB8
DQo+IFZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEtMjgy
Ni05MjQgICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAg
KzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KQ2hyaXN0IEVsZWN0cm9uaWMgU3lzdGVtcyBHbWJIDQpo
dHRwOi8vd3d3LmNocmlzdC1lcy5kZS8NCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IEZyYW56IFJlaWNo
bGUNCkhhdXB0c2l0ejogQWxwZW5zdHJhw59lIDM0LCA4NzcwMCBNZW1taW5nZW4NCkFtdHNnZXJp
Y2h0IE1lbW1pbmdlbiBIUkIgOTEwMg0KDQpEaWVzZSBFLU1haWwgZW50aMOkbHQgdmVydHJhdWxp
Y2hlIHVuZC9vZGVyIHJlY2h0bGljaCBnZXNjaMO8dHp0ZSBJbmZvcm1hdGlvbmVuLiBXZW5uIFNp
ZSBuaWNodCBkZXIgcmljaHRpZ2UgQWRyZXNzYXQgc2luZCBvZGVyIGRpZXNlIEUtTWFpbCBpcnJ0
w7xtbGljaCBlcmhhbHRlbiBoYWJlbiwgaW5mb3JtaWVyZW4gU2llIGJpdHRlIHNvZm9ydCBkZW4g
QWJzZW5kZXIgdW5kIHZlcm5pY2h0ZW4gU2llIGRpZXNlIE1haWwuIERhcyB1bmVybGF1YnRlIEtv
cGllcmVuIHNvd2llIGRpZSB1bmJlZnVndGUgV2VpdGVyZ2FiZSBkaWVzZXIgTWFpbCBpc3Qgbmlj
aHQgZ2VzdGF0dGV0Lg0KVGhpcyBlLW1haWwgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZC9v
ciBwcml2aWxlZ2VkIGluZm9ybWF0aW9uLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVj
aXBpZW50IChvciBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yKSBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRlc3Ryb3kgdGhpcyBlLW1haWwuIEFueSB1
bmF1dGhvcmlzZWQgY29weWluZywgZGlzY2xvc3VyZSBvciBkaXN0cmlidXRpb24gb2YgdGhlIG1h
dGVyaWFsIGluIHRoaXMgZS1tYWlsIGlzIHN0cmljdGx5IGZvcmJpZGRlbi4NCg==
