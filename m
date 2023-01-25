Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25967B28A
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 13:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjAYMYH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 07:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjAYMXq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 07:23:46 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2061.outbound.protection.outlook.com [40.107.135.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3FAD21
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 04:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyGFiRQ9BrtQVL4N9G227JAWiOaDCKDK++zBa0rJR+5Lbme1Wqo/OCqNrfW6EfXS6q0V3nx2Iv2R/sPOGU4MJKCIyGVJp4nWMDgeBP2btukARHSkzvs2V2t48sTHRQ2IvYsglgiirH335PX1d7pLQqFzn/Y1sIJriiqJLLvmR3mPCsENJirl9tQthe61N6RKvU3Vzjciu78ivk5icTbi6Q+TW8CgPDbOlknx9BrjHlK+qkdOdPn072nm/KUyrIAQoT9ROYYFuDdeXz0+LcL4JAMZoIh+aAOXFZC0Q3Elz5gtA/NQfOOrAh4IUbZESCrtIxHClBbYIHIN7//tCKTOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3bBIrCB893OdGR6JY8OmymDhUydTLlecMxvlmbC+Sg=;
 b=WQeS1vk5rtDUrqfHxkj0QBS6Eaxy/jsagYxEt2Fg2hxfkxbATzIO3LYE6wGAtKXLOYUdc87+8XBaK4OTDhTj4yCvN1mCpD3nCyvvMnxFWyC1SbcQFiq4ef1fdCQmg2Sl4D2Wlmm1VAQgh6ygwbr/72L0m/0gMDDKPGIznKNDNlFF6f1wHZ9oNyhY9+5Kn1PrGpW9LOMbJoQwaHu8jsLNsZude0f5PEc/mGhFS/YSUwPokomRCOiIT2pc6x3Ev5DamrzlPKYH+O6zSqI34fsgzxm8IEo+6HRhx09BpIgqw1rfvlQL0KDYgEmT9B/xTNYkugtQ9HIHw5pbLjx7VD/FfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3bBIrCB893OdGR6JY8OmymDhUydTLlecMxvlmbC+Sg=;
 b=Gu4jnJtlfhi3VTxqRPkaBSsdsmt4hWLrVZvIeh7+undwEtsqJSLZEvsvOLURs+yS+xP4blGxP2UCyB3OD5E/oT9bWCy8s+dt0DcmcJNE43ydOT6nGAusWOu1A52dknc2WBcXGdBq9JNWay2fFOpm7n/0Z9HEONGYgc34n+FXgg0=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FRYP281MB2939.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:70::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 12:23:42 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fa47:ffd4:d4ca:76e1]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fa47:ffd4:d4ca:76e1%7]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 12:23:42 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: mcp251xfd diagnostic outputs
