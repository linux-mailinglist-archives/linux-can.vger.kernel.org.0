Return-Path: <linux-can+bounces-4423-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A481B41495
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082CE546339
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 06:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349E2D73A3;
	Wed,  3 Sep 2025 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3A4+4Hn"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6AB2D7392;
	Wed,  3 Sep 2025 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879242; cv=fail; b=bMlj0s2k8gEMPp6ZGPfqe40NPUYqT+/JigLEy+MkoL5LszS8D+5ID/zQlDcoENGCcHcD3ohUNp67x4xs3WUFYbZejV2Ogne0nHCFImYCTvntEuTDRW5vRyY6fecXiqphHwrslXCKKiaxlEk5JBHFb4G5eexEMcHReg/PF3Zov2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879242; c=relaxed/simple;
	bh=d91tIhgnzOXXXy+1SxVer8FHeHZbzPIgTdFK9DD/vvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ca54U5s4gqS/r2H4lZ938qZP2p6azzbq8frDBhaO/DvfceX+0GnuW+zKjOS63JtbBo/KYsMz3Mt8sY6aRavgoM6igdn8I4Lk74ZIvw1JDu0Hce8LF6YfkdtNfrXdSu6+6UEkDZ/hA4qS+hlM8jcU8Y3j20QIRF/dUv/DcQr0230=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d3A4+4Hn; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSs0LgusVQERC5MCUgHsBmPFQum2pQtFPh81tOaJ8GRaiOHu9/ABIKuLBz2eAbJukU7pDS7Ygz09q9k5rkl2824ckldsrtKOznwwtkoOBJnKBlYT0G6npjq+ln6IMv7wERVs12SPPqky/ay2uXWU9dswgMD8lloDOp1spyporvzMk6rZTmsVi9KwRXSO9v52D5sq1E8oVrkaPKZRL6iMkm4vqoAU0ww2vLqqrJsZf6FP5dQGZ4rdyIe/6fgeTQ8a5jcp6ICGCwSZvIBXwMukMtZHzKQtLLeAwyNuSh8QWeVZgw0plbt/CiUDXBmdJTt2w2KYy4H7xUg78VVTJOMTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHPX5nqMUZhNWh9qjLlniUHIxcbIRgpi1n9W3yPOw68=;
 b=lPoBlJx1TryOiJaRLSKn5hDnM9ast4x6EhLyTRUenwPWMUZDqRTwXq06/SXIH6hbTgw+R5E7XXx9g6dYJSopT+rL4+3dKpW8Hp4gHTZz84vpTnEiDD+F3fa/6GHOe+0fcYwnyRWAF6G30hhNPEf1ZOGc2zkRha32p4fOna2Evw1lzmoFU3WH+KPUclLDd7aw0QabHiDJVEJs4NrVPpTu6RSvr+7yOK4l81N2xHFBQw7bXfDVS4cTrgnxp/eo4InuTLYaxmaBmJ9NlULf4frEAQ6DbnqaG8bc9vwo9O0SQlzKCb7IJpW1hlj1No0krRtu8gUSynwfXVRcKXNKKydSqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHPX5nqMUZhNWh9qjLlniUHIxcbIRgpi1n9W3yPOw68=;
 b=d3A4+4Hn03vZGV5cxqmCHxdPnN3UJGmTG/LtsffvYenc3ZjjvOjiRL5GbuEYg8Zb4RyK8kBv93NkOtO2AjrxJQfbt6WBlgvrUZc0i6Ixs9+VVFgqPexJqqMfvDgb6tpod6qzuHO/B5QH4lhPSSUsAJ9pzOsIYknWN/WGY7rRFU2ofj5Gp0qnz6hjeuw87SRM1XSmt0/hiflAoF+VUEz9Y3EBQs5HYdqHXZf4J6YEyFI/x+AOHCc5n6j2tVDCB0OnsW96Z03HVELKAPsCGzkzbQLNpefcKLhCdcidLAsYJ/5UNY4Sc/nuP1MHgfd/006a9V8IFjtuG2QifOotSObvbg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:00:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 06:00:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Conor Dooley <conor@kernel.org>
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
Thread-Index: AQHcGu8eo+bejDJ2EkauGvIH/Aa4g7R+rbGAgAAByYCAAG6dsIABLGUAgACpkDA=
Date: Wed, 3 Sep 2025 06:00:36 +0000
Message-ID:
 <PAXPR04MB8459F58B1FCF532F0DE802438801A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
 <20250901-can-v4-1-e42b5fe2cf9e@nxp.com>
 <20250901-diligent-dreaded-59b9ad5c3976@spud>
 <20250901-uproar-shrill-07d51ea21a29@spud>
 <PAXPR04MB845991442136C0BEF0540D6A8806A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250902-dastardly-truth-fb2be9f68e4a@spud>
