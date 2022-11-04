Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F802619871
	for <lists+linux-can@lfdr.de>; Fri,  4 Nov 2022 14:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKDNtS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Nov 2022 09:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiKDNtP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Nov 2022 09:49:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1FF6C
        for <linux-can@vger.kernel.org>; Fri,  4 Nov 2022 06:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhb5ndJkn5L3E6FwkpXeFiG18EGzUOXdDIyt4tx9FFb0CPWA582MvarOGjggclaIbQ8W7Po5p0idDtulkthsBPFkAojIpZjY4w5/XMN3Al1p4PbXfihc52cFMAIBnK1A0bssjXuKfhBtmDoG0BZ2chMc9g5/CY6j51/NhGTaXw6sVFwm7YcZY8uiOnstXamDBIWWAVpC7o+YAPdM2nAuZ8OLeKuGSLO0zNO7SgWPfEQFfzXo2W6aoM3n6jM/RWGVKi+gd2FKUwlyEPD6QK6rUa2op4/MjRXn9e3dQo72xbE9LyQUnlSs3XV+7Vu5qQBHjAoV1BaFzbrcRl3pVToVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6RVfdGLg4YqOnNJq6lZwGr/jRUlVUU6mFcuYTtT8fk=;
 b=DHhN4VgeDBEtexn1RzUw5PAB6qmSmB7QjXgqAZYiONSgzo/fagmwxxuB233OzzCx82DdWvjWkdvl+JrhTJHZ4WY5bYWrHZwLHNHFQa0Ns92N1BxRTBeAEZh0p4NKR+c7oadL7cXzsupbBrKf06vY+ialRJHPWD04l+z/JFjUVptwwpjmK/S+Kx82I7CDFBd2xWRogxvk+/zo6gcXnIN1yFx4Uoi53fZjiWAtkewtzaeC/0cYBbT/EwBRN+9SOYtvE2QUKnm+XHB7zVFbC+W97Cxep3ImTjH/WoeAcom60rrt8qQ/M8PATGZrfCPhbQRq+pzY7s94HXtjF1OWvfjMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6RVfdGLg4YqOnNJq6lZwGr/jRUlVUU6mFcuYTtT8fk=;
 b=1PQj6f07k5fpWHdaBQIZo+0FM319XUYlHBq1/HYWcTmmXXHJldke9+9EdRNcP4jpzHMu+tCSkMG1VpGUbzLnQYroi4HVNCnYidV4e+DP08J/GA78WkL1fFn7wc9OvNQTjEhsleuJZI+l6oWeJyoGF8/1g8rtxdbNh6lz3zOqUjk=