Thread-Topic: mcp251xfd diagnostic outputs
Thread-Index: AdkpmEHpRWOQFWjcTmGQ7GHYJqGrXQHHH0IAAAB6FKA=
Date:   Wed, 25 Jan 2023 12:23:42 +0000
Message-ID: <FR0P281MB19669E0121CECA3B9C0C7E6497CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <FR0P281MB1966B647014B87F9EA96E77197C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230125120124.yfqwnvg72uk5rbvv@pengutronix.de>
In-Reply-To: <20230125120124.yfqwnvg72uk5rbvv@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FRYP281MB2939:EE_
x-ms-office365-filtering-correlation-id: 5336fe4d-f220-4105-976b-08dafeceff5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8JCqeOt9rOrp0U1s1EebWXsG/iwAaORuIFMuwgJ65i4hYQZwgRjuAOjTYMelbgq0vwURNuLb4R/eFQ5m81xQIK6bjNQE5lrQ7MMxJuA34erELVCDo6VisH/6R2zenZ+up2dwpY0werfBggAj3hyqfCpvOGqbU6bfXcIjKKjivQSt2R3HeVQAaOUxO2Rkso5xscntfAdvPCQZe5I+CRreAEJ2Cym6AvtfHo9VJa7YVY7rj2Bb88gqLA0VYYUSBv4s5JGAV8IfV03gnh8u2p6KLVxsGFEFrs+7GwY51ouHhWqvR9ehaQMCT/8gJly6thT2PqT9+MCZz/JM0fIgXDJwvnAhiYMPq9haSvf4kyPv3AItAeVnxeUQt6I1LQQy35BvrCBdD/X8ixh0qG8Uz5ySUKn0+nR/M6rufZUukhts1VNyuarZZWVw/KUNsv3Toz96uxiPRlFYWTOAA/insfP3iQgJKp0lLDa4j+x6vr60AnOLDeV7mp7ox9i0d8yBev7uYzAO/YiJOEMWEnpk1MpRVtPFITB251I/Hx77mQLlhb9nQOAta6w99XbZqdXAXAtOlorIeQUHkR+lcJ4fOTV8NTC4O5qSh4t42cAjPzapREMrfEQP2YBnLZ0qyJY8i546PYGlGWBw1nVr35vBhTk6Sp5UKG1RJbwJM3pBFSPJ3tfg0UmzSstLVfGfscmPF7Q2VRZ9Vx9bX5znTkkXgNHzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(396003)(39840400004)(451199018)(33656002)(38100700002)(122000001)(6916009)(66556008)(66446008)(64756008)(478600001)(8676002)(186003)(66476007)(71200400001)(9686003)(38070700005)(76116006)(85202003)(66946007)(85182001)(7696005)(55016003)(4744005)(2906002)(86362001)(7116003)(41300700001)(26005)(5660300002)(52536014)(316002)(6506007)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGQrUklyYndQSjRWSE1jY3ZRa0E2ZE9wTjRKaTBtKytEdjN6N3lLcmZ3WXkz?=
 =?utf-8?B?KzB2WmhaMklCZ1FKa2wwQUFhSmNvWlc4S3laaWx3dDdPcmNaNXFsOSswK1lh?=
 =?utf-8?B?R3JGWU9NVXNLQnJLaitjbWFoV2FhUlpPcXJLd2NkVmhZUkw1Z2I2V1pCaTdj?=
 =?utf-8?B?ZDNFSXkraGlqQ1FFVHRuMkVaSzlMOWZSSmt0Yi9KQjRVZHpNZXVadHFlMzB1?=
 =?utf-8?B?RVh1SW16ckFoTGRXMVEvZ2FGQXltZy8yejVKZW1YR2xLZWpNM2hNS0N5Nnl2?=
 =?utf-8?B?ejBqRVJiNFZXbFBHYlBKa2NsbERrbWIzS1RxU1lxZzZ4MGNaUmxuRWU3eG5Z?=
 =?utf-8?B?S0YxaXJYU1FwRnJZZ3d5ZkM1Ly9hOTlQYVQzMXRKQTRzczlEU1RuSS9FSFZa?=
 =?utf-8?B?UEdaOWxXUjl6R0FIRk9UamxNd21pOVNBQko5a3pNSEdVRll3M21MT0l4OHNq?=
 =?utf-8?B?TUVQektvVU1XRjJZRUtVUTNleTg4dUxpMlBjVFo3eW5BNmZoUHBhdHpnNllX?=
 =?utf-8?B?R0sxOXMrRzNkaDBGNit1MnpodHFEcTZZcWs2d2s2SjY3OUo3MzBxZVkraEtG?=
 =?utf-8?B?RFIwcEhPbG5HeVlxTmJZNExHY0tjMlFYckRaZENlcW40aFBQSk04ZFBsTlRh?=
 =?utf-8?B?Z3dxbXhadFErcVFDemNHSnBORFZtV3g0MmFtR25wMVZQeW1WT2RNeTZWZ0J3?=
 =?utf-8?B?ZTNjVThsd3JNSTUvbVdSNmdLU3VZSVpOY1hBWnlCeDZHSUNFbXZQaWtkeEt5?=
 =?utf-8?B?ZDl3VzdLTXdJQmJlcXRRemd5NFhIQ1RKZGs0SCtDeVR5ZzBRN0pBUysvYU50?=
 =?utf-8?B?akYwbDVBV2I0ZDhFc1N1K0lBRUpuY3NsL25HM3NoR2tpOVJTUWRKdVQ5UHJL?=
 =?utf-8?B?QVhiQ1ZDRlB2ZW5TQ0ZYbk9LdDFDUnhWOStJb0xKdFN6UGFwelAwQnVYNGcw?=
 =?utf-8?B?TXhMaFRpU3BMcVd2S0JqMmlVV1FGUGFDTDhYOVZqOFgxRm0yclYrVjVkVmI4?=
 =?utf-8?B?Q0c2MHhGRkJoeDBIUEh0Z2QwK1BnMEYxbkhKMkVaTDg0T1lkd04yS2ZTU052?=
 =?utf-8?B?WHFaVUUyWTB0NTQxNHdMdjhiWG1kRndLUWZYRlVpZFFEenFjVW1XQXBoeVhl?=
 =?utf-8?B?UG5jOEs2bE15UmM2OWVYWVV0NjNPZDFHd0c0bXY3SWhiSmIvM1NoU295QkJT?=
 =?utf-8?B?QzZjNE85Z0pjVHY5OHd6NlBma0dKKzdycHViWVo1MTJWdjFKVW9ubkpnVit2?=
 =?utf-8?B?ZWFBU3JVbGtRYmxGL3BtRU1ENStOMGJjSkhvUnlyRTdzRElZUlRlenZNZ0J6?=
 =?utf-8?B?ZjMxN2ZKSjM4N2VXVGdWNk1kaWRmS0hlNThWcXAzVXVQTUx2N2wzdFpzcnEr?=
 =?utf-8?B?MXZCWW5UdWRqbEFaOWlXTXpKSnZyN3BjNHhmNWtBdklvQzZzVkkvbDh2N21l?=
 =?utf-8?B?SWxBNGovRzFNYk16NmF1d1d2cER2VTBUTGp5NXc2bnBLR0c0UHpFSWFha1JY?=
 =?utf-8?B?RjE1MVdzb1BBbUR1SS9JR2g1SE5SRWF1a3c3WnBJMzZ0Nm1xTkVOSmR3bjZy?=
 =?utf-8?B?Si8wQ1RseGhpYVhDaUJaamI4cVczbG40ckpPYUd6ZSsva1d6VVlVS3Uya1dP?=
 =?utf-8?B?cEpaVWRpZzMwNEdRM2V2RkRFVG9UcThOTEZXaGpZRlI4R211MFNDUVljaWU2?=
 =?utf-8?B?K05QYTJSREY4WGxubE1wTWlCWDBrQTB6NmRJTW1HaU1NMGNDcmpCd2xrRTdC?=
 =?utf-8?B?MnNWTFB6VVBnK05YYzNQSU9BMnk4dTd1TDVmQXhtMDZ2TDVjaFArczRvZFJV?=
 =?utf-8?B?b2k1Q01lRXVhSVFzSjZwSUFIYWtsN1RoakI3SVZNTkZwM0FVRUlGZk5FdFUx?=
 =?utf-8?B?QXBDYU82UStGOXpwZU85Sng5VFFQRFprRnk4ZFF1K1JMRjlyVytRKzdLZU5H?=
 =?utf-8?B?OFNVM1pEaDE5SXNzaHY4aE1WaFJLSW1ZNklPbnpDb3ZvZ0tZVWdid0RuS1BB?=
 =?utf-8?B?VW1STkhDd1BIUk4zVjN1ZGk2WDBycXJta0l3bWY4UFlBSFJ5S2hSS2dEWU5C?=
 =?utf-8?B?OHdvUXZySlFoNnNnNzgxUlVNYndhakF5aXBvUmZFcnRHeVp5NlhkZzdQbFds?=
 =?utf-8?B?NEpWMjVGMFJJS1lhT1ZSVlpVQklsTG9rYTlBakNFYlRLSS9QNzdLdlpncHU0?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5336fe4d-f220-4105-976b-08dafeceff5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 12:23:42.7101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrIGwuv2j8FTGyWCR3x3aqxtKxpGiAjbBod6Obc5vtOOrF1mjtYINIgquQQJxFhM1qss0jMLnHxLP5LHPYBeNfjjtH1tySzM3zwE7Zj7/gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2939
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBUaGUgbmV0d29ya2luZyBzdGFjayBoYXMgYSBwcm9wZXIgaW50ZXJmYWNlIGZvciBuZXR3b3Jr
IGludGVyZmFjZSBzdGF0aXN0aWNzLCBiZXR0ZXIgbWFrZSB1c2Ugb2YgdGhlc2UuDQoNCllvdSBt
ZWFuIHRob3NlIGluIC9zeXMvY2xhc3MvbmV0L2NhbjAvc3RhdGlzdGljcz8gSSB3YXMgbm90IGF3
YXJlIHRoYXQgY3VzdG9tDQplcnJvcnMgY2FuIGJlIGFkZGVkIGhlcmUuIEJ5IG5vIG1lYW5zIEkg
d291bGQgd2FudCB0aGUgU1BJIENSQyBlcnJvcnMgYXBwZWFyDQppbiByeF9jcmNfZXJyb3JzLiBU
aGUgd2F5IHlvdSB1c2VkIGl0IGZvciB0aGUgZmlmbyBlcnJvcnMgaXMgaG93ZXZlciBqdXN0aWZp
ZWQuDQoNCk9yIGRvIHlvdSB0YWxrIGFib3V0IHRoZSBkcml2ZXIgc3RhdGlzdGljcyByZXBvcnRl
ZCB2aWEgdGhlIGV0aHRvb2wgaW50ZXJmYWNlPw0KDQotLQ0KU3RlZmFuDQo=
