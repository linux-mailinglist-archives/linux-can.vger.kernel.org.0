Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0476B0E1E
	for <lists+linux-can@lfdr.de>; Wed,  8 Mar 2023 17:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjCHQFZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Mar 2023 11:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjCHQFD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Mar 2023 11:05:03 -0500
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 08:03:35 PST
Received: from ix-euc1.prod.hydra.sophos.com (ix-euc1.prod.hydra.sophos.com [94.140.18.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D0618AA
        for <linux-can@vger.kernel.org>; Wed,  8 Mar 2023 08:03:31 -0800 (PST)
Received: from id-euc1.prod.hydra.sophos.com (ip-172-20-1-151.eu-central-1.compute.internal [172.20.1.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ix-euc1.prod.hydra.sophos.com (Postfix) with ESMTPS id 4PWxjd16nXzDWJ
        for <linux-can@vger.kernel.org>; Wed,  8 Mar 2023 15:55:33 +0000 (UTC)
Received: from ip-172-20-1-190.eu-central-1.compute.internal (ip-172-20-1-190.eu-central-1.compute.internal [127.0.0.1])
        by id-euc1.prod.hydra.sophos.com (Postfix) with ESMTP id 4PWxhc50GRzjWwm
        for <linux-can@vger.kernel.org>; Wed,  8 Mar 2023 15:54:40 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: 4b6ceeef51f549e7be24c4b39c6efc45
Received: from BEXBE02.christ.local
 (dslb-002-207-151-166.002.207.pools.vodafone-ip.de [2.207.151.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by relay-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4PWxhZ0yTxz7t8S; Wed,  8 Mar 2023 15:54:38 +0000 (UTC)
Received: from BEXBE02.christ.local (172.16.100.133) by BEXBE02.christ.local
 (172.16.100.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 16:54:37 +0100
Received: from BEXBE02.christ.local ([fe80::3d63:fa01:af7b:188d]) by
 BEXBE02.christ.local ([fe80::3d63:fa01:af7b:188d%3]) with mapi id
 15.01.2375.034; Wed, 8 Mar 2023 16:54:37 +0100
From:   "Fink, Peter" <pfink@christ-es.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
CC:     Ben Evans <benny.j.evans92@gmail.com>,
        =?utf-8?B?Q2hyaXN0b3BoIE3DtmhyaW5n?= <cmoehring@christ-es.de>,
        "Schartner, Alexander" <aschartner@christ-es.de>,
        Eric Evenchick <eric@evenchick.com>,
        Venelin Efremov <ghent360@iqury.us>
Subject: AW: candlelight CAN-FD TX echo
Thread-Topic: candlelight CAN-FD TX echo
Thread-Index: AQHZQuUWdCLcDT0jokCUOcYYFWkItK7xIUEw
Date:   Wed, 8 Mar 2023 15:54:37 +0000
Message-ID: <24224723ec0a48a8bde8abf682da7d31@christ-es.de>
References: <20230217153233.m2k4qcecux2up22k@pengutronix.de>
In-Reply-To: <20230217153233.m2k4qcecux2up22k@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.25.189]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678290877; 
 s=v1; d=mail-dkim-eu-central-1.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=9KAd+W1O+zpO4GkzIrEpeY4WDYusrnDo1dfHoOKnhPA=;
 b=W/kCSgbUNbCyAJmYShJdYsPoV6zGgtQJqkt3pYExIPsLNRKkr77cNTgZaj3JjSZ9
 kBT9FzSmyBqsJlQM9VFrqppOwCF/yWzcW+yHjVaZYUoWj4AHWwuqe4GoFAjxiqm1XB0
 YUWrblajlOvw05QPErVtesMVXux6k8yLYMJuPtEGicE80+ovdQR5b4IohBTnyDCJ7ju
 tvJ7bRXG7jqRwsT+6V0M08AdUgLz76Hz0rlfj9gNaW/l/G7b6XOJZV+VmwUCBCu9EFp
 zcJVFTic7p/YLfCGhcnWKWXwi3j/NAxPyFy5Ybxofewpnf6/XylRpFn5mEmT9oSi5t5
 Jvbn6R3WPg==
X-Sophos-Email: [eu-central-1] Antispam-Engine: 5.1.3,
 AntispamData: 2023.3.8.153018
X-LASED-SpamProbability: 0.085099
X-LASED-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_2000_2999 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_BASE64 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000, MSG_THREAD 0.000000,
 MULTIPLE_RCPTS 0.100000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
 SENDER_NO_AUTH 0.000000, SINGLE_URI_IN_BODY 0.000000, SUPERLONG_LINE 0.050000,
 SUSP_DH_NEG 0.000000, WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000,
 WEBMAIL_X_IP_HDR 0.000000, __ANY_URI 0.000000,
 __BANNER_TRUSTED_SENDER 0.000000, __BODY_NO_MAILTO 0.000000,
 __BOUNCE_CHALLENGE_SUBJ 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000,
 __CP_URI_IN_BODY 0.000000, __CT 0.000000, __CTE 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000, __FRAUD_URGENCY 0.000000,
 __FROM_NAME_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
 __HAS_REFERENCES 0.000000, __HAS_XOIP 0.000000, __IMP_FROM_MY_ORG 0.000000,
 __IMP_FROM_NOTSELF 0.000000, __IN_REP_TO 0.000000,
 __JSON_HAS_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_DOMAINS 0.000000,
 __JSON_HAS_TENANT_ID 0.000000, __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_VIPS 0.000000, __JSON_HAS_TRACKING_ID 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MSGID_32HEX 0.000000,
 __MULTIPLE_RCPTS_CC_X2 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_FROM_HOMEUSER 0.000000,
 __REFERENCES 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000,
 __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
 __SCAN_D_NEG_HEUR2 0.000000, __SINGLE_URI_TEXT 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_REPLY 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NAME 0.000000, __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
 __URI_ENDS_IN_SLASH 0.000000, __URI_HAS_HYPHEN_USC 0.000000,
 __URI_IN_BODY 0.000000, __URI_NOT_IMG 0.000000, __URI_NO_MAILTO 0.000000,
 __URI_NO_PATH 0.000000, __URI_NS 0.000000, __URI_WITHOUT_PATH 0.000000
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-MH-Mail-Info-Key: NFBXeGpkMTZuWHpEV0otMTcyLjIwLjEuNTA=
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KID4gSSdtIGN1cnJlbnRseSBhZGRpbmYgQ0FOLUZEIHN1cHBvcnQgdG8gdGhl
IENhbmRsZWxpZ2h0IGZpcm13YXJlIGFuZCBsb29raW5nDQo+IGF0IHRoZSBUWCBlY2hvIG1lc3Nh
Z2UgZnJvbSB0aGUgQ0FOIGRldmljZSB0byBMaW51eC4gSW4geW91ciBmaXJtd2FyZSBmb3INCj4g
Q0FOLUZEIGZyYW1lcywgYXJlIHlvdSBlY2hvaW5nIHRoZSB3aG9sZSBDQU4gRkQgc3RydWN0dXJl
IGdzX2hvc3RfZnJhbWUNCj4gd2l0aCA2NCBieXRlIGRhdGEsIG9yIHRoZSBjbGFzc2ljIENBTiBn
c19ob3N0X2ZyYW1lIHdpdGggOCBieXRlIGRhdGE/DQoNCkluIG91ciBmaXJtd2FyZSB0aGUgd2hv
bGUgNjQgYnl0ZSBkYXRhIGlzIGVjaG9lZCBiYWNrLg0KDQo+IFRoZSBDYW5kbGVsaWdodCBJIHVz
ZSBvbmx5IHdvcmtzIGluIGZ1bGwtc3BlZWQgVVNCICgxMiBNYml0L3MpIG1heCwgd2hpY2gNCj4g
bWVhbnMgdGhhdCB0aGUgbWF4aW11bSB0cmFuc21pc3Npb24gc2l6ZSBpcyA2NCwgd2hpY2ggcmVz
dWx0cyBpbiBhIFRYIGVjaG8NCj4gY29uc2lzdGluZyBvZiAyIFVTQiB0cmFuc21pc3Npb25zLiBU
aGUgTGludXggZHJpdmVyIG1ha2VzIG5vIHVzZSBvZiB0aGUgZGF0YQ0KPiBpbiB0aGUgVFggZWNo
byBmcmFtZSwgc28gYSBjbGFzc2ljIENBTiBUWCBlY2hvIHdvdWxkIHN1ZmZpY2UuDQoNCk91ciBk
ZXZpY2Ugc3VwcG9ydHMgVVNCIGhpZ2gtc3BlZWQgVVNCICg0ODBNYml0L3MpLg0KDQpCZXN0IHJl
Z2FyZHMsDQpQZXRlcg0KQ2hyaXN0IEVsZWN0cm9uaWMgU3lzdGVtcyBHbWJIDQpodHRwOi8vd3d3
LmNocmlzdC1lcy5kZS8NCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IEZyYW56IFJlaWNobGUNCkhhdXB0
c2l0ejogQWxwZW5zdHJhw59lIDM0LCA4NzcwMCBNZW1taW5nZW4NCkFtdHNnZXJpY2h0IE1lbW1p
bmdlbiBIUkIgOTEwMg0KDQpEaWVzZSBFLU1haWwgZW50aMOkbHQgdmVydHJhdWxpY2hlIHVuZC9v
ZGVyIHJlY2h0bGljaCBnZXNjaMO8dHp0ZSBJbmZvcm1hdGlvbmVuLiBXZW5uIFNpZSBuaWNodCBk
ZXIgcmljaHRpZ2UgQWRyZXNzYXQgc2luZCBvZGVyIGRpZXNlIEUtTWFpbCBpcnJ0w7xtbGljaCBl
cmhhbHRlbiBoYWJlbiwgaW5mb3JtaWVyZW4gU2llIGJpdHRlIHNvZm9ydCBkZW4gQWJzZW5kZXIg
dW5kIHZlcm5pY2h0ZW4gU2llIGRpZXNlIE1haWwuIERhcyB1bmVybGF1YnRlIEtvcGllcmVuIHNv
d2llIGRpZSB1bmJlZnVndGUgV2VpdGVyZ2FiZSBkaWVzZXIgTWFpbCBpc3QgbmljaHQgZ2VzdGF0
dGV0Lg0KVGhpcyBlLW1haWwgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZC9vciBwcml2aWxl
Z2VkIGluZm9ybWF0aW9uLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IChv
ciBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yKSBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRlc3Ryb3kgdGhpcyBlLW1haWwuIEFueSB1bmF1dGhvcmlz
ZWQgY29weWluZywgZGlzY2xvc3VyZSBvciBkaXN0cmlidXRpb24gb2YgdGhlIG1hdGVyaWFsIGlu
IHRoaXMgZS1tYWlsIGlzIHN0cmljdGx5IGZvcmJpZGRlbi4NCg==