Received: from DU2PR03MB8108.eurprd03.prod.outlook.com (2603:10a6:10:2f3::13)
 by PAXPR03MB7650.eurprd03.prod.outlook.com (2603:10a6:102:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 13:49:08 +0000
Received: from DU2PR03MB8108.eurprd03.prod.outlook.com
 ([fe80::108b:e105:847d:a12b]) by DU2PR03MB8108.eurprd03.prod.outlook.com
 ([fe80::108b:e105:847d:a12b%4]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 13:49:08 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: presume-ack option exact meaning
Thread-Topic: presume-ack option exact meaning
Thread-Index: AQHY8FMSjvXUU77n/k+AfY6yn5MNdg==
Date:   Fri, 4 Nov 2022 13:49:08 +0000
Message-ID: <DU2PR03MB810805F6DE35CCE577469C0ED63B9@DU2PR03MB8108.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR03MB8108:EE_|PAXPR03MB7650:EE_
x-ms-office365-filtering-correlation-id: 18aa470c-ccb9-4466-efbe-08dabe6b5896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOLzs46CfsVVBsoENLP/yeBpCCSPHd2czLiE57hTelGkcigpQxgmaAOGoWteu0CHWjJ/btRTld7fcuHnNEzFvXazQcEgN+dvGS0OdFaSQOp1B1YcZML/5CJidQnv7obimTIaIfpMQqagNmEpt5B+OcIFhMjpuKHV6tP0wKnHhVrAtI08hPphcgo+iYVw5wb4oo7gYZlyXc3lh+bIPhEJuXlpgdyVDrRsyICQKTMg85CeT+5z5RhrB1Lorx2St3//w8SKe3eOCH2Whk+XRePF+pc122d2ED0h1QG4VsQvIZsaVWhFjSUsbb7AxEaE8yUxveaMxFuC4/XJM6Gg6J+kQ4ASPJu8pqE7RWEZd5ZrLN7Jm0GfbZ5qk/jvsFWLe2uT4YHqU4+puLO3POZ95I4Jm5GevNOEjAtZ9Xm9rCmqbvImLxi//SFcw/N3bbUFFQcZnLRz8jHKw6RrjU5EA45BsL95yTAq94r4+8SpKLtbYdj7E54Ykjsw1p3hCbc9mXMs0vIn10huGBeelD/ED7Q/aOk6VKAKvcKKHsDYaT1eg+V40YDYUa9dJludAu0hDeOojLZ2vYhRH6d6ZUCbix0uEBUv7zqvFippiS8iPy4u28Day30Yx8B7Z27Tu412sILvgUUiKM+Yf31xI1k6h08CakmRQlBmmbY95L5DoI9J43XwOIqVNq4pC1D7fF/3weInXSLVex/QtzPyQU1nsaYnEW3HtNV0Vv4nIaT2weFpbibhRXL9t/qusSS5THiKKbxgaAHDy1N4RCuhCskkOzMu+ACyrp12PMxDQL3qv2ImR3w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39840400004)(346002)(396003)(136003)(366004)(451199015)(38070700005)(3480700007)(186003)(122000001)(38100700002)(86362001)(2906002)(41300700001)(8936002)(52536014)(5660300002)(55016003)(966005)(71200400001)(76116006)(478600001)(66446008)(6916009)(8676002)(26005)(91956017)(64756008)(66556008)(316002)(66946007)(7696005)(9686003)(6506007)(53546011)(4326008)(66476007)(15974865002)(66899015)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r4inlrxnK1/HQiL4CE560yQhzu+K79ULpdDaYMJLgUJzKUBz3C+8xjyS+5?=
 =?iso-8859-1?Q?alHwTsCZyk+oYDCWFR1YEDLWzDttC8WgzVIlVIAeTtFPQI1AjTWRsR0xD9?=
 =?iso-8859-1?Q?ZCtzDIsOjFQZXHsmlJo2p3LNCApZVM/eJSqk9tvgDQDhPzhFR/zgZ0WDIr?=
 =?iso-8859-1?Q?DEN328RS1cUSltMCN5IqYfaaTb6G/AiaWtET5eyjuLUru8QsC99PwypDe2?=
 =?iso-8859-1?Q?5e9RiO9VGonHDAsu8mcXH7pDWqe9QQbjd7bba+SogXkEb+H148umXjGXXl?=
 =?iso-8859-1?Q?1lEEutvHsN5+oay8nxZXVWvIkaAdQ4aWm6IT5y51IWoqxpVWNvIMcMAneP?=
 =?iso-8859-1?Q?Xr7eRDF3244k5t764P40fcuFYzHnLDEp74Azf9IvxqCCTjB0hL/dSRwY0e?=
 =?iso-8859-1?Q?/39P9OpQgwPyo3V1gjaX3gotKWWjiKJkbD9dhoI2IUks9ufK4hXtAbpoJL?=
 =?iso-8859-1?Q?xRy8/pxoR/vpvz701Xf3htk0rw/M96QdFhYu0KGbRW6VMTQvQU6zLBZU3P?=
 =?iso-8859-1?Q?ajnRt1mylwCcgBoGOG22atDYL/Lz+VF9VKS56eGwNmDTqm+nLAdvYKHUTD?=
 =?iso-8859-1?Q?wQd8yVD/zFbIsbR5KE8js9Uj88hnmT0wp+JCoKh2WUnDUjlrYPdg90mI8x?=
 =?iso-8859-1?Q?SLeRfiRC78hjAb/dk3XMWplEC5nvKNYVslIl8vx0M/MbqFFsUb8fKI6Y7o?=
 =?iso-8859-1?Q?3OqdzLTVfZaYgev9yAtSb5n4DqvKP+bC6RhyZUdO9u1EcEw0crYlLROVvs?=
 =?iso-8859-1?Q?SS5Rni2R4Vv7xiZ5lCTXFT6NeEjipjEqlmCaeLLrA3QSS4DU5lbRF5OGL4?=
 =?iso-8859-1?Q?hIzHIJIvJqzr1w8cF78zEnZKQOoGNEdI5q5KkKTsXpYisrZKOQQ5VlexzB?=
 =?iso-8859-1?Q?LmATub9pf2m5tmCmc3kgJQULS/euOqyLtAvFYHAe/UFrmtjHy8z4Kd6zhd?=
 =?iso-8859-1?Q?h/AdkSKb8nZxvFgGEb92Gd05I/T2dj22qNwfENjvuc4NueLkSy7we4bMUd?=
 =?iso-8859-1?Q?vTmugh3bccCWAocykCRJW+SCvnpEPSX0NU1fn5zR02k+/LWqBEjzljDqeA?=
 =?iso-8859-1?Q?TqtzQyFIHwsb0+2swcu4f5ZLBQnxbhVught9HNXKV6U9pHSw0IuohNB1yP?=
 =?iso-8859-1?Q?+9DDqjWV9MPKz+LohDmkRnxKqz+kOFxr7d3mW+v4jmmQotgohvlpT1PJFl?=
 =?iso-8859-1?Q?GTT5yw1DTFWjcfr9abDIJKGLzbiwfejOKg3FT/DWdjrC5d+VirGF/AT2xd?=
 =?iso-8859-1?Q?P+5crgTf/hKKp9UuUUJMRYmE2dfYLctiAtPt+x4aZYvm7Xnxt4xsmb1cMF?=
 =?iso-8859-1?Q?oF+zp8wQVaG3O26uSrd3qgkx+UpBpwGk9IsUZw76BMf9vHOniualREK2MQ?=
 =?iso-8859-1?Q?f9Ec1bUbicAvNANFFv1/bvCMPkcg6rvt/30Q7DtGNvE5ls6w8w1VVlajXa?=
 =?iso-8859-1?Q?LQmxU2k9FXU9Hr+QmNMmw0syd3/76u62yR0l/BpVjQnttLX6aSH4dXxw5Z?=
 =?iso-8859-1?Q?sv1kjP2P4zvTC4Bi/yVKI+HasNGe8o+vXcGeMPNbEAX57I5878zc3tbgUF?=
 =?iso-8859-1?Q?et6zCydmTTTiSxArR0o7g+Em2dDD0DoiNFaMCOMY1Ln/3OP+kpAHe7q+bD?=
 =?iso-8859-1?Q?c1sLvg722OKehs8GlQqhnvc91f8B6wASn7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aa470c-ccb9-4466-efbe-08dabe6b5896
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 13:49:08.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzR61NnkS4dbYoIejcw2P/j0NrMAdAoH6SkBmdGIBMZULH3aY1PLxnxuqvJLeNKJRWNNgVnGA35M8DoT2PzFCnRwBWSd11i5dlMWYNeor4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7650
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> Does it actually send an ACK to the bus or ignore the missing ACK?

The controller sends the ACK to the bus.


> | Setting the introduced flag via netlink should make CAN controller

> | perform a successful transmission, even if there is no acknowledgement

> | (dominant ACK bit) received.


> Does that answer your question?

This partially answers my question because in this case, the ACK is still t=
ransmitted.

-- St=E9phane










            De: Marc Kleine-Budde
Envoy=E9: Vendredi 04 novembre 2022 12:03
=C0: St=E9phane Grosjean
Cc: linux-can@vger.kernel.org
Objet: Re: presume-ack option exact meaning




On 04.11.2022 10:56:16, St=E9phane Grosjean wrote:

> Hello all,

>

> I have searched the net, but I can't find a clear explanation of what

> the "presume-ack" option available in socket-can is.

>

> Some PEAK-System devices offer an option called "self-ack" which

> allows the controller sending the frame to also send the ACK itself.



Does it actually send an ACK to the bus or ignore the missing ACK?



> Does this behavior correspond to what the "presume-ack" option should

> enable?

>

> Thank you all for your help and regards,



In



| https://lore.kernel.org/all/1404934273-19233-3-git-send-email-nebaruzdin@=
gmail.com



Nikita Edward Baruzdin writes:



| Most CAN controllers have a support for ignoring ACK absence. Some of

| them refer to this feature as a self test mode (e. g. SJA1000) and some

| include it as a part of a loopback mode (e. g. MCP2510).

|

| Setting the introduced flag via netlink should make CAN controller

| perform a successful transmission, even if there is no acknowledgement

| (dominant ACK bit) received.



Does that answer your question?



Marc



--

Pengutronix e.K.                 | Marc Kleine-Budde           |

Embedded Linux                   | https://www.pengutronix.de  |

Vertretung West/Dortmund         | Phone: +49-231-2826-924     |

Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
