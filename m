Return-Path: <linux-can+bounces-4399-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF31B3BDF2
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A3F16FB51
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0816F29E110;
	Fri, 29 Aug 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kVZ7MRZ4"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D68F58;
	Fri, 29 Aug 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478144; cv=fail; b=FwNiKXXM89ZislC5hbZY0BqCwEF0VGkIuBBPZmbJXoi/OWU3d9llzT+NBENaCUB8cMZA9HJzpMdUM+dLx6fqFHJbvYpBjf+EH6NEZqkJeTMm9crleerl8FGZB7rC0ekL1z4sLdvHDdPCbKoD+KrPq9otaBOk1X4uz8rvDsG1wHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478144; c=relaxed/simple;
	bh=C9K1QEjmEYafj5VHU+6xgd0MVlTRO4AXfeT/eM/bWuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWt0MlY4ilRTKgqMmdsYUutpIMM1jyitsXATs45JiqKVd8niXvttWTUEPqp+Wf3l5X0ZMveabUy2qh+pVteAUchD02leXeI7/gEw7WNLJ6sTcfpZw0a/n3dLX9txn/67jWCCOBTHemkFRIDu7b2wmv7UAWmkMqeZKnC5+C+eFzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kVZ7MRZ4; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iy8gabBJRzvOurP1a9Ap9fUT9hWTLHSsFaD/6sL8WZfAHZHblxhKnDk1CZvK76wpVlzk8ht4XAx+a8vMXdWlmU1af1D3+SMuJgZ51b3wVpge5bcxGCuJSDLaRLTFxqGSYA6+drSbJVSrJBoOM54zqbjB/3gtZzqF5+aU5L6XDwakXLFOyMPWdX29xDwZ/I7j0twkVSoW68S/qnkeiXEKFbCT/S4ykQoljoB3BWQdd6wqdLT0w/jupivDR8ro7WNa5oAR9qs0gPdliYBxPC5cTC+TMwt0CjSKnEIFMbSoJN/oo59x3PjZi3aPGaNzkXivf+QH6efvJO+1jLACLHFPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyFLTYacxSwteVWhGgeVtgGvpTwtZ6vL5TO1Yu/gXw0=;
 b=hgYTmPNI2hd5DVeO6jgPgobl9TpQzjd3IoBZtqxNTjeMSfwfS/vOTZTEqhmPIlp982xKZxr8BXDZto0dzSFOWTCEPowZGdvKiZp4SgucWZ6ZobVmEy/iwgH0X7piNRJwJW+EW0mhkAoTufzE080WkJngD0X61rmlR73jI+0OROMuEF0Mg3B+t4DK+Fd544T1pBbRmaoXIBkS5mRErrR9rqOSrXjxoR1hPDlF/dipLZE00poRA/YlEy4AAUiMs+p9Cb/qQZDMJfEt7vizUSs63OpE6MBZSNQiZereJ3Z1adIyIWSv0vMXtIRAa96DT4X5nAO7qJBJ3ldi7R6bQa02/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyFLTYacxSwteVWhGgeVtgGvpTwtZ6vL5TO1Yu/gXw0=;
 b=kVZ7MRZ4Pge6aLTjCFGilb04yXWokODSiEqItYVDLNbskVFOsaFKAFoUcVlcWc8DI15x/fsW/43TUEfhBIzJYMD/oW9Og4AUwY9WDK7xUHCkbX0oLi+ZqSX0omXVUPtVCL01URaZmSNPie+LZGS30hSVXv2itDI48gqbGlLw9B0N3viVT013jE7K22hAXL/ZMbTy+FMv4+9p2vo2zoAUjBjXTjLEr3vUSWsbUmQ7e3PCFnTKdvCExypWfNQNNSO3lc0/Pxpwy9aqV+3Ngk7hJ9bJ8rSBIItMGEfvyLTlHmlIZ8WJXVzZQQdID59LTnomTsSo+uwc2bxOlK1xKyT3yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Fri, 29 Aug
 2025 14:35:39 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 14:35:38 +0000
