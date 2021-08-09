Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B587C3E4AF4
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhHIRhQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 9 Aug 2021 13:37:16 -0400
Received: from mail-fr2deu01on2067.outbound.protection.outlook.com ([40.107.135.67]:46808
        "EHLO DEU01-FR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233847AbhHIRhP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Aug 2021 13:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E20DyhNT/KG6b033c5MhhQnAgWAGZGLK6W5/PWHyxRKmTb7yqLcLMloSMDLR7AInZrtu2Ff8Vj1Og7S3aq/6mC5YxO45vv2QZrRnPjoYKMyi4Z3cM01GEIatLX53JMtyLikElmaD37ZFopqG3eLV4pTwf75VStP5MufmjyWa65Vl8YXAoqeBFD39px5MAgQwMA4Ui643PoQPrFZVgNQIm9crG/BzVjv5Dw3ZmTTXGbvEV0dJpnCf4d6rjjBZAxRu8mVQZ4rEdnwLIG+4zSyaboioAOFYQBnouhUviArqjbR17DTe4rDCyYttiw2g8kKByVbAPVNCztVMYvMIPy65og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vMR77Pc6z7lwTJ92qdeCsv7PXYLZ/z3Ax4CjE8Y+v4=;
 b=cIgc9DN1AuR+m+5f2GHbwkTqbO0GPRUzye/rgVQeqTVSmFdTnxSe8Guqnp0zcds9WOl9clOUVSZVzd1/9u4hMSf1vxD4Eb0VT7xUxRoSLji3sClyOwDX3rYxVjuSdW178KfO382m/XeHjBU4N/n9cGLukSpWsg+uSMQTfvBUor8N6+vxu3PCCEcPwQTAgnXte/vyoPqS2yXfbYUKZXe1HAPfevvc5V+jxOVOIyGM2szhIMEkl1Z/OTCTQniGYVwayRsewlRajpLNkEbvk91cj0JUo5n4C2rUdBv70MoamhGeUD7Y8E6bmF+XldVejcRA8t5anDObZHLHSUcqDqKTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arecs.eu; dmarc=pass action=none header.from=arecs.eu;
 dkim=pass header.d=arecs.eu; arc=none
Received: from FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:47::10)
 by FR2P281MB0298.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5; Mon, 9 Aug
 2021 17:36:52 +0000
Received: from FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7dd0:6928:5a70:923a]) by FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7dd0:6928:5a70:923a%6]) with mapi id 15.20.4415.013; Mon, 9 Aug 2021
 17:36:52 +0000
From:   Hussein Alasadi <alasadi@arecs.eu>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [PATCH] m_can: fixed typo in m_can_set_bittiming() causing corrupt
 DBTP register content
Thread-Topic: [PATCH] m_can: fixed typo in m_can_set_bittiming() causing
 corrupt DBTP register content
