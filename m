Return-Path: <linux-can+bounces-7280-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBFVEjHTxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7280-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:57:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35136349820
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1897630C1A3C
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B13A3E78;
	Fri, 27 Mar 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cvnTTZlN"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37EA3A1684;
	Fri, 27 Mar 2026 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637352; cv=fail; b=a+EFIUKp/Kj8T9X2RfWwAHF+UVzdowLdkZ4K+3ahTQd0FxSl0KgJf4DExsAxfUv+UWU+yuYM2E0+hoQryiR+XRJSt93r/148KBmTNO6pIYeUMp/riqzZu8aq4jN7fbEUqZXve/wMcTFii4ibH2+sPm5S+oQB+Q77ayNGpVhdQMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637352; c=relaxed/simple;
	bh=Hdr4b4i1+vRyqAyOHqhLtxMN39SnItRegdp2aOT5D60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CwqovdXfe4tfD83izhbXegUTakdDayIOOEBE75Q3iGxmCzjDQeiBT+XxL4KHVKqCNelZbreqmrRjPEAbwYRAzXt7gOKtZIg3XJzEa19ZbPS+cTXGf/Bcuz6Jo+BBMlIb8F5N7XNp/6YM0sPNAtgXEZGDCcpJ7KoIamSFI9qA8Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cvnTTZlN; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQdcAPWNeFgqFrxo1MlWJ7jAFOmB9hpcUNy8UwESvnCg/1AhEhFR4278ZXYx3ElhXUt7Jq03+zbQIA6ZxL2x6/r6O75rPbbTU3gaGgjlrVdDsp25bE60TTTQYg2VEPafB03iblms/XtnOcYc3uk+cmsoO38HRhgEKnRIQL/hyJZb3KdgJdv8MRgH5GHqo8dexU1rP77EpzpQldy08pvnBqj+0J7oSOZC8nmVaH2wgc4HJH/qF5tsNsOsseUzJiABaZF+jzbXlRjjJtlmI4EJn++qrBsMZP62femqIm1OlTF5jK4x4PX7vyiLu6qcLXe5lGgInJXdHU4pJTiClk9ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OhC6NlQDZFKooW+a0IryzV5e3DGYwPAHOnJPNBjDZc=;
 b=K9i7zNXEEfyQjTiJ35oWnpN2eD9tRDg9nQRBXmjm7ly4Ql1RccTnGaLS9McRt37/l4dRkwGSSLkbsjZ73sM5jVBaPq+jVMyWQleIXHNYCGKvxDq8TWmWCphz0VXKliP5kslsYfY/bZxmz2gpxEJr6aPb5q+ri2zjBowStlFWENGli6aOtPanaZJfd271xym/iM1+qdVeo9ficI2Ny/RgNr+R1A5+pSSmk/vm54Sd686oygO27CfRgtadS5KTevpzIEAy603wG8XDPmJCMyJ1KGoc6i2yw+/WTJtPmth38lDTP1js+MtKimt+28MaHz0oVtWcUdzWXDQPaL21cy2NDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OhC6NlQDZFKooW+a0IryzV5e3DGYwPAHOnJPNBjDZc=;
 b=cvnTTZlNIRCTno345ohva7dqnAjCduDbgawGlHIl9GWSDXpPsyPc/DXCzOwoBI7oMbXYwubDA8um1ioMx06KWTB+9aSiX9KGGz3Tk9l2Lu2vr78xhQPiCDOPZXQT62GtbzMkjVM9yZBJEvTKPFisHWBsNUg0g9CpCrkB/oKC3pOtW01TaiN93Rx/Yd1Srl67icx5lqufKs9/fyJJU429nFKDzTCzwrfGFv1LsGj416Qz9xszP2KtAmLf2L4dRnWAQYRAttHwdgYbyUX2deh4Ag3ZBcCDupxdbo+S0za0wX5ZaVEGgm3QBzSLzVh7SaKg0EjX9CWYkYjc+i1OtIiZ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:05 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:05 +0000
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v6 phy-next 15/28] drm/msm/dp: remove debugging prints with internal struct phy state
Date: Fri, 27 Mar 2026 20:46:53 +0200
Message-ID: <20260327184706.1600329-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI6PEPF0000021F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ed) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2f6d7d-9f95-49e1-de9c-08de8c318540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1VknClmcd3WXZzrCa5UiHp6SMEgfaegzm78hTAy1izs24fLC9inYpkjWJkINruUVaOvsvzvursdmxy6XjlZZBamLYUwPjzzc3yJoZWlEJHt3Bo6OR8H7x07Xw0g5Qma5W0ebbZhK/GuL1BBo/korfOj4vvh4OLDrGC91azxzEAI2mUwxpa1iugXGvGTwSlqtQQIX+MUTF9LEIg+mWyqUJtjSEjkM3GIBhSd1YcPm6slH2YV3zG6XsfRwtZwjYbj6cAqMGheXDS6MhZynduAj9/1qtGkFP5U3GjogRmDsnPWCRtto2LSPndSo5EdVdgNHmmGGZBpAhYzuj7MeNUxwvzOceZkeTJ2Ls4A4jqOAwAwM8TSLWy9R2FWpl+JSHyaf1i0wz6t89ptL838WlyBqzmbox2u+H4i7zoT0P2ELlQjknrVxH8H0DzQzDGN05wwTb5Ig+0vcQHq7Gbwmraz+T7Lm+j0QsmSyzE/+t4UHdWxD1kkRrGp+mVXkDp2TECemWC4hENoFE1YvnmMq4szkB8lRy53i1/m9cWZVzWdec5VETZFWOvigUAgPeObMjdtkv2n6oXyDKIu3H84cjIN/9ZTMWensFNSinVpBnxCYhLXFiQaATKw/1MtkZoSw8Sn+lDRn4moB27KJd1QkFRNQffYB6yYkFoNs2KjOto0GgzdTdSkks3cuIG1ILaNDT3i+AzjZOBR5G2ZJyV+qzpMRrM1NtS2bC5tZLCXlYWn4VgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dUo2F+SQShByM6joMlAGLWLmrub/TcJIaB6rj+ABNW+U+5PcZatrbwBpQU3G?=
 =?us-ascii?Q?Y2OPwmrP+WRdvyOHHJNTf/jn3Dcq7xF6pi2x/Fc1dCS92qAObPBjeDgylziz?=
 =?us-ascii?Q?UN02JidXJlXriV3vmLgMzVFodJiTYS2C+4mtdtY58WlwNlW65eVXuKuohz4E?=
 =?us-ascii?Q?OWssQG61+eUo3VKNeDcYP93hCZ0aCAQl2+cJp0uEunyGwA+d3DockcTFFxvk?=
 =?us-ascii?Q?1bFz2RYFcSKgroy69U69IKHIwBG/JdMpF5oJrsQT5a4ONt9ut0qnDt1aebOF?=
 =?us-ascii?Q?uwwJuZkCmNekgs/Blq9Afcbksejsajbr/cluKzCA+9bWZ/MGg/kctA/WH/QV?=
 =?us-ascii?Q?62q/eBnmTdAsqbDt/u8lfsvH3PVvgFP0Hw5beNt359c3lN7Z2KsycDlBV7az?=
 =?us-ascii?Q?VWZ4Rp32/y/o1DJmI4xWySuj2mwNF4zD7XlK/3RSzfzpYuiPKcwMNkRieZA9?=
 =?us-ascii?Q?SqR7b5VBhJwVzyw6tJ4ut/UDYT83Lcvu6VihirU2udyr5uNu/f6WfYo3lFXs?=
 =?us-ascii?Q?bOrMkclge+tOR8r72z8zP697+lenPgHbNB2I8neZt/xnljtBe7e2wJHuAVSS?=
 =?us-ascii?Q?JE13rnOcgSSR1dPtqm+Ib0v8mU5KDc5wqWEy0vjTOzJ0gpP7s7Cg76RRlUg+?=
 =?us-ascii?Q?kO/KTqsTI7Tlqj7emqXzQBbbdwGQ9bdECADlRdXCJ13zDmzpMktpQmGLaq4b?=
 =?us-ascii?Q?epTsDzQfTqYfIcMRbauelglWKwL6z1MTN/8iwkeD0X0hsaey1Px5tmvrezOi?=
 =?us-ascii?Q?vQjM5IEqKEZ5EGwj3Wb/WnipJm+kD+/Es1yKdnu75JSUsB2tpn0DFOY3WWom?=
 =?us-ascii?Q?oLv/MuVy3p+E1lM/tdor0rvBdQpaUd1Dc31VDi10g6M0F0aoZ7NFwYo/RETJ?=
 =?us-ascii?Q?OrnBA9/S2vHHxceiWnYA57HpPCCbXnd+YlxlGxe7NKBs95ZQjm35HbS3SZaE?=
 =?us-ascii?Q?yYPUstIPR7s8zkO9WB0bfWAq4HeFqiEpBAKP4Gp6JIbEl2XTT4DJySXgIhac?=
 =?us-ascii?Q?oPq46jXL4MGLkXF2/evL0jq3FNd6gzPCo2O2mOxY7hR4ZJ2GrXn/G5brj6nE?=
 =?us-ascii?Q?Ic3OY0HbJdsDJxXUBaCx4AauJd4V1JwSVuZVBUh/3faaw6czeVvVPltB0ZlB?=
 =?us-ascii?Q?R7YBYx5+wOOLWgDS/PYkIPt7GgyRRJq4F6UxwU4cDwCYwrN0Iwh/SmZi3MFW?=
 =?us-ascii?Q?9msRT3ManfpTANk0vDWT0JERAkM2E6+PoEb/ETP4WVkgzkizhG+w3LrFzybp?=
 =?us-ascii?Q?FR0cmep88K7B8pHkR9uizmWE73OjulFSYnfzhv8X86KDU+DFpb8shB5wQp9b?=
 =?us-ascii?Q?D+afEaJINfKiUsm8FI3c3Cdp2U3b2mDv6MDyYlsUWQSzh/kt5nGfgrLE2tps?=
 =?us-ascii?Q?5uO/q9zzVBRrosWKsSFP9eVMUihKqOIAqdlbK9/50km9Ui1Q2Svhcj1dEqLI?=
 =?us-ascii?Q?OYZuf2fKkw7GkB1xCxUrs23Tqs1fzfuT0gTitimSYzv2zFlV0YYiore5AKmQ?=
 =?us-ascii?Q?QKA0ZlvyIW/MBdls3+HYebbD1Bcr/ruGJapO3K5P4GPb0u6wbW2TbarLZqes?=
 =?us-ascii?Q?5anKq0ceWeAAD7mpY6UxAyFU4TMm913t/qb2CFX9uFmQv3g5nMndFCFZETTN?=
 =?us-ascii?Q?Y/xpYyYuCmgBK6E8zlLT2mrwjpkc0EUkNqHIXsqBnye0ThCH9DAmoKKMAyyz?=
 =?us-ascii?Q?Elh7/H9pBPTdP0Gvm3mPJ88+ZnIRcJOZ+HiTwJfMDcH+1rN64wC0wrSQmy50?=
 =?us-ascii?Q?QyABQG6vEU+5vkmJTPwKgLKB+2asg7l1IDKelylgKBwzseFrHtPdwi/D1PVX?=