Date: Fri, 29 Aug 2025 10:35:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/6] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Message-ID: <aLG6sKiHLHbVP3os@lizhi-Precision-Tower-5810>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
 <20250829-can-v3-6-3b2f34094f59@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-can-v3-6-3b2f34094f59@nxp.com>
X-ClientProxiedBy: BYAPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::37) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f9832f-e524-4d42-0dd5-08dde709528c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i0AYGnlNtPOIid0vFIvEJS4yRs89DdB2qZaaUU3tmW/7QheTEzYlA1gfM3pz?=
 =?us-ascii?Q?wmMEaz0JueUsxWZu1I3IdcqlDwUFVil9+0Rp/XQi77J4X1c+9xQ1+LZX643R?=
 =?us-ascii?Q?2FvVfi+dTAXrfnFzDU53hNve9I1PKw25ltP8nuSwymbmB2PPp6lIehxi3l5n?=
 =?us-ascii?Q?oXwlx+YlokWLCR/LElTkrl+3Gv+AeDzW8LmkmKrUPTqVn5LLLI2I8xk9VnzU?=
 =?us-ascii?Q?n7gYHXNsoD2gK4P3L/2pUK0VMIEvfdYxXAS/vI9I2BbUXJUt8iggp1WdnTiZ?=
 =?us-ascii?Q?vRvbT7Xf+EmL13eeHMBfSHUuBLZJxdSYZ18RxLyROxQ5U5eRsvd84ya2cs/G?=
 =?us-ascii?Q?xivoPh1SSoQLQIKgAmOV7+ci3ZT1aQfZ3f66QWaSCtu2wj7FLQuoSHcIV3S5?=
 =?us-ascii?Q?sVGYwMB/YxcfMaoPp2u0Jo6Z5GXLb8luW2OQ+t4o0GT8fXToZm7OsVWA5Qzr?=
 =?us-ascii?Q?86iJI139RWQhCG8/SoiWwEuT/OlSbBZUosrdZAjAoGE/YltxLmbZO2wPHRbB?=
 =?us-ascii?Q?Ky/DfFfwgmWzyTmKRNLbxzen2t2kNsXO15DEWY/hH1ildrHgwgjhumh2NiE0?=
 =?us-ascii?Q?17K0KXiLShRI3PSQ4hBy2WIzVmIr4+rNpn1OX6eUJxI5lK+Xcng/RvU7oceU?=
 =?us-ascii?Q?wS5uCBulefwI5ywMxtaWdyWWz0+YMKarci6b/EMsRF/uEW9l5qZWSQtgmVyr?=
 =?us-ascii?Q?pIO3ytST0bpLnJTDQzJ0Jqtbo4qL40Sy2MLD16/7q/BwGvw/98zdP7732hIT?=
 =?us-ascii?Q?iiLY6/sz95esg7vikHKCLWM+YwGAxqZmrPte8QNw9NqePYtlpxh3BuqngUXJ?=
 =?us-ascii?Q?fnIg64wWUgpJO5DsDo9JW/1sIubmdrnbV4PFsvAgghDc0/oBqnhHgvSGRL1E?=
 =?us-ascii?Q?cyGMIvoFO9nFYagJSGZGOzlb5/gfqAJltG8GaljPSBq7xTUIGBWP0BLGlYZd?=
 =?us-ascii?Q?K1bkzZFi3KTkZnggc94AIhtCIkMhyxD8Xo88CGK4mvTYIoxvV+UeB9gvkpHn?=
 =?us-ascii?Q?sZeHmpVnAG614MJz/So/CGDEqyEeGBQizvsUk7PsykbknSjbxkmWbmOrpBXb?=
 =?us-ascii?Q?feVDlrGLNWMTA1Vs+XzF6cHnjCyMCKvo6ow0sAPogHChILxdjq/zrv03SS5v?=
 =?us-ascii?Q?igKdLUUZNjn9dzY+LOFeYTrbModwynlC56nX7zzF2AZbTBBuQDHWYk3aWpxI?=
 =?us-ascii?Q?n46nlXn2tgr32falV48s+JpLhph7hi8eeVAKqbfrqO6HingQf1ZdyBYKpjpJ?=
 =?us-ascii?Q?CMEBcaCdlr6RxWILsaAAPmHak8bhT3eRlD2qk7FhIShIhDXYQRcqyW2kI+ku?=
 =?us-ascii?Q?lIpLXdL9OTbXhrfedON/coLrMHYcHtPtexmFiiGl7jkZnS2/Ak9NEWcg+Dgk?=
 =?us-ascii?Q?8xFKhDbrBVFqVNGDQWHV5mJwe57A1XLNcg7KmMn89x3d8kiGi2twmbWBobfH?=
 =?us-ascii?Q?x+mxkIdgyj00C3eT9SnUkl4K5I1ZUsGS9hE3/m/1QkggTA41kw94Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y+Lxoz+b1zgRFqtES6wo9JIe1Tgl+XOxX9kYTIr0dV5f7gvpCFJKJ0wMjVSt?=
 =?us-ascii?Q?wSQg0a+/qjxk+CmjV2cEB/NfoGJ8KT7iUkJJDU+JnLxG/hJNLg/73kZ7vZrE?=
 =?us-ascii?Q?JQQ16T41q+QaooAx2zrCT9EIHP7QNvoqT5I88bw+3vh/glN0pE6wbXklri1m?=
 =?us-ascii?Q?lVP9a1SdhUU6qjBPkfh4kLNQ0fnf0+dtoA+kuTpcKSVv2V/8T742QUUKCcOI?=
 =?us-ascii?Q?YAuX/H3jV/di5C1e5q4q2SudHprw/nxeapCGH7hTCEqOBKkSPgHsaUCi4pVs?=
 =?us-ascii?Q?iMkEhTmXJw/HG/xuJvB2S7NjLOACRIP7aBTdvkV2JgZILVKIc2XvwpkeMguc?=
 =?us-ascii?Q?u+aNDFxPGoN52jAmj7UAWOkyL3yBM8nMZHMO5lRaqoHbiRyRqA4Kie7YGcKy?=
 =?us-ascii?Q?5+TT78rmNpIERwuvg/AZFZ2zCx9CZyqjj5zetk5waN9i2JoIKopDMKyRuwqy?=
 =?us-ascii?Q?R6HaZCZ5Ch+fPr7FAXHQ42LylhkuQ5NnW/3jJtoU9B9EYr2wud8yUH4uK2/Z?=
 =?us-ascii?Q?3y89Yiovd8byxgOYk4ro0BprjoX3kLPQ3eya22qWAT+qe8Ix2v2mru1D81sG?=
 =?us-ascii?Q?r4DyB4hgpx6NAs9Pvq707I2ajRzmYk79KkMD4OvFfazhRiZFswuntiPtZZ49?=
 =?us-ascii?Q?o0gZqFj2wOy3G2MFSIhU4X/qjGtMieEtF3jtCYwuj6bO3r7J/hsMlNJirXhk?=
 =?us-ascii?Q?PuKn7hL9ie0qPAybppXr9/epBlTgZ26cZ2IhegJYFL1bFGzKEsE79tZgKJ53?=
 =?us-ascii?Q?zXh27/K32ubGo/mj1X6iPi5D+ZCJNuUJQXYfXzeIXFkJCJkPCBR0yFqUobx0?=
 =?us-ascii?Q?FYzZkxklffTxkrmcmd9tAzbFeHwxEUzHGUWmLJoCplMI5g0NqVjDEDKnIF4v?=
 =?us-ascii?Q?jSxxIfZwbgAcSRrxTeoyq2Bic4CHtuKW0Xx7bZ6XGbWzmwkLt4wbS6vaCqH4?=
 =?us-ascii?Q?I+kIhd1rdE1hWDZyesUmOdQ1yV9RJhXF9wKCNlRVyLvjrF+i1ClG9Y55R8YU?=
 =?us-ascii?Q?dt5FCxTmqGacGCi+DzSQfEDBEsuy2DV7RZDdbXEXt20lw1rKpd17NCV1Bdn4?=
 =?us-ascii?Q?YK/x6fk4S5SNyHH694bnt2C9xHWl6mMOt0MHXILnw8tn0MdByd6ltPs/D8vM?=
 =?us-ascii?Q?456veOOBi6t9uvGek38oL3ZxFGpS6SBgfI72qX5Di4PE3xAXcBeZF+Y5b3gC?=
 =?us-ascii?Q?WAxVkLW4srEJ02kAK88XLN/MHwNggXzT7xaqA4yvKve6IVw4TjAtg08W3ury?=
 =?us-ascii?Q?5P+Y5SlKZCrOAqpjqsmtMsR2VlJ93UoQZJNn/0jDl5zMXhFJWjyfjP4UhBZg?=
 =?us-ascii?Q?grsof3OEL+3UpIlkEjD/KbCf+UAVm2ck+ReVi8ndn7EbbuVRb6CrvRdOUmyn?=
 =?us-ascii?Q?5RNOn1SZTjqkiQuQQbUEHetEhHTW+n6ERBX4401w7qfW97ZXD7qnfmHtxG2g?=
 =?us-ascii?Q?6hLXZo1yw2DHHRHyKOVZVM+h6PVRNBCUfRObV9/lZqY6hCf6gjIN7Md3s+G7?=
 =?us-ascii?Q?mGAwnowXL1ukIXR3TO0EkIRoEyS3IWT/qKZo2zjwJSmYKSNA8eaVLRNXenGc?=
 =?us-ascii?Q?sP7hGf673SGlzCLPioPZMMMHBeH0fQiCUk2mGGV9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f9832f-e524-4d42-0dd5-08dde709528c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:35:38.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PLurUoy/g46emT7i5sW85E7enMf5Y4IqMIVrpoAEsRZ7hdjK6v8FuHdDbcJC4Oz3M7K33GQkR2FE8XAyu/Szw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

