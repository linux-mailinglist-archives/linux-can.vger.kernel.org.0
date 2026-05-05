Return-Path: <linux-can+bounces-7500-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIL+HhTG+WmmDwMAu9opvQ
	(envelope-from <linux-can+bounces-7500-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:27:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECCF4CB36D
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0532E305F56D
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64143FAE1E;
	Tue,  5 May 2026 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TCarC9Xi"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3733A9DB;
	Tue,  5 May 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975574; cv=fail; b=iONrgFftbNiydYhENnFCXcnNJKOvu7b16rst89Mdc7ncTqvk+nXPpx5E3q/0WIBc2w0ftFsIC00rFZzawH9HhVxmcny1IlAOFXBBAf23kFh3XnyVxRRu96zPajnFXJYH2uK4dmE0znZZSjq/PxWLlAtYaUpdxaPnmLCO9IUtuK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975574; c=relaxed/simple;
	bh=SYXTVr/5771eCGd7rMmYbkCnuWgSL84ABvxAeLG447g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zee4OLF2Fm8a4PlVCQM+CNm+jRvcncC2iV5qn8ubh3bGTgl2s5HFW+rdilpwaVuN1jHLh9zwRfqAUh+smP9xLdneGTsTRJWpN0Zgn0wpKZw/TPGFUJqnl9u4Vf4mwyJTdi7F90lU4qk6LmlsMJKLTJ5X+DNG1Iq5AiY4fFswOeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TCarC9Xi; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g26yx/JvVFeKw0kuns/qvqf21hvG56TG1Zx4xMt+pmPrDydqTLJe8IeMXieOWlTxiMz0bKOF3yyKRYDIi4bCKUUiktTuKKq610apl86metyJ9FrWhRvo93Czpru7Bh5fweUOoPoJ3cn/aTf1g/3ywm715AnG0XrNztWthifFJ7e1Fh7u229ZtYLAT9ZtlvkTSww3x4gN0YnjNDKF7nbKq6lv73ZOKiaNf+yYqsZoVfY3S1YfMXiguLu+Ee3X/A7rFjO7uHCI+d5A2/sOOp1XjjC9rj/z7d3IWvJGdlu2AqSWUgjL35A3FtJBzBuJPiIqVRKd79TLst+afQG3Q1iayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYAW3Mf5UXamv/g9VDqzzbVHVo1IqRgXCFZ4dRE6avE=;
 b=mmT9aqwUmfQthXIZ0nf14QZ6NbFE9Z5E9iUf5GB5m7M30qBBy3SsnR5QvcUCxClRx+B9fXtJeqr6bvEH9kFEQbT7AdCwDqbG+5MyqkyrRXwfhOPLA7E2wDupWy7ax4bP5pvOsUbkOCcbTJ0bUvMMgfWQBc3uh/g2EZWgB6i/x1wk8Z4eEUxN0UwfB4IBFLLWRDbJpef8sqmUZezv37o4TyuoNzbMkkJHJE6Sld7Q/74yFNGFvTeWjdXLKNFqc/nxxZZnzOPE9C/jj95mRcG7cVXCfCHLRntkXshBO8SHcYsN+T7snWycbXkwdR7Ri2o17xejGRB/iIW7BGwEsseZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYAW3Mf5UXamv/g9VDqzzbVHVo1IqRgXCFZ4dRE6avE=;
 b=TCarC9Xiv1X/aTX8Q3Y5pxc8dmztKKCw54US5enQ8u52WM8DBqjZD2eu9N+fMUanRHTbB+ar8SB2kggX8DFPeYhMPb4m+M45OKimqhymu0TyZJkeJStXw/8ThiD0wVX1i1HzDIRwH97e3vYO9BtFChYfkr/pM9kKDpM4sfNs1Y1kmVC8qkSg4m2uiqmRPAl18N5hIQNZdCGPL+nStVW9jM/pvbOgr4/UB6YtxfEh91QI61j4tiRAYBCxPn6JwgCTNdyLwgm4O/2Ck2m+GEhtqngrdIqV8sB734tlacOiEHlTGgpIj2p0Gtx8lVqu9PjoFgUsSTgqLai/d60A1xe3FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:05:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:58 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v8 phy-next 11/31] scsi: ufs: qcom: call phy_init() before phy_power_on()