In-Reply-To: <20250902-dastardly-truth-fb2be9f68e4a@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS4PR04MB9505:EE_
x-ms-office365-filtering-correlation-id: 51638f83-b057-42a7-7c60-08ddeaaf33ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4yjgn7u4xFDdFsX6GVQZVkYlThtfOwO0qdbLP4HW144JGZY8DvboiRle3V4r?=
 =?us-ascii?Q?8u50lLuB6eTxtAwo9zg28cVvbXQVS2P68BgHCYLvbc4acDcbMxsyfaBXcEvg?=
 =?us-ascii?Q?6kWEaQmDLLXXaNxkAVTkjgMcPwFxNn/7bwgzSA0XiYr331Dc6SZaKsezhkai?=
 =?us-ascii?Q?my4ZVB8y8Gd+Met7AkVwmVnzBiBLJYprBhjwxNwE9iJdwFnB5XN2PTlssm1S?=
 =?us-ascii?Q?SFcivUHzw2ymaP1D4h/FSO9pOUwT4khmKdrqroSM2X12q0gK780YfNUOmpIS?=
 =?us-ascii?Q?jRF45F9t3UDmeOVxTVJ+oggmSkQTnzssDKv++obYaUHH0aUocaW2AduDEyeM?=
 =?us-ascii?Q?pqjJd4WaKf4PBkY8XLfLkA0nbvZkUNjObRDfVYH9tGbLxAXpIhTs1Gy7OtZR?=
 =?us-ascii?Q?Px4gzV2kJofFJtFodRRw3sfxE+cUcY3X4QIJIXZj/QPGl4HrwMkjYd7BRsB+?=
 =?us-ascii?Q?C+atfb5gSFqmluzzNy9QKh3i4ZITLlAp0/HbXukc43kfudvh7DJ00p/TlqBU?=
 =?us-ascii?Q?OjEQN+H7LQ1pispF65mwyYYyXISYvcC+4h1vY4/g4L/KR0cPo1G+fekpfkO9?=
 =?us-ascii?Q?7vCChKRpYDeUNwqXUiX/LYetQyXGhZpf3vDvyQ4hrt8aVRKB3p9yY0o0oypT?=
 =?us-ascii?Q?1twl0Ha68ty8+e3sU4NYmL742vosS958BeydcRRK1oltvCKgrRi/fFt6xpa5?=
 =?us-ascii?Q?2TcTo93i8rw2JuuLMvSmLuns7enstP3cFquxfCIjigJI+YIH4JdVqCEDVJ3P?=
 =?us-ascii?Q?v1O6lwg9zeX7xhCXw7Yy5OkuPx0Wy90fKiO+gMhHHs3Wtg7lZImwlSAiJF02?=
 =?us-ascii?Q?tOrTuuQ/7RqrtwoF1jVAKkxmkiilCH6LSJx6CM5EIoIQBBBa4Vh2Cvai92bd?=
 =?us-ascii?Q?IWmPJTO9VoeWU1hxI97/+cOAU5piDAxYFYtEquVCWpOlrTwoDd0obeUtBS9I?=
 =?us-ascii?Q?xUPW6X6Zhb02qiDPYCLp8V00q4kheAX1bOSmVj1i3M9fW3pUBxs9OB7AqHLQ?=
 =?us-ascii?Q?ZUorFPtzsy9uUVxXdciXQFP8x2uEnSxm4jr+mm4UC5L4i7gmvjI4puzchVre?=
 =?us-ascii?Q?64GQvtDIYhmdtJlU5AnM7PBvWqUfGpLtm1FSVeFzDs47VKJJfDP4uiu8DvRg?=
 =?us-ascii?Q?fx6MFqLDZly61ebkPFKZHA51WhfikoS6rVydfrYaZve0B7LWMk1jTPhN6JeV?=
 =?us-ascii?Q?nMuUvPklbYJAJFwxCJiP/EjdpTRwQiF9Tzgxk+H+Nm8iiNZWGJtr0URkLqSU?=
 =?us-ascii?Q?yHCKJXnc+iuNI/0OLofXQQUMNrJ25/2a2sPqh9+OsaJ5smCfOeR+slG2bNgo?=
 =?us-ascii?Q?DockuJ7YEU1ap9YW+w20xZbQ0Hh1C9u+oQOUwfq5HzKf3WjkxCnFFYxw9lJH?=
 =?us-ascii?Q?eQVmqZxQ6Q8Fx1L0eLsdOtJ3E9gpG/2t8LJCefDASBwGioY0yopFd/GUkG5G?=
 =?us-ascii?Q?f0ba2mCfccF6GiPliet5dNP7QIzwjQ67zlZscziDnNPhBpUWz4NRyA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kRV9l74uZDAlRNPhZRfj6q27XetVscvJtzDBetNdm+kZJbRqGJ+CTyt7KFn8?=
 =?us-ascii?Q?mVB02Bfzu3qWUypyGpHP2uPs2t4yanGLLfqry5cBaewFfaZ2gCD/ywIZE/fl?=
 =?us-ascii?Q?sZyLVJXttruJIdM9Q8ZGFtYkZ61Spr5Eyz6bQTTLNN/esmYt10c3c9OCg6KA?=
 =?us-ascii?Q?Oa/4aHic+aD0wF898Fir+FW5rex0D+QkbMbDFVKqG2TWCUSEhxLhn72ah758?=
 =?us-ascii?Q?sCGNBPxegZuycZB6liZP0IOlaGblsYfMJtZ9goRtCg9L9xUdik6jAZgoS8G5?=
 =?us-ascii?Q?KUGM4eRCahlRCDrGf8Xs3PCgV48OaOqTGXL+5+JtGLg6hAybzs6Y2AccSUZx?=
 =?us-ascii?Q?gmBTkxXlHRKSscs+fo6kAZhhWk5Lb47A9/077fAlPnuTJ9rSPka1p1LgxCWf?=
 =?us-ascii?Q?sNi8qB6/oGTUnv0SE7I8Ihm7F6AahNZB4qWnMOchMIHkM/wbJ4O5R8TX2qMX?=
 =?us-ascii?Q?Xdvew+/JWJ7Ask/LklSrUpOwK00ot4wgbr4a4l+bSxAW3mBTIkW2WPlvImxb?=
 =?us-ascii?Q?qc8H0C4QtyaQ3Q/gwgxki4kfu+R0kvjhO/5dp7N6/atrVoqdePc+xzy4CRMs?=
 =?us-ascii?Q?eMlfnNlqPilBPKmiMhvPfPnnuZEv0NM8T3VkVznSVDnLcpvwXTIMJb2Wz+Ak?=
 =?us-ascii?Q?lzgj05AiI8UIAlUDQWmiz0cfL2MwlkBB36iRYDe+W79/KyPAthcS5SU3RjgR?=
 =?us-ascii?Q?jOr6zCTlaLiEUxtdGcciF5cZYIAiE5VD8tat30ODvFjI9ix61ZE3hlr5ri1f?=
 =?us-ascii?Q?wfmmlDBXvY/AlxpC6CkCc3fGzweV9cr9Od9HbULZ7d00zcELSfMTwGJG930E?=
 =?us-ascii?Q?0PyAar1gz5y1SPcUOIqjJOa8UYMdEQEoKZd77Kg/xw7xq1uiwlMx+/M4iMpL?=
 =?us-ascii?Q?1QHGC3mtg/LM7Vu//8TfB6bgHap6Xk9fnxzIX0mCCwpkcEuTW3RWFysIsaMH?=
 =?us-ascii?Q?NcriTs/m7Pr+lKiLkFOICmAwPYJ0HB0fktjufaRFz67/1y9B7bQ7M0G0532g?=
 =?us-ascii?Q?eW7n78jG5UeTzpzlPkQn8hiCvWX0aWyhZ1asDkpzTCI8vrzM+RtIbDMgqhDF?=
 =?us-ascii?Q?JxFmtvKYALPTfjWRL6SWyP1deQLXI5Y6e4gw8DP+sZj/CrivgjIpYpfHQ1q0?=
 =?us-ascii?Q?e4kFoixSMOFKwrdiilI65X5j5EGDOQp5Yw2S2bNyzdKlnVeKc6tMBoNpA1vX?=
 =?us-ascii?Q?VDA6kGMTHiBP1T6DkSqbGDy8DwFIh7b51F1clctIBg3pKvG8fqcozeqqF7k6?=
 =?us-ascii?Q?7UQJHWMf1N+v0Eu4x7BBe9a0flehHGwFfCX1iI20cdpmm9qIvK3J++b5S9Dw?=
 =?us-ascii?Q?/CTq8/2b3UQNI7SPwr2OijtQ4HU/fwsBYHyb5d8AWYL1kLLH4VkMTY1vU5yt?=
 =?us-ascii?Q?8FPa6DToQ9vipf0MPznW5QyUT0zp4Pu3FTLV1N2bVdxF2Y8K/0bKQ0pcC+F7?=
 =?us-ascii?Q?LHc1J31fy+/GWqwMXICwXO+04RssdwPO3csLaXX1+mS45zpFfSjenRUPNSRm?=
 =?us-ascii?Q?WgNSojJM/43Bl+lnMqO4Hja8KkNB/XYM19/5nUiEzm0Ler2viV1CzcRTE7ST?=
 =?us-ascii?Q?js/cjHN1VAbB2x3NDJI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51638f83-b057-42a7-7c60-08ddeaaf33ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 06:00:36.3143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYsiG3fEIN1xKozx6IOi+euB/VvbmGx/c3PHhw/jbQP3pa1dQJffZEBLmQSgBjZ2E4jCnDzX9xN/DWJDrdzg9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