On Fri, Aug 29, 2025 at 03:09:01PM +0800, Peng Fan wrote:
> The TJA1057 used on i.MX93 EVK is actually high-speed CAN
> transceiver, not a regulator supply. So use phys to reflect the truth.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index e24e12f04526c3a08c0bdc6134297fb010e6e926..4c52f22bbfac99722184b4d8679f48c4396b557f 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -62,6 +62,13 @@ vdevbuffer: vdevbuffer@a4020000 {
>
>  	};
>
> +	flexcan_phy: can-phy {
> +		compatible = "nxp,tja1057", "ti,tcan1043";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&adp5585 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
>  	reg_vdd_12v: regulator-vdd-12v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VDD_12V";
> @@ -87,14 +94,6 @@ reg_audio_pwr: regulator-audio-pwr {
>  		enable-active-high;
>  	};
>
> -	reg_can2_standby: regulator-can2-standby {
> -		compatible = "regulator-fixed";
> -		regulator-name = "can2-stby";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		gpio = <&adp5585 6 GPIO_ACTIVE_LOW>;
> -	};
> -
>  	reg_m2_pwr: regulator-m2-pwr {
>  		compatible = "regulator-fixed";
>  		regulator-name = "M.2-power";
> @@ -284,7 +283,7 @@ ethphy2: ethernet-phy@2 {
>  &flexcan2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan2>;
> -	xceiver-supply = <&reg_can2_standby>;
> +	phys = <&flexcan_phy>;
>  	status = "okay";
>  };
>
>
> --
> 2.37.1
>