Date: Tue,  5 May 2026 13:05:03 +0300
Message-Id: <20260505100523.1922388-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cc87e0-9e67-43cf-f975-08deaa8de793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	73yzMLF9LD0w590Xu8FOvjQgYAxxuQt9n7c5dxgYkmvMtpdcHEwTBcmSPk878pgHH1VT2bjVbIXex3MKdwkpQRXl2DWufK8fCH5OJiKNRFmrCeC2xBs6IFtbDIW4IXyzmEY0346lQTmoVY1x9CDVTR4ff3GyacpH93+tu94cf/Atu3oAyeWnjiklCLBm9ItzJWqsKNrzVslPLbqAJW8ZFqvYxyUiDXr+lKj6GEv8NHqb5ZYmclm3cTHuK5OmgzXBwIcQx9c4XYryGRu2LpXFi663A5raxLbM5RMyKVQ2fUohohHrUOe5qRhfaiZWb1SSaljTU66idtuWx3zNHvQGq3uAo3+5YzTbHjzpywwZJUnl7F3pct0w3yfB6C+FsPZqWN1468Nc/cD6VzRh5U1p3jQJQWNDMKixw9hMTQgmNdvK9crCQfGerqCqqn7l88jTA0P3VHJASTZwNjbrg4sEroifU0ArwpjxJfRKhRD/Xbq8i/U5CULBBF+A3Aep9++hs8fQNf9AA5CEJwxnRBaBbpDvcVew3TfjZIBy1yPLi3AyiegNhlagz6P7eEChBORvXPW6FdTnPzfb8jXc5Pw9W48OpOBnledWIVGRN+R7WEymq9zifJc5X0N9LSgPp6i+/+EXk8cN4sDTf0P05wPZfZOKYTUZq1zmqSzhQ3h0WE314wmcT3rejfH9ZzpXKjYgdJMitpepRDMzdPusK5KXkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1gPMaARTglJuKkYD2FywXTG4+TKSzvyTxMQWUG7d6Xc1kVh9GjB07f9twZ5t?=
 =?us-ascii?Q?Z2SnFaDS5PgdywVQQ5lWhOKv7San1xhNnY/Oe4GlD3l251tpnUbQjV/LizaF?=
 =?us-ascii?Q?V37iUiGvhFMyAtxAAOmFapZNqWf+nsG+Hnlq/m1V9C3s3PbkOJf00X7A6MdT?=
 =?us-ascii?Q?LSC3VvNv4xR8IY1vT2bQ3NHApHdGDUjD4dWwt14N9PjPIH0Eh0LDifML0jqL?=
 =?us-ascii?Q?L8IBde/8gkMcYP26r6M7YX++xjO9eTEjh5foJtpntTNp1819XG/CNUcHqr2i?=
 =?us-ascii?Q?0AoO6X0r4LDmEuRDTlZHQrhLx2dPF8zYD+5Vlj/xpe+gtoRW0WJI94Lbxjd4?=
 =?us-ascii?Q?5IuU21/uM/yGQd9k7DDt0R0Gi58rztYygwxM3dtYygyeOpS8F+h3BpfUrBEZ?=
 =?us-ascii?Q?NVxOkWKOED9C+utUYTWyOXr7aSDUN940t2mwPTFMd3E3wp96YcuQdu8QcIs2?=
 =?us-ascii?Q?D+9Cjk8hNISaWQ6amZvKEcXRuDbqAyLt19wvfFY2yPJKLx8VdGt1VD5UBDoD?=
 =?us-ascii?Q?y0f000j4xMYkrtWNF3C+H0H04VnAcace7+bXArOJLEWM3PuB2ERPX/wx9Rki?=
 =?us-ascii?Q?uj8P0aGdD3SksmkElqzlUC8vsJtXcPKdlu1/ryx5BXSlznPzxdEisH0c9rWu?=
 =?us-ascii?Q?V2Yuce0o+IaWyevy+yR15H1LUKc03nvYa5toEbArqggZgM/DI84uoQz+NCU8?=
 =?us-ascii?Q?tRUPV6fdQaDhRQb6eidL1v0DIYrdRLk9uemCkCwf6piCoQYHaoHtXZgj+94m?=
 =?us-ascii?Q?ebDwmaVEV+iJ8vM7KGGap4M5HH8fogTSoHX+1zthfqweeiaT1LJx0JRpv2th?=
 =?us-ascii?Q?TTcgCtx5mCXotND0116an1rpL45N++nJHwKt3qykgcOqSLlSZs9b1SB0o6Ap?=
 =?us-ascii?Q?IBDK7S9fyoeiXWHaANf1Hwec5yMKok2rYgw0v5BLvMwPn5pREoO3y5Gj+ayY?=
 =?us-ascii?Q?OisJ//iI/k7bkJXkSq+QsdyRHIfKtT5GacAN3W1r0b3L0pCXQgZl/xBQIL09?=
 =?us-ascii?Q?Yy8rs1aAIMd6jgnAuaEWfkvc5z8igS/IB+J4RfcUzKZa5KqPxnWSU5fh2Na9?=
 =?us-ascii?Q?ZnUd1OZWjBnPY0SbsuPXNgt5C5WqJNG6gmOkB55grZBliZmuzxDs602oTwSZ?=
 =?us-ascii?Q?2pMixDelSPNpGr/WjEzQHg9khzbww3EqYD8Ji+Q6OF7lON7JEnBg2i4oCCrc?=
 =?us-ascii?Q?ljv6UDFYi3miGbFMk5rYZw2Gg6ThlHpgCi5CFzGMU3B73YjguS/LZVgachD+?=
 =?us-ascii?Q?dC3NqJAX3qskl2/n6Yf9IAYxsMglzUpXCy97SLbe44Mm35cSnPOAA4qTUatc?=
 =?us-ascii?Q?JLeUw7pSh8C/+QgNp2bLKoiD31rSMXX5+Dvh2cSpBGXn9O84XxKGkD/hkd+k?=
 =?us-ascii?Q?1lH5uEcSN9MWDA+qSsi708Pl2LgkSnltplilJ7PtC16NOUpKd3xZXoRFw0TO?=
 =?us-ascii?Q?rr5mxeDSCCsM475VAuJW4mFf5vpWo/6Yg98fTi01hSg3I3CM4EKgQ3WT1rUx?=
 =?us-ascii?Q?CUUA27I62dR01uc5OnajTbQY98wAdmvXdejmO/6MvjYHBN1LjM5TIpYhsOWO?=
 =?us-ascii?Q?YOg3xGe/qEYGXZrKVv1IZvaEc1zF5xPFaa6UxyFLIY2coPt3S/zwUaE0TzSr?=
 =?us-ascii?Q?SjS7D2LmkuS7jd5Z7Mvekm/nacZONsdcgSq2OtUmxn/MHXO5eypWCIdPE0k9?=
 =?us-ascii?Q?8cPhn3n/OaYaQey/x6GF7Q8krKKV8wW2Xj5HDTlWRVURDQGh6DeEx9I5wvtR?=
 =?us-ascii?Q?zEbLNWTXHg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cc87e0-9e67-43cf-f975-08deaa8de793
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:58.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFRHmG9sOqG9/oHc2veaP7HwAxOaYMFxwrPf+r2OjH094OolpS294ZwOPjEYwSHtnhj63RkVpuRrzu9hmUqLRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 2ECCF4CB36D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7500-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,quicinc.com:email,qualcomm.com:email,hansenpartnership.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The Qualcomm UFS host controller interacts with the QMP PHY in a way
which violates the Generic PHY API expectation, documented in section
"Order of API calls" from Documentation/driver-api/phy/phy.rst, and then
tries to hide it.

