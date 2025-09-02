Return-Path: <linux-can+bounces-4417-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53485B3F23C
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 04:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D867AAC49
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 02:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64E27F00F;
	Tue,  2 Sep 2025 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bReQ2mwK"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116D4414;
	Tue,  2 Sep 2025 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756779894; cv=fail; b=TKRmZgrn83BEMsA+ipEJbImQcMMxo6/ZRYL9wpsALPRocXMpUFfbCbSAVyXcyRYXYBjazaNqnW4FwLs4QPh3xwI/WdJqBdqfC54mFa25nhaaDAKbtrczO6rY1ewcM8lmsAdWcrRKW+2oimzOL+5NzVAEpUoUoUov4nHTraWpW3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756779894; c=relaxed/simple;
	bh=FW/9vSBK6NLQvWy+CUum+LW9HJp8rarlF5t4SgtbQ1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KvzrLcgwrIewjrHUNbeYEuU3nYivR24J2yCAnZe+s/ib8iC/6ICdEe/hpbasyrN23IVJoJIeEAzIAg1dWUI3oGmOM1CrVtP8m4ph4AgxEI4ZBIVhZQUrc4bY2wqMAvE6O68Vher5Gln+Z5wev0jKPeeIZuHahDizmFpf1088WnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bReQ2mwK; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6NzzjQ25+CqtI5ir8J0kwxPI5pbhC4+hgz18X/gXR64X3HQHwZRDVpJL2d5ZjvWU+dvoIr175QpxKEaXbdI+2VPMSHz5seqNpVag/ajQqplHy0G/eJF28juH80t6BLfoQYEKsoCyB/yEEKnUtvGwMQqshN/QF52/QZUeqwDg1krMuAGcrWxgayEazxw0LICjAlhXQ2jRU5VeeJ3r0j3tQ5j8ZN0HhPFs/udoscXJvCZBvQxBVnSiGhYc7L9oUXXko7kSOHW7Lf1c256/S0E7hiUvXANu6gvU1RpCB+lcA/CmqZfGoaoQC/AzGyuwkXMZaeWsgfCC1bkKyHIo72qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHBBe9FVfVzBNg6ln+NujfylLw+wNMj0diBxoTnDClg=;
 b=Cx4CZvT1/csLwE/7uD7uDekYTQqqfCgkcwKeOjWgcDwM/ub2JWe1J6gn5doyVCIbpXSakAPdG607vZGourPvAcr8QYaRxD/LHJlFm7AmCW4dg6itXyYmtdLUEqNFfN9qltp9rgH8qwIE91RfbamGu3xmdJpXoVLho5WCZwrznqn8LdKJ2ZSJs6q2Jifh4fmP44L5zHOYLwJQqWClOODdGgNZk2zB8f5qOVRavmPpsZO8EofljWEJRxtDCAO7x3n+bo4lueK2XsamEvGOJuQ1ly8BZ+miW7XGvtvY0OlXJsUUV2AK2Dl1T8j6oy1sqDFZ1AojcPJEeCCJdRYcJv1CCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHBBe9FVfVzBNg6ln+NujfylLw+wNMj0diBxoTnDClg=;
 b=bReQ2mwKajl0vQAf5pLdK/UPm4fiYazSqCzoslSvzfSgtlNmYfJ+iGudq6vZV1a3JX76E3ZsASxC+dytScChamMVZ4ESvbuQ6pyc0siBKLwOE5GXjbhvuuEhNb/VBFXNwBYcTzvJqrGdE3GZPe4dxO73o5yJW7MJkD4fTZnNivAAL88sEQM7HZKah4RIDV4rWn1lFYEAVALOTR9p8nBaD2m8WIam0GMWGsKZrWYNVRJzITZrrG91J6avqh6mq8AjKpk1rNd3v0j8S7tkwx3bBirBS07kR2rXWPKbCcdHzeM4r+r3BtVDNJa/0irgxUA1l4NP2caBrdE8O2YiD5n7hg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8941.eurprd04.prod.outlook.com (2603:10a6:102:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 02:24:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 02:24:49 +0000
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
Thread-Index: AQHcGu8eo+bejDJ2EkauGvIH/Aa4g7R+rbGAgAAByYCAAG6dsA==
Date: Tue, 2 Sep 2025 02:24:49 +0000
Message-ID:
 <PAXPR04MB845991442136C0BEF0540D6A8806A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
 <20250901-can-v4-1-e42b5fe2cf9e@nxp.com>
 <20250901-diligent-dreaded-59b9ad5c3976@spud>
 <20250901-uproar-shrill-07d51ea21a29@spud>
In-Reply-To: <20250901-uproar-shrill-07d51ea21a29@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8941:EE_
x-ms-office365-filtering-correlation-id: 7b56359a-6e7c-45e0-ef9f-08dde9c7e45b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i3B1TtRo07krb+A6NnKE9yTRxxgFLWbVjbqXQddLjRZC8bIZjWwRerMuHrOU?=
 =?us-ascii?Q?XiKaV9b/OaCG5CQiX+GMZWGxVkk5j1I+b2znUUiW04ubM3V221vt0wqmMDY5?=
 =?us-ascii?Q?6pJlWnGRgZsWyl0JGX7J6BOpXC6zq/2fsdY8/ZpVBz52VjJ/IgnMePo3/gGs?=
 =?us-ascii?Q?+9DkuwvDYPFTTSKih1PWHXferGrR+5YJwwY26VYvnMZPFIcymoxXuRv/c6At?=
 =?us-ascii?Q?Y6IJO1w3qlSM+4wsyU+a0FZdIjDQlLcIKVpkbDKUNK1YzOODJVJQnS3wpX7W?=
 =?us-ascii?Q?AbQZvP9oQMjZmr3MwdSgq/X8roDTSy10mdaxIJ88+1GqXSqB9rVR0Nos/80d?=
 =?us-ascii?Q?UM+lcDYGAF+iiILHkjnwYazGHXyJOTywRKShEP+HXgWcd9SCzUPqAC2bBRYw?=
 =?us-ascii?Q?Tl0GqTihkcyncpKypXXnm/eWnXBVaRUTxSse/q0bJ/+PJOi42WkCLuzwF5AZ?=
 =?us-ascii?Q?mGYH2QYwQ48vOBxHxsd9aIHr6rYWb+geDktT06UQwYyFKSisnKVPDUdTWteg?=
 =?us-ascii?Q?Ad7tf3UtAY4gTIGLAzT4QKWPtn+ZufZvhXRVAy4XRMTFdfkLY78IukJeBSkU?=
 =?us-ascii?Q?WtwvYukjd1CkAxnoi+EIwQJP9jDtlP5KnOPf7pP3fNhXAm3tPWELAg5UNk1R?=
 =?us-ascii?Q?vEBz7UKFSkL3bIz4+2zww4lH4lkTBHX3EMcBhTJBgjwLohlwo1fxg07xWUZ0?=
 =?us-ascii?Q?eaqmyk+a39Xyf+gXTIAsHU4ihRfmqMwoi+dBpaB4mHe+NdmIArJ2ZmFghu38?=
 =?us-ascii?Q?eIr0hjzJLGisgTxJ6kRMuoNirBAFaEG1uO1fO5UUwYDTxZ9XRCSJ7KglCLKe?=
 =?us-ascii?Q?T1yg9gHeKxPBpUQ7gECRQVzcttYhADwFWuEPhM5QV6o4Mz1eNKNdXRV6ZXca?=
 =?us-ascii?Q?krbHmoPt1ZDUoguyuq53YUHKUWCgeqCQG+LtQC2a35JX2E78WtPzs9PkbR9Z?=
 =?us-ascii?Q?tsE56a0JG0oJGOD73a4xznn59NVT3pkkvQ1mmMQGP0b9dPDszo/oMwdo2ncE?=
 =?us-ascii?Q?ctLL6NdTxKY0E5QKJ/5qCmPfkj2W5kExPBp9yk2GvxcDG/29eHt9Cot9KNWT?=
 =?us-ascii?Q?DRn81qFidoXDfSAO68zHY9ZjxJuTasyk8/G9mel9hiCTNDlRuFmTaiI6IpaJ?=
 =?us-ascii?Q?+ghccqKc3U1vQrUpYJiXGVc2DIp2yfvP2S8VR0J7tlzYa0y+VgsJdcVYZ+Qx?=
 =?us-ascii?Q?4XodrgrwbdVjUMQs5o1bA/WGs3mtDUhUwPz6tUaT7Zgi5I6D7HLng0iTRZZ+?=
 =?us-ascii?Q?4A/Uiai8+Iptac3gVy+c105hpm/76hLEVgzjbBTcl5LryqHbqk8+ZyB/vVT/?=
 =?us-ascii?Q?SP5XRZOnNDojkCiYIDidNZ44DtGmk87UMEG4MxHaNthspJTBqHCKKkedEvso?=
 =?us-ascii?Q?LY0Zgjba7QTn1PS9e8YLZ0a0RXOllq3IygwvgSzLyXrP/Ja3MnfvITXxptKy?=
 =?us-ascii?Q?DCmqnjDVF3WV2iKZ3oMpOPNg6hMwDtZnUseRSAzEAW7B9EZE3fFpeg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wKzPW/Qr6pDMWN9y8SwK2EoNqLXHTWVZLOQEEpTmmn1FLAN4O1oPnpP3XkZI?=
 =?us-ascii?Q?BBnNIECFLih8VkshxaWaX7Mh1Ea1Q3qvJ6f26GUiB6cqUNPYjq5tEwMw6dCv?=
 =?us-ascii?Q?KANG7XjrHTqd+yRfHrUhpJ5ev/CjV3U8KX+XQ6zAPzmYHfUQGn9KlTFVADcT?=
 =?us-ascii?Q?Bt6NST/xrpEATbBbBqaJ0MdJRwXNrMl1nrDkHnUsDe+Lj+ArkClQze5xHbk3?=
 =?us-ascii?Q?fvV8iuNDMzltJOIilScS1r7qzxKbRAj26SqQT2u58axtZJmtSz1ZJmbgOit5?=
 =?us-ascii?Q?AglUSdDH5ZzbH7Ln18sOPBLz+stGNS3aeYmOO0TGrgIDKJTRe7qF2mMG1F9G?=
 =?us-ascii?Q?zUpdjVFW2Wco6T/f+srfFbETv+KWQ89uZVmGdYDXa01+2ImrIHW23aEic+oc?=
 =?us-ascii?Q?bldj++2toihjBT0q9F8bVPc34TATVowuV7/d2G4lcHW16ng9mVfEaToBbY7q?=
 =?us-ascii?Q?/8o+JeZc2QYijkB7MN/iVvn1DMT/qWAASbKw1mFuet0YqpHDkWIuFQAFj5D2?=
 =?us-ascii?Q?fitPj/N2sFB48oPl4VkNZHqoTbKYnChgOn5knGsggd70QfXCoITYl+485n7q?=
 =?us-ascii?Q?miSF1r6p4T7ba4FuRnLWUpgcUifyva6Pke5mt7M/dXY8VskWtR18JdJkxmkX?=
 =?us-ascii?Q?tECLReJVi4WrCdN6nAtS72JkbBvkjaAXlyPFywC5NWZVbM3By7Dt4kQW+brX?=
 =?us-ascii?Q?S5PtBWUT3AbvfQGEoFdxUjj1//QIXSjcJNeTVx6yVEnlfrApNfPL4Gnm8Ji8?=
 =?us-ascii?Q?FdzmYC1OG2mL2yhWwq4nDzVkbyDrIXyoYXged5nXM+3dMhF83jB583sJ+HD0?=
 =?us-ascii?Q?3KTRLowgilrfy8Gv3sArU2HEs7PMQfTWL8vS98r9rHz8WWChu/YXamBKWahl?=
 =?us-ascii?Q?XodG364aswQo4Xu0MGuxzxEOcH15vaNOzsMcMUfZ94I9yRb76foCA4C+n8fU?=
 =?us-ascii?Q?dCq0I23S8MYM+bnogc7xtZWZO4wrPAaP1e3SCJ/aC6qRCq6y4LXRRtJlwVjZ?=
 =?us-ascii?Q?+FPZ7tWOu1F6TniCl3m0tHf94Judw71nneP9qEln9xMCWcZmz7qlO6vShl4i?=
 =?us-ascii?Q?0llFbyRTdA2dAf46Pk1gRJJjZ9FKd9gJeC3iY7vlLOVU3hoYMLdw229zpk9C?=
 =?us-ascii?Q?9yjx70XsMiq7KV4V9HHVb0/1JRI4AIeFbts+Y0lqm6qH7Zess8q3yB0ZfTPK?=
 =?us-ascii?Q?EHjVe5mjnztTFkRT7XFj27jYr7a0tUC5Dacu5jQl4jH3mVW/Ib/JAjmm1tPR?=
 =?us-ascii?Q?zTeyjhZigpxV6pboOd4zyK7gtEIlpQCQWOQ67AdOyEg2EUuOpNRQglPNu0vv?=
 =?us-ascii?Q?0QTqdMomFVDoJc2RgMZhE6Pc0lVE88O1/RWOdvRJv8456auvYHBm6UCv9km9?=
 =?us-ascii?Q?nWAXJM8Mm82j5AOQr5rCuTLR3/8T9elLrD1eXyuyGHDbaKqsO/hpb2ux9jIj?=
 =?us-ascii?Q?JY3FDdu4EVPK66lTKTUsvXNZxGN+w4N25+GboltkeXj1boIFzCELrdWrIHel?=
 =?us-ascii?Q?M5jfb1uOTQEvrLwtN7Tu3ide5srYqo5mkLnuBkeX9v5+bqV7WTgUczomsOeT?=
 =?us-ascii?Q?T0facS5n1r71Xjpaabg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b56359a-6e7c-45e0-ef9f-08dde9c7e45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 02:24:49.5437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pI+Zdlp7+CBPIInZjLDeP0FCXwclfDq0s+giUTi6su6CO0sBjeQCxr4PISBoZLF+nAGzbqtuNu/yMEFfgeObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8941

Hi Conor,

> Subject: Re: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can:
> Document NXP TJA105X/1048
>=20
> On Mon, Sep 01, 2025 at 07:54:01PM +0100, Conor Dooley wrote:
> > On Mon, Sep 01, 2025 at 11:18:11AM +0800, Peng Fan wrote:
> > > The TJA105[1,7] is a high-speed CAN transceiver which is a
> > > pin-compatible alternative for TI TCAN1043 with sleep mode
> > > supported, and has a compatible programming model, therefore
> use ti,tcan1043 as fallback compatible.
> > >
> > > The TJA1048 is a dual high-speed CAN transceiver with sleep mode
> supported.
> > >
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 30
> ++++++++++++++++++++--
> > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > index
> > >
> 4a8c3829d85d3c4a4963750d03567c1c345beb91..f8e0c24856a2ba83
> b5c988b246
> > > 464f47e11a032f 100644
> > > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-
> can.yaml
> > > @@ -19,18 +19,25 @@ properties:
> > >            - enum:
> > >                - microchip,ata6561
> > >            - const: ti,tcan1042
> > > +      - items:
> > > +          - enum:
> > > +              - nxp,tja1051
> > > +              - nxp,tja1057
> > > +          - const: ti,tcan1043
> > >        - enum:
> > >            - ti,tcan1042
> > >            - ti,tcan1043
> > > +          - nxp,tja1048
> > >            - nxp,tjr1443
> > >
> > >    '#phy-cells':
> > > -    const: 0
> > > +    enum: [0, 1]
> > >
> > >    standby-gpios:
> > >      description:
> > >        gpio node to toggle standby signal on transceiver
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> >
> > You're adding a second standby gpio, which one is which?
> > I assume you mean that item 1 is stbn1 and item 2 is stbn 2 for
> tja1048.

Yes. There are two standby pins.

> > Might be kinda obvious, but I think it should be mentioned.

I could update description as below.
"
description:
  gpio node to toggle standby signal on transceiver. For two Items,
  item 1 is for stbn1, item 2 is for stbn2.
"

> >
> > tja105{1,7} don't have a standby gpio, but they do have a silent
> mode.

Right. Tja105{1,7} has a pin S for silent mode.

> > silent mode seems fundamentally different to standby, since the
> > receiver still works. Seems like that should be handled differently, no=
?
>=20
> The docs for standby mode for the tcan1043 don't match with the
> tja1051, "Standby mode is a low power mode where the driver and
> receiver are disabled," so does the fallback compatible even make
> sense? Seems like a combination of enable and standby gpios are used
> to put the tcan device into silent mode but the tja1051 has a pin for
> that alone and seemingly does not support standby at all?

Thanks for looking into the details. I also read more into the datasheet.

Tcan1043:
EN   nSTB
H       H    ---> normal mode
L        H   ---> slient mode
H       L    ---> standby mode
L        X    --->off mode

TJA1051
EN   S
H     L   --> normal mode
H     H  --> slient mode
L      X  --> off mode

Your analysis is correct. silent is different with standby,
but we only wanna to use normal and off mode


If we need to handle differently, I need
to add a new optional property

silent-gpios:
  description:
    gpio node to toggle silent signal on transceiver
  minItems: 1

How do you think?

Thanks,
Peng.

>=20
> >
> > >
> > >    enable-gpios:
> > >      description:
> > > @@ -53,6 +60,25 @@ required:
> > >    - compatible
> > >    - '#phy-cells'
> > >
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: nxp,tja1048
> > > +    then:
> > > +      properties:
> > > +        '#phy-cells':
> > > +          const: 1
> > > +        standby-gpios:
> > > +          minItems: 2
> > > +    else:
> > > +      properties:
> > > +        '#phy-cells':
> > > +          const: 0
> > > +        standby-gpios:
> > > +          maxItems: 1
> > > +
> > >  additionalProperties: false
> > >
> > >  examples:
> > >
> > > --
> > > 2.37.1
> > >
>=20


