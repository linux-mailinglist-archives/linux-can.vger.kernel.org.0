Return-Path: <linux-can+bounces-4424-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C2CB41587
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FF61A821D1
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 06:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177062D8DB9;
	Wed,  3 Sep 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pyb7LvLS"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5482D3739;
	Wed,  3 Sep 2025 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882195; cv=fail; b=udINkdi8VLVvzYSlJTws2W2E+zYSXE+Qd1ZWZn4VFtZEiJTiwNnSbYDmJkHWHs+N1t9kbPAyHBWv+9AiTeISLiM6WRLdoooFzo/MSlUOl/dYDsjsUBmMcb/mESN7s1FYSotF8h5VBut3rq7Gwt9PRSP+Q/IkA9WoYY0GSjB6uoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882195; c=relaxed/simple;
	bh=q8y0vQ9nyvSujh9ZkEksKaE7BXruhZ1h6gxnlG65YIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UiP6PXiK52ATHIScIdgRShMMsYHqXo88uqWDEy6fC9NiVnCubm6F9agiwcfRuUVypn2Ltvh16jTTbRQLnd71k+CCeX2gNJoxrBG7/6tqHpiWSgi9qMfgsr11MlfBqfcvyj6n/ij2Vi2jvFpQxh9qZ8dP2CYl8AbbBSQBXNEeWSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pyb7LvLS; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F20jNIhFQ4h5/JRZq9gHgfBraFmTFBqtTLuUAn9mb2n9KWjHqd/64LW+8Mg96wHtiyhSwq8vbX6+ozUthvNASX6/OaCsCQX2cucZ7+jlsRr3pnauwpkbjSDo/tEwGvwG4uH5F/diUIi02voWl6AohsUkpt0nkXANVfB1hkx/jc1QngpimS4OHr391/q81T1e8fqcJGKySAnL2W3z+Nb3xBAqDpeeqPOQnfkSKZ11Aj7ZUhuY+ZxSfU/T4xDNNH4kV9JJ0/sDU9Ej92y/bYo5+77fKwAim/yT7rdCYwKY6SXJAFBMx0QFgL19uiXO3Cj/fJmGSRsBPB3mqPjadNR/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOmIQ390FTyDEGYH/paUn0QUXT4IYQMweuoPVxSS1RY=;
 b=Z6L2uPeddAT74kz0b/ZAo5yZ6G/KMDUIW3oBD6Wzbe882djcaG599hSATrBKi009MCIX6godbtZd+/oWfO2v50w8zDoIk7EH26dcZo0eVI4exEhdumzTKOqAZGG9HlBkURgynuZY8zXCBMWntArRPDQnXAkCrto//yMx+T5F5bx7NzsX+duMu36hziwhlOBckKWsdD09X7jAIJ2xH5jIiJbK+EpTX24TSbuKiGogsWqsmPBnULPtii8UOMdXcO0sfveg6aQa2QI7JaMeb44ig9IkQxAdA6fT3PTukO0aMcDB9CEUeR6960iZOUdZkAIWPil0AT9ZCc8+DxvM+Ffd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOmIQ390FTyDEGYH/paUn0QUXT4IYQMweuoPVxSS1RY=;
 b=Pyb7LvLSCBSr64L8CXRoP6hGo/i4bk6NQG3IhWS6Cmw94FWLs3oaHVwCyKGMRyJElJZRfzTLfOmXnU7LIx0lgNahRYtmykRO0nQHGvSOL9C8+Yj94hatrTfXcFmY0VRKk7TNamSLwUXTWwlOA8X1tsP4dTO9+U2DAX1WYbIaxXpVlX1aq10C/WOX1PfXP8qweqVfjG1ZRU127bsM+SR4mlB/mWgTVnSBKiQHIG7+GBeFQdo0BFRFTa15bLEtAXPp1/NmYg7HUi1xaQT7jJVSd9TGFrJgf9q+Wd09V3d+RXagxY36GqKxZqEA1TZkUW9m6hwjYIxtIulXZTyKejn8Lw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8579.eurprd04.prod.outlook.com (2603:10a6:20b:426::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 06:49:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 06:49:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor@kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Aswath
 Govindraju <a-govindraju@ti.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li
	<frank.li@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Thread-Topic: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Thread-Index:
 AQHcGu8eo+bejDJ2EkauGvIH/Aa4g7R+rbGAgAAByYCAAG6dsIABLGUAgACpkDCAABM3wA==
Date: Wed, 3 Sep 2025 06:49:47 +0000
Message-ID:
 <PAXPR04MB845903CF3D03A436925150238801A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
 <20250901-can-v4-1-e42b5fe2cf9e@nxp.com>
 <20250901-diligent-dreaded-59b9ad5c3976@spud>
 <20250901-uproar-shrill-07d51ea21a29@spud>
 <PAXPR04MB845991442136C0BEF0540D6A8806A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250902-dastardly-truth-fb2be9f68e4a@spud>
 <PAXPR04MB8459F58B1FCF532F0DE802438801A@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8459F58B1FCF532F0DE802438801A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8579:EE_
x-ms-office365-filtering-correlation-id: 6c38648a-d323-4865-19d5-08ddeab612bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h56GXWQQBXU5r7JMv+Ze+0mXxCPTCn4i4LwgqUPz4qVHCbsVnr0JzPcFTATx?=
 =?us-ascii?Q?IY41gj1gKjaNa0Ho8qG+8+9zORYzyvyXlrbBpDww2FO3i5AblNaCf+CNnpoF?=
 =?us-ascii?Q?LbX2W2gsFw4/NsdS5A1S5sF8V0YPmBMlUGZqfFU5Pn/fnqni1mYarPIjYtIf?=
 =?us-ascii?Q?ABrVlO/OMXU3R+eYCb00MdeNT2JKddS8uG0xeA7euNHR2Oqd7fcjoQKzxDme?=
 =?us-ascii?Q?YJzz+3VVnB+J1wu1ABPOmi32cyFsfpM/A9mD2UQwZabdDc93S8YAId84EWeh?=
 =?us-ascii?Q?eEQqYpPDz/fQJGeUzeWntBkEjU52tEZ2dsc1VLxO/UXNIhsoKZTLwPNqFYQg?=
 =?us-ascii?Q?DVc7kM9WRt2oWIolWVrCt4C+1oF7xTxhTIQ4zM0+09nFsQQLeRlgiVCdlkpq?=
 =?us-ascii?Q?PJZ3mEAsOa/H1KbuDj2cL8w+EomUBU1xbOrAl7FJacjK9aO7+4OG7DKPEcx2?=
 =?us-ascii?Q?b+eN64m4wJ9ZPRDSFAo3PgXWnAYo3Ut83tSxvCG/fZUgIi5jGqcGydZbQllY?=
 =?us-ascii?Q?TPO+w6K20R1+nvqw3S7XKledOP93Zu/bF9qOcOpua8X6mCQQNtLYBaLFO5Fu?=
 =?us-ascii?Q?J98GxxgITU1qi07c/ifV9njdUthsFxzcThWPVrQsc5K29ACHw94gZ2E70Suf?=
 =?us-ascii?Q?CLxiWEfSl2h11TLaWgq9QjtdiVSVvQ7HkHe0+QutE7kl1OgiFXpSg4VvMBk7?=
 =?us-ascii?Q?tzeINrvo2NbSmkGO91E6c9d47YntwRJJyVuS0BI+MBaCVax/WAvT3SsIgfFB?=
 =?us-ascii?Q?KFHUKrz53MUo/ZO0hICbWEmDPI6ghjrowHfOtYAwBTTz2YbXKlFdaYsblNRx?=
 =?us-ascii?Q?/6KWQVa0jQJsjllmKvBsU6e8/7rAMRImg2jvrPebCkM6lrVwJw/ABa6uhfQ0?=
 =?us-ascii?Q?ueM7myn9VnIog1h5Brc+ySdIn87wpxgToQ4g3gzu4zmvnRp1zs5G6iCYdm2e?=
 =?us-ascii?Q?j5tg6qjmJKI4LP7vZrIxOuR71E7Ev/LFxHVZ2NNbpkVrFvUp5w2/GUHlVvc3?=
 =?us-ascii?Q?pl6XnEGqtb39eIy38fpslx976CnP9x10l19PQNBdfObe2dADhfvTevBHvNJe?=
 =?us-ascii?Q?VxAkNHUzCScnCa/cvC9BaDj4U0y+L1Znqhobqqw7ItJavg7mUhpih64CQ8Eh?=
 =?us-ascii?Q?9O/c8V85jc0E/Ji0iky7H2JmTcc8hJoaRyt9YY4+PBwJ1sqb/8BtmnzEbFv0?=
 =?us-ascii?Q?xv/oQiixOKO5LxnGZg53CfqvnaHOMG6NJo2egTD+8kFGEI5Jak9lRH2yYTR9?=
 =?us-ascii?Q?BZWoJCPrmUoUPd8UcgMxm3r7KUUBzJkXitIRGfTgKgk9aocPapSk5/4/l4/w?=
 =?us-ascii?Q?evyvF/rL6/CytWeJrFDY27olVKkWAJHKl+5POO5I9DEZrKj33PBATxXIplIP?=
 =?us-ascii?Q?JwWDpD08jLnYP6gy/FSPpPMK8kuZsRGHVewtY/gmEpFigZyl6nSYOzbbAsa0?=
 =?us-ascii?Q?qyM00Fu1TWTnZ6HEo25k63+GdnG5GKrFw+kiKgWYCMisic6T7d7LoQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E2CjIQzTByxmDr+WOXvztIdTLTidSBbY1EdOa2l+a49k34MetH7S/8Yy35Rf?=
 =?us-ascii?Q?KfxDbZmYeKMXcLu3bnQC+rOZ12nE/W+KDK2f2cz27kOZt62/MQ3kkVoAZV02?=
 =?us-ascii?Q?4vG9GqTRp9CHWH9kg4dPMMe7B5YPCItQoBdMxKVw1O7UIUX1Yb57yhQ6gnTx?=
 =?us-ascii?Q?0NIr3S1mcg3q+/hQWZqZ9hh06s7QJghFzWCL4J4LJDdOlFynDpfKiXNFRvIs?=
 =?us-ascii?Q?bhe49DDG21mKr9xJzPJtquTPuilTm7cs08OdPOCLJQ9EkCkB4GiWrygQ0L5d?=
 =?us-ascii?Q?e498d1Z9Nzn4LJ9n9kgKFgRt5/Z4QlyAjW79ujOCHJWF9o1FeAA6tYjmOtsi?=
 =?us-ascii?Q?MAqhAxqTIWEgHfYmiICxFPyJSAec6UVfVY0lXcaWHlOitlT0NrcJBWtlgHC4?=
 =?us-ascii?Q?1CU9Yw/3bOuQ31/dzG67gKi5Ziu6G4Kh8nHKYs6wAI5LIo7Nn9b+F8xb9ShN?=
 =?us-ascii?Q?z4zL+dlY09fsMar3eYdtc5nzdWs+VJ0OWChU2MB7rel6Ek1ncVFtlB6Gt8Ch?=
 =?us-ascii?Q?XafUObgQvVakTQu3OIRK4izyzNryAiIhH9AYzcw3a8arB0FBCl0eN19Wsa3i?=
 =?us-ascii?Q?Q1ces1QK8/VioAWVWr+i6RaFLxcq0l/pU4pFRiHDFuAvUUt3LFzgkeU5ybz+?=
 =?us-ascii?Q?W3RzWf397kkMNpevwbykAMl/bPh0qCG348CNllQpMH0sTKJz4txvRsiueKGl?=
 =?us-ascii?Q?1dkEwiHiBkFvvP+lKBv4D+r9b8id29fUaRj9XMMogdl6lDDVkwXCjNHHOAru?=
 =?us-ascii?Q?Uf9n0CVmEn7d71bbVNSehGCjv1WY1n5S0UK0ieabmmIhSavibIAdtG8RSQDd?=
 =?us-ascii?Q?R9RWAKJAq2zjrt+sN9vrJtoAe2IyGXbdDebcfoLU4cSogYcDWUlQt79BFukg?=
 =?us-ascii?Q?1Kwzya+TD1/wF+3QPjYYRa+k5yp58VpKlqLHs8fcBkJFhL4tkApFs3yiBmz0?=
 =?us-ascii?Q?h84Mv1izClOBEfJURcNRO2QqCjp+ik3Xp46aG3k4zwt+OT84BRQNmxcUnbqU?=
 =?us-ascii?Q?W38VsDzDAhpniwsAFDr8Zi9znXMo3uVxna6rsHU1bpL2BKC3B8fy1ujs7U7p?=
 =?us-ascii?Q?zHx+i1UALy/hO51LPzbvALB/0Mywi4sLlH5p35plsyjWgDkbbSJRtoP+eFPf?=
 =?us-ascii?Q?UJQpMBoVwXlJKC7XAQkRE6+AtMtIYV/6YlQS4KwpjUMNH7DeJd/79IZIV3X/?=
 =?us-ascii?Q?WU8KsRLKBejHzTqHLO35dPJwAAUsZdrQ+T7mav6gNxlUyf6OWYSDJZRajGE1?=
 =?us-ascii?Q?kzLxhTZaOEVu75O1dqysKtQcEDB1ya90gbC1QJPiAzF8g2kvFqzcOzrMps3c?=
 =?us-ascii?Q?EFu6gk18+w5zWhT9wo64/BVq4qDEu46f2dE73ABG0DKik5hBsU+mWZPZSMpS?=
 =?us-ascii?Q?yoj+EqS1BahBMH+QSmRUaZ+5jHvgC3U1121wmdFYkfTf1ZCTQo2QTP7gyhTR?=
 =?us-ascii?Q?umZ9Yo/io1nRNUflul0wCIIJDV5fdXQNGtJaH/e8dQFbsK7VrGVmJ0AjxLYq?=
 =?us-ascii?Q?tz4ReGzfvImqkVYLjg89slQMWX/ZrKPl+lWSBmpihw24vS0F/+Vl8UnFyPOO?=
 =?us-ascii?Q?GmP+NTJUC43J0j2PnjQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c38648a-d323-4865-19d5-08ddeab612bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 06:49:47.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: At5xPxdrd2f2LJCO3cUTy5grNg2dA/Ho3lr/UYIwajtzPlvtLFm9ATLENEV2QtdJx83YdHYxh3muY9uEPnhRcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8579

> Subject: RE: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can:
> Document NXP TJA105X/1048
>=20
...
>=20
> Thanks again for the detailed reading into datasheet.
>=20
> Yes. But I would like to only keep one compatible "nxp,tja1051" from a
> board design level, EN could be always tied to high for TJA1051T/E. So
> to dt-binding, EN it is optional for all TJA1051 variants.
>=20
> I am thinking to use below compatible in V4 for the devices added in
> this patch. Does this look good to you?
>=20
>       - items:
>           - const: nxp,tja1057
>           - const: nxp,tja1051
>       - enum:
>           ....
>           - nxp,tja1048
>           - nxp,tja1051

Considering TJA1057 does not have EN, I may need to use:
      - enum:                                                              =
                        =20
          ....
          - nxp,tja1048                                                    =
                        =20
          - nxp,tja1051                                                    =
                        =20
          - nxp,tja1057                                                    =
                        =20
         ....

Thanks,
Peng.

>           ....
>=20
> >
> > > If we need to handle differently, I need to add a new optional
> > > property
> > >
> > > silent-gpios:
> > >   description:
> > >     gpio node to toggle silent signal on transceiver
> > >   minItems: 1
> >
> > Ye, I think so. And probably add some if/then to use it instead of
> > standby on the relevant chips.
>=20
> Yes. Agree.
>=20
> Thanks,
> Peng.
>=20