Namely, calls must be made in the phy_init() -> phy_power_on() ->
phy_power_off() -> phy_exit() sequence.

What we actually have is:

ufshcd_init()
-> ufshcd_hba_init()
   -> ufshcd_setup_clocks(hba, true)
      -> ufshcd_vops_setup_clocks(hba, true, POST_CHANGE)
         -> ufs_qcom_setup_clocks(hba, true, POST_CHANGE)
            -> ufs_qcom_init() has not run, simply ignore
   -> ufshcd_variant_hba_init()
      -> ufs_qcom_init()
         -> ufs_qcom_setup_clocks(hba, true, POST_CHANGE)
            -> phy_power_on(phy)
-> ufshcd_hba_enable()
   -> ufshcd_vops_hce_enable_notify()
      -> ufs_qcom_hce_enable_notify()
         -> ufs_qcom_power_up_sequence()
            -> if (phy->power_count) phy_power_off(phy)
            -> phy_init(phy)

This "works" because the way that the "phy_power_on was called before
phy_init\n" warning condition is detected in phy-core.c is if the
power_count is positive at the phy_init() call time.

By having that "if (phy->power_count) phy_power_off(phy)" logic, the
ufs-qcom.c technically sidesteps the test, but actually violates the
Generic PHY API even more (calls phy_power_on() *and* phy_power_off()
before phy_init()).

