Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE214EEE02
	for <lists+linux-can@lfdr.de>; Fri,  1 Apr 2022 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiDANZh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 1 Apr 2022 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244750AbiDANZg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Apr 2022 09:25:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60129.outbound.protection.outlook.com [40.107.6.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD97A17A9B
        for <linux-can@vger.kernel.org>; Fri,  1 Apr 2022 06:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUuj4N+esadL1JBsnPPGo+IbUpU8m9o4hgCZuyWOvCHnUGvjmQmrkC1UR6cTQgxJycZmMXBF3nDawqV6sxVnoKtx55CTno2E3o0NFHXH8FT7gQfGedr04i9D4biheo7nCDksY12rmnnnN5x2yUFusQxHsqHFtqnqNm9TriDJRJEuYFIve6wo6LXVMGi4jxU5641noYmHpBzwOK/3Eu/UfKkC4497OgjrrxkjS0eLDYu456t8tq53PmIiAApxjq0SpoiDvSvk1vdlrecAU3GJkD2Glm137E8qTh/hooEJP8F0bteSRw2gTUZG4SupXU9VmsCYiwv3BVvenzDm7wu3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGtaP64XkAPXwLy/ACJjqjdoMaziF8pj5xDHX3vWPU8=;
 b=FWRUC2Egr22+HSpNgaVZs7aTT2fOuxi41EjQ2Ptzm9zdYngvR54IIqbUH8wGBdcMC2836IqBap8gRLhXk5DWHPT6YBvlFBCVMu2JpB93J0bDGpF25DQtmO0tNzcZhutuZ7rgCGzm+jNMScTFSHgrwwKWQ5golcdxSaLXOGkem5+l/PqIEEfrDb4vGwK+5/h3NfXT7c5MeZgrHEafi5m0z+UKYI75misllvap0KfT6bcrEWGXUOio28NaScERQ9kK3MGnM39cTnMqn711cPWVp+bN6f2yBvCteFc3A0vOmlKGIKDbRRkeeTNAShEfCtgyINoW0x46cKk0mnF7ng6fcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGtaP64XkAPXwLy/ACJjqjdoMaziF8pj5xDHX3vWPU8=;
 b=dWI2L/WW6UeyjkhKFnv9JxPGWmXHhxrMsZG8MnDipyKpZ9aXivlhzTbImdCjBv0xOnOu6e8GyKz5wJQAIvKcclNwtExqjw4u0e1AKylZpR06lxUip+R7S8JHy+Zi8i1cRXYnMx6wKxTaVyjDRPlahvo7rbRJW3Ui/h1f/+6i/H0=
Received: from AM0PR02MB5923.eurprd02.prod.outlook.com (2603:10a6:208:187::17)
 by DU0PR02MB7851.eurprd02.prod.outlook.com (2603:10a6:10:343::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 13:23:43 +0000
Received: from AM0PR02MB5923.eurprd02.prod.outlook.com
 ([fe80::ec30:e2aa:61fb:7f3e]) by AM0PR02MB5923.eurprd02.prod.outlook.com
 ([fe80::ec30:e2aa:61fb:7f3e%2]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 13:23:43 +0000
From:   Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt load
Thread-Topic: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Thread-Index: AdhFyuJj1zOoVQ3MQF6tNgMHZCJ37Q==
Date:   Fri, 1 Apr 2022 13:23:43 +0000
Message-ID: <AM0PR02MB592368F53A7BEA4154D24A87EAE09@AM0PR02MB5923.eurprd02.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 421d12ad-23c1-4614-9ccb-08da13e2d842
x-ms-traffictypediagnostic: DU0PR02MB7851:EE_
x-microsoft-antispam-prvs: <DU0PR02MB7851E8004FEC0DFDE2D12968EAE09@DU0PR02MB7851.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysXf+PeouVB8scTk1iV71eBOHbByOJXzFdlJhy9Y0cdp1WJK44W+w3zyCCVHUSZPhOSNGtefc6PbDFQGBOSpqER38LXDDosszacX0tyziyVRK1pg1nYKqz6tBJGKL1AoL+FLCUFHAhbjLdjjvaC3poh13+xuAvV3Pm0azC9lM6slPWxjMS0JVXMCXPnKxf8384R9qCw2iu8D8Bb56VG7Ed2ZazBmC4vMyl18Ail8SRCjQp8LNKq7xOvEAEaLbglzNV7Uo2T/SoxT4lw8EIqkVaWUrJ43gQk9YNN1vcMnTmJD0ttvbonwXitpVmWy+SDkxoX5VYQbt9YOPJCCm9JpaU7tOYp2Q88QTw85tSVbV92YzP3dhlONBMDKjUtaMNJtr3+U7aq3s3Z6AtmvUPp0kMXouXpmCVA4TEmfM2hq1UQGmBQysqErjcLISkO5mYiHcn0Y4GpraGr6kzForrlHjXP3Yj4QAWOT1P1f9S0nKiej7oMivzrgsND5gfOFXRKYul/o4ZO+3ORqKu0uF7htETlh0mDcFafBGADdzbTGoAssFzs/uNvxq7vHbzUsmR6KowgkocJ1hTj6+58fWSs3HSSC/39LrrpC4FMitilkGrXdOZxOXEi+lt75TOFugI3aqrawpJmujaXdaYcRDnAVg+MVOL02UOQrZX3dUIggpBcAK0Hwj9LDvSJ7LfonC+/4AP+6OeBelDV7+awzV0Us/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5923.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(122000001)(4326008)(26005)(83380400001)(186003)(8936002)(33656002)(38100700002)(55016003)(4744005)(2906002)(52536014)(6506007)(66556008)(66946007)(64756008)(76116006)(66446008)(8676002)(66476007)(6916009)(9686003)(316002)(7696005)(71200400001)(508600001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l8H1m074lw7+TCUjAp15uxW00aEJPe0BtdrX51bYDN9DS2QYAObojQ80VQSa?=
 =?us-ascii?Q?vuiYRXn+t1ARg4PoxPSXBpVcPQsHg0gLG6CcFy/yhwQimfNN6ygs8EgVmoRv?=
 =?us-ascii?Q?+CMXgepUAZCPx2mfN7SylQNLk3CP7EcT2ejPnTHagA/1JRWzdn0ZYPYP6/T8?=
 =?us-ascii?Q?DR8SydZBaoCWHI7TwLcNtBBzDZzdR64brk3NZcO7ckk+w9ezENjdrB6WDwhW?=
 =?us-ascii?Q?77DxWEZiGsMajWhhqt5uCI/1MHIGIkopdd6Zz7FTp3V9hHns3lUoSfRtTu3g?=
 =?us-ascii?Q?CzAy3wj+ULx6bAqF3GF/ac2B/DV9Vkpr+vb/DFXi2MCbwSsHzhkeZzPSU4Fo?=
 =?us-ascii?Q?4V26Hg6saW5VYNGxE02DS/o6tPcQl4KWR45T/PZ6q3tKsmgU99CajN2z5Lde?=
 =?us-ascii?Q?81TtS5AsPFd6bLngefOIZ8ylxxucHEjQ2pdYchLH7fzp3FRFEnP4ctXqpbcg?=
 =?us-ascii?Q?ZrG9H8ULe+R9cr7PfVPrNQPb3lymeeGhaICDXZYhRgrcKGJvYu3WkhdUZC1v?=
 =?us-ascii?Q?s8g7wOA9Kh72qlxt+WpT2lfhdc29k76IAMNNcLXbgkt07xu8890RhPcnr9dM?=
 =?us-ascii?Q?IRQ93mWexosehEOIvp2A05bQ4qs/hHXeyY0shylfuLTaQ129xgKmDZEXkRx5?=
 =?us-ascii?Q?79kvLhCchEPb6iyrka1xXB+zn7ijfWHKuOMhvq9thFYWgxAK8NkWwMybn/dV?=
 =?us-ascii?Q?j0MZw6CqCGhnSY8qzlArgOSyCJLkSGMqkjfqUeh/l8WwDhnOMqaQJ3KOMBpk?=
 =?us-ascii?Q?LKXPa24eY2rgupyVKNtuIgJLgOUKuUtJNlE0q5tGgV6VRymf5bi28pxHSXie?=
 =?us-ascii?Q?4syOdZK0O+UCtcB/yKik0qb3WL6mObjfHoxfx/C/r9AyzQS7U/OZWiN5T07w?=
 =?us-ascii?Q?HFOI0kpvMzZkb7zGK9spKlzD/op4S6IA58+bnF+bRckLo1VZzEVrsWiFAgiz?=
 =?us-ascii?Q?DGbjFJjvASAHzdGd7wBc+oKsiAqCFdMkiIfZmbsO29coCwpLwa0teGSoOVyk?=
 =?us-ascii?Q?r4jqU5xooI5Y4W3nAXbCzsALgDeN4US4ieZahF+4ypSvxT/jPorVV3r/JKEh?=
 =?us-ascii?Q?ASrZOB+C/2K80lvDqpHw8gBGrr0mUW8joioVz6alXyplLE87a2dSQ1M/4EKW?=
 =?us-ascii?Q?JU7LCAnpBTcbWVZgs1IoznZxh/eSqbwuGoqLSDbDVVULVj8br0b6Jp/HhSvi?=
 =?us-ascii?Q?xkBRG06gMq/mZ8spq6ZhJTuMR2Dlm11kLS6yU9xppI++zoj6xa+sE3HGJepp?=
 =?us-ascii?Q?fTFcGlcgC3QxX19aZXZV+CXIWIoEKNdYj7eQgHTOH2/fCgUxbBU4XPEfH1Zo?=
 =?us-ascii?Q?90XEx9tAagheVA8LDMEOLEqhDSB/5aYMFikpBWypVTMSfPshj4mxam4Jh03w?=
 =?us-ascii?Q?rSiPT/BtFJVm3eoI3YKxRlgJXIDjg4cpzCdNM5Ud0q4vNV/p9E+0IgwzVmAF?=
 =?us-ascii?Q?8fFfR+CkVU2aIMIfrtgYl225IWZD1U6PvKYX/XpBa19j7nmqTss2orTbjxPd?=
 =?us-ascii?Q?3mxvPheczEM785eNxeNioBt6hNPDNVeL6nw/gU0oNir8Nv4DFqTCPUK6WPie?=
 =?us-ascii?Q?GgBTsuNjKjVJxwCdISWS7Etso9pGGn7Bk2O2PCNlyTs5YnH8LFQHtT4vu1XF?=
 =?us-ascii?Q?0gQsQcxcglz40KQHkp261dTUMlJQIEbttv4AmyKS0g4dyO8BkF9W8r+vEP5c?=
 =?us-ascii?Q?GjEKlTbyimovldHdpkU4F4r/Fq+YzYIyNpdp1DDtONwxon2pPSowx7FQVY2Y?=
 =?us-ascii?Q?/nwjPO00B3swuWtzoMKi1ucEHCtIgcd0SbAd5tDxCaXrqm+PJQaqdHaLJgfO?=
x-ms-exchange-antispam-messagedata-1: H50/eJRl8i1wdQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5923.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421d12ad-23c1-4614-9ccb-08da13e2d842
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 13:23:43.7346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvHl1KigXhfNWniX+0j4EJfmvgSScCBkavTmkjPbrzg8W+8Nt+r7MaLiiTG4rWscIgkT0K9+cNxLRdnUeu2aXLZpWxtLP65pOpd6IBPpcBZVYM7ZHF78JKWysIrWdWZ8zab5U5fSBhEpbnKOu5erjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB7851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When using the tcan4x5x under high load of both RX/TX interrupts, at some p=
oint the nINT signal stays asserted, causing the socket to block in user sp=
ace.

This reproduces very reliably (in my system) when both reading/writing at 1=
ms intervals at CAN bus speed 1Mbps.
When it occurs, M_CAN_IR is set to 0x580d and never recovers (causing nINT =
to stay asserted).
The problem does not occur when only reading or only writing.

After checking the m_can_isr() function from drivers/net/can/m_can/m_can.c,=
 I noticed that MCAN interrupts are disabled while processing the IR_RF0N f=
lag, but not while processing IR_TEFN.
I'm not sure why, aren't both handlers running from the same interrupt cont=
ext and communicating to MRAM via SPI?

I'm running kernel version 5.4.24 but I can see that in e.g. 5.17.0 this st=
ill applies.
When I disable interrupts during IR_TEFN handling, the blocking socket / nI=
NT issue is gone.

Met vriendelijke groet / Kind regards,

Wouter van Herpen=20
Designer