Thread-Index: AdeNQ/Q4bqZPOm0YR2qWN96aJuPPYA==
Date:   Mon, 9 Aug 2021 17:36:52 +0000
Message-ID: <FRYP281MB06140984ABD9994C0AAF7433D1F69@FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=arecs.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e1be892-4b55-4eb1-3543-08d95b5c4652
x-ms-traffictypediagnostic: FR2P281MB0298:
x-microsoft-antispam-prvs: <FR2P281MB02989A03FA18BF1DEF039317D1F69@FR2P281MB0298.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5z1vP1JJfl9LMgSnDf+bNz+DdnU4gINAjugfZQUiHEMy0ghS4EJWCTa1BHJtV9e4OLPQ6SsKn0SfxfZjM4cjKz/b842zju6KX8h5DjLJCRYnElN4ZUKxl2I4Qwqj0ptrg+i0UO1k0WNDRS8i6Kcrh5zMU2lnfQH5J0u4l1b9vDS6iWT2YyQ6rGM9j6Hy+2V3zan199ZlexBiAjZqXD5t/qxL4lI1nv6U+YFLQkXto8z8iCE/vB2fDm+wzDw4v1NC+sUmcr5hB2ttfGoaHJPDMuqR1fIFHIYQ2YWNSDN6sn1E7jQgTaDtVIs84KA4qNpPiccZqsG+si100msjg3XB3Yt3ouZ+Fey/TGWE/KiNhLpW60cvjBym8YYrVR551agXIX6bND5JXPuRkjgH6z1B5TSTMwM+RJ1TUicSFt8tNo53E0DQEdDric8EVVB1lBAa2ORXj7gl54xUHnDcUU/CTAdlBPulAhJJOa+6HJiYPWWzH93Xy5LCAZqQJzIk88ZZIJl2Jgz4X2IyCvgjnB1+YAqDr5s92iGXG6nJ16fzLO0QLycPW9+SlGaXcK8p1sgfRXeZ4ldAGgE1O2sqGZ7EbxmM00HWXszKjKpexTuGL1tpb2OStwLAOUeQTh9D54oGl/Ql7OuIcg/kjA+4ccR6ZBiXvu/mTkTfBqe9pIHhwU/O0FB219Zt1Rhee6HR8vGHYR7YpWEhjlWSr0XW0fbAwBS1OS3yMJsXqC6Ze9l85w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39830400003)(2906002)(76116006)(6916009)(8676002)(122000001)(8936002)(5660300002)(38100700002)(64756008)(86362001)(66446008)(52536014)(66476007)(66946007)(38070700005)(66556008)(9686003)(33656002)(7696005)(6506007)(4744005)(316002)(71200400001)(26005)(55016002)(478600001)(186003)(4326008)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KU/U1NVhXqrhjpP/SfCU502J2ecG1oHAhUAn8rlhmm06Lsps9CQYBgEsMvap?=
 =?us-ascii?Q?ei7d3XDZ35R92tlBHMmm91mN9ZfjB3Jenh2WmhP1DKra92bUgzIOYrURhxM3?=
 =?us-ascii?Q?RBVg+Z/zqx+gArv0z6KwAYRTsmxfAEdUDMuILvQCzgJDRLiIhOJb3sn3AEMy?=
 =?us-ascii?Q?9P8zTgWoKpg5qb2V1bILvszgRwZKlp8DvMXHYMfntedVux51b+l3egjq7BSU?=
 =?us-ascii?Q?y694+K4XU7x5vBG7m6dOMtBuwRiZyJSO/zu3beFSAtvHsgWRwb5rjX2fE872?=
 =?us-ascii?Q?CaCDbzDaUQSS78JpB5w6EQzdDx1hql3sdVS9ajH4ACb1WqdF5fo06yQjT1AO?=
 =?us-ascii?Q?8vLWbeqMDC7hUeb1WC0B4Rr23Mv7yTnQrcM+y62E9b3V/ue3Fu4NhIg/sc8q?=
 =?us-ascii?Q?FrL+xAVy5bIt6y4+C/MOOoCs6DChX7X+FiEB5kaD9BfZmrnOvfa1wTRw0J5G?=
 =?us-ascii?Q?cvqVJQLWPHoI2q++Aq7BzTAVEwQHdwyxlugKg0MYGBl91mTuI/1B+SpwFGL5?=
 =?us-ascii?Q?D0AAb/EfLTrIixHDpBrB/LRnBf29FDnVRFU2GuKPTuMlMwlxU4igu85bCcWO?=
 =?us-ascii?Q?Wu6oMgcpl3AVREH4+SXPOwNr2jMEuNma8+6WkLmgs9b9csvahdWNDF6MzTES?=
 =?us-ascii?Q?5TZQOaOaYsw6JmaXo1XEvSX802QCaab0bHH3pTuxVr7Ob3NAkJbmcUUdrb/X?=
 =?us-ascii?Q?3EYmRRzeR9sRxDny7CHuiPfqTLJdoWjZ/URotP5dequYXjmuvqXOv1GVRgBF?=
 =?us-ascii?Q?7D9jn1jhtMTbldXADMR3JygJhfbrwzQAdldcr/hiCJZ6calRXwa8VoiW/eNI?=
 =?us-ascii?Q?xQ1j9Q2DGup9e84b8e+KY1AH0w2XU8jDVPOO0L7TTDzgw10vKjG6+XHfAEEC?=
 =?us-ascii?Q?tu5CnT6Y2Jo77O6r2aOXHbD+GDjkldOY1asGdXkA5FMPwWAhN6k45KO+dOFp?=
 =?us-ascii?Q?GUhvG4Tp9PesxHyvv0iErSNRLUmHSHiGz2yiVfYeMt8Q5nBJpFdZlqZov50i?=
 =?us-ascii?Q?SlgEVlCc2q+5RdJjOI2nilFzOfWjsUFzC5Fqmni/WlQ7eW8pzPsm2MGcAjwi?=
 =?us-ascii?Q?mncILOxIs7HZ4AUfDEn8TYGcjFJvRQtxNwA7ikFhkyApFOKQkV8mIO8dHij/?=
 =?us-ascii?Q?BkBfiVeptrv7ovqKraAZ9kjilShal50PrgSu4oIfY7H1S+Y+dFlTzLIIBfxe?=
 =?us-ascii?Q?bU3cqKZ+K4Xr3uGzO8e0bgiJDVwMIBG5phQlLaPDZvfMjBZ8RNs10NZJBfgK?=
 =?us-ascii?Q?VoLnzq0Wakbz4s7yC9Pzk8QkfEnoLEjEgehqiUY6ee7O2wnz6yohv+86RxQf?=
 =?us-ascii?Q?M8DKRKfvRIwM4BgLqOu1ZATg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: arecs.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1be892-4b55-4eb1-3543-08d95b5c4652
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 17:36:52.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40e33a7-902f-4fef-acb0-37bc625d7548
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKLOCAWg2eiB9NWZOyjNZVeDwOPqGzv9PjPPCl9EQc7BKW+uXH4qvEEAO2u+3QEJdiYe425r6Mgrm1jEBIW8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0298
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello everyone,

Fixed M_CAN_DBTP corrupt register contents:
* NBTP_xxx defines were being used instead of DBTP_xxx.
* reg_btp was not getting ORed with the possibly-existing DBTP_TDC flag.

------------------
Hussein Alasadi
ARECS GmbH


diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 0cffaad905c2..f3809f4cfc7b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1168,10 +1168,10 @@ static int m_can_set_bittiming(struct net_device *dev)
                                    FIELD_PREP(TDCR_TDCO_MASK, tdco));
                }

-               reg_btp = FIELD_PREP(NBTP_NBRP_MASK, brp) |
-                         FIELD_PREP(NBTP_NSJW_MASK, sjw) |
-                         FIELD_PREP(NBTP_NTSEG1_MASK, tseg1) |
-                         FIELD_PREP(NBTP_NTSEG2_MASK, tseg2);
+               reg_btp |= FIELD_PREP(DBTP_DBRP_MASK, brp) |
+                         FIELD_PREP(DBTP_DSJW_MASK, sjw) |
+                         FIELD_PREP(DBTP_DTSEG1_MASK, tseg1) |
+                         FIELD_PREP(DBTP_DTSEG2_MASK, tseg2);

                m_can_write(cdev, M_CAN_DBTP, reg_btp);
        }