X-MS-Exchange-AntiSpam-MessageData-1: 3zci562RKHq92wJxKR8b2eUheP121YtWH5o=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2f6d7d-9f95-49e1-de9c-08de8c318540
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:05.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n1njZCKxfiu06TvSZUdaz0RdRDRabJy+xenUX9tNW0cxayYr1/euEbPuTOshtx6VnY/7/0NSbSF3YHnVBgOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7280-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,poorly.run:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 35136349820
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These do not provide much value, and will become hard to maintain once
the Generic PHY framework starts hiding the contents of struct phy from
consumers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v3->v6: none
v2->v3: collect tag
v1->v2: none
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ef298c7d3e5e..cba8a71a2561 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1928,9 +1928,6 @@ void msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_phy_reset(ctrl);
 	phy_init(phy);
-
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -1943,8 +1940,6 @@ void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_phy_reset(ctrl);
 	phy_exit(phy);
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
@@ -1996,8 +1991,6 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
 	phy_exit(phy);
 	phy_init(phy);
 
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 	return 0;
 }
 
@@ -2588,9 +2581,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
-
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2606,13 +2596,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	DRM_DEBUG_DP("Before, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
-
 	phy_power_off(phy);
-
-	DRM_DEBUG_DP("After, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2638,8 +2622,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
 	phy_power_off(phy);
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
-- 
2.43.0