The reason why I stumbled upon this was that I was trying to remove
dereferences of phy->power_count (a PHY internal field) from consumer
drivers.

phy_init(), implemented as qmp_ufs_phy_init(), calls qmp->ufs_reset =
devm_reset_control_get_exclusive(), so my understanding is that it needs
to be called:
- no earlier than ufs_qcom_init() -> devm_reset_controller_register()
  which makes qmp->ufs_reset available
- no later than ufs_qcom_power_up_sequence() -> phy_calibrate() ->
  qmp_ufs_phy_calibrate() where the qmp->ufs_reset is needed; although
  phy_init() should be the first PHY API call made.

The only mystery is why is the current phy_init() placement so late, in
ufs_qcom_power_up_sequence(), but I guess the answer is that the
placement is vestigial. After the incremental work of commit
c9b589791fc1 ("phy: qcom: Utilize UFS reset controller") from
Evan Green and commit cbfd6c124f27 ("phy: qcom-qmp-ufs: Refactor
phy_power_on and phy_calibrate callbacks") from Nitin Rawat, the entire
multi-stage PHY init procedure was moved to phy_power_on(), but nobody
bothered to move phy_init() anywhere else more natural.

So hopefully if the calculations are right, any placement within that
bounding box should be good, and I'm picking the new phy_init() location
to be in ufs_qcom_init().

Even with phy_init() out of the way, ufs_qcom_power_up_sequence() ->
phy_power_off() is still needed, for a separate reason which will be
dealt with separately.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>

v7->v8: patch is new
Commit was previously posted here but did not get any testing.
https://lore.kernel.org/linux-phy/20260327112858.r5lpqygtvsane2vf@skbuf/
---
 drivers/ufs/host/ufs-qcom.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index bc037db46624..9039b087bf21 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -513,13 +513,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 
 
 	/* phy initialization - calibrate the phy */
-	ret = phy_init(phy);
-	if (ret) {
-		dev_err(hba->dev, "%s: phy init failed, ret = %d\n",
-			__func__, ret);
-		return ret;
-	}
-
 	ret = phy_set_mode_ext(phy, mode, host->phy_gear);
 	if (ret)
 		goto out_disable_phy;
@@ -529,23 +522,18 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret) {
 		dev_err(hba->dev, "%s: phy power on failed, ret = %d\n",
 			__func__, ret);
-		goto out_disable_phy;
+		return ret;
 	}
 
 	ret = phy_calibrate(phy);
 	if (ret) {
 		dev_err(hba->dev, "Failed to calibrate PHY: %d\n", ret);
-		goto out_disable_phy;
+		return ret;
 	}
 
 	ufs_qcom_select_unipro_mode(host);
 
 	return 0;
-
-out_disable_phy:
-	phy_exit(phy);
-
-	return ret;
 }
 
 /*
@@ -1625,6 +1613,12 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	if (err)
 		goto out_variant_clear;
 
+	err = phy_init(host->generic_phy);
+	if (err) {
+		dev_err(hba->dev, "phy_init failed: %pe\n", ERR_PTR(err));
+		goto out_variant_clear;
+	}
+
 	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 
 	ufs_qcom_get_default_testbus_cfg(host);
-- 
2.34.1