Hi Conor,

> Subject: Re: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can:
> Document NXP TJA105X/1048
>=20
> On Tue, Sep 02, 2025 at 02:24:49AM +0000, Peng Fan wrote:
> > Hi Conor,
> >
> > > Subject: Re: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can:
> > > Document NXP TJA105X/1048
> > >
> > > On Mon, Sep 01, 2025 at 07:54:01PM +0100, Conor Dooley wrote:
> > > > On Mon, Sep 01, 2025 at 11:18:11AM +0800, Peng Fan wrote:
> > > > > The TJA105[1,7] is a high-speed CAN transceiver which is a
> > > > > pin-compatible alternative for TI TCAN1043 with sleep mode
> > > > > supported, and has a compatible programming model, therefore
> > > use ti,tcan1043 as fallback compatible.
> > > > >
> > > > > The TJA1048 is a dual high-speed CAN transceiver with sleep
> mode
> > > supported.
> > > > >
> > > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 30
> > > ++++++++++++++++++++--
> > > > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/phy/ti,tcan104x-
> can.yaml
> > > > > b/Documentation/devicetree/bindings/phy/ti,tcan104x-
> can.yaml
> > > > > index
> > > > >
> > >
> 4a8c3829d85d3c4a4963750d03567c1c345beb91..f8e0c24856a2ba83
> > > b5c988b246
> > > > > 464f47e11a032f 100644
> > > > > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-
> can.yaml
> > > > > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-
> > > can.yaml
> > > > > @@ -19,18 +19,25 @@ properties:
> > > > >            - enum:
> > > > >                - microchip,ata6561
> > > > >            - const: ti,tcan1042
> > > > > +      - items:
> > > > > +          - enum:
> > > > > +              - nxp,tja1051
> > > > > +              - nxp,tja1057
> > > > > +          - const: ti,tcan1043
> > > > >        - enum:
> > > > >            - ti,tcan1042
> > > > >            - ti,tcan1043
> > > > > +          - nxp,tja1048
> > > > >            - nxp,tjr1443
> > > > >
> > > > >    '#phy-cells':
> > > > > -    const: 0
> > > > > +    enum: [0, 1]
> > > > >
> > > > >    standby-gpios:
> > > > >      description:
> > > > >        gpio node to toggle standby signal on transceiver
> > > > > -    maxItems: 1
> > > > > +    minItems: 1
> > > > > +    maxItems: 2
> > > >
> > > > You're adding a second standby gpio, which one is which?
> > > > I assume you mean that item 1 is stbn1 and item 2 is stbn 2 for
> > > tja1048.
> >
> > Yes. There are two standby pins.
> >
> > > > Might be kinda obvious, but I think it should be mentioned.
> >
> > I could update description as below.
> > "
> > description:
> >   gpio node to toggle standby signal on transceiver. For two Items,
> >   item 1 is for stbn1, item 2 is for stbn2.
>=20
> Sure.
>=20
> >
> > > >
> > > > tja105{1,7} don't have a standby gpio, but they do have a silent
> > > mode.
> >
> > Right. Tja105{1,7} has a pin S for silent mode.
> >
> > > > silent mode seems fundamentally different to standby, since the
> > > > receiver still works. Seems like that should be handled differently=
,
> no?
> > >
> > > The docs for standby mode for the tcan1043 don't match with the
> > > tja1051, "Standby mode is a low power mode where the driver and
> > > receiver are disabled," so does the fallback compatible even make
> > > sense? Seems like a combination of enable and standby gpios are
> used
> > > to put the tcan device into silent mode but the tja1051 has a pin
> > > for that alone and seemingly does not support standby at all?
> >
> > Thanks for looking into the details. I also read more into the
> datasheet.
> >
> > Tcan1043:
> > EN   nSTB
> > H       H    ---> normal mode
> > L        H   ---> slient mode
> > H       L    ---> standby mode
> > L        X    --->off mode
> >
> > TJA1051
> > EN   S
> > H     L   --> normal mode
> > H     H  --> slient mode
> > L      X  --> off mode
> >
> > Your analysis is correct. silent is different with standby, but we
> > only wanna to use normal and off mode
>=20
> In addition, it looks like there are some tja1051 devices that don't even
> have the enable pin? Of the 4 SKUs, there are 2 that use pin5 as Vio
> and 1 that has it n/c. Only the T/E device has an enable there.

Thanks again for the detailed reading into datasheet.

Yes. But I would like to only keep one compatible
"nxp,tja1051" from a board design level, EN could be always tied to high
for TJA1051T/E. So to dt-binding, EN it is optional for all TJA1051
variants.

I am thinking to use below compatible in V4 for the devices added
in this patch. Does this look good to you?

      - items:                                                             =
                        =20
          - const: nxp,tja1057                                             =
                        =20
          - const: nxp,tja1051                                             =
                        =20
      - enum:=20
          ....                                                             =
                        =20
          - nxp,tja1048                                                    =
                        =20
          - nxp,tja1051                                                    =
                        =20
          ....

>=20
> > If we need to handle differently, I need to add a new optional
> > property
> >
> > silent-gpios:
> >   description:
> >     gpio node to toggle silent signal on transceiver
> >   minItems: 1
>=20
> Ye, I think so. And probably add some if/then to use it instead of
> standby on the relevant chips.

Yes. Agree.

Thanks,
Peng.


