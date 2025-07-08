Return-Path: <linux-can+bounces-3953-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4062AFD62F
	for <lists+linux-can@lfdr.de>; Tue,  8 Jul 2025 20:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375AE1798D8
	for <lists+linux-can@lfdr.de>; Tue,  8 Jul 2025 18:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E361221C9E1;
	Tue,  8 Jul 2025 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="Xyl956T9";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="aM3vrtjf"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6614A60D;
	Tue,  8 Jul 2025 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998350; cv=fail; b=aY4xNCGwz7iSMXwnQH/onO/h6+MRRfCTPLKSxh+73SnGvub2GvcBg/nBDu9wKQ4oSJAxucARGvL+iG+RBadtnPStqSecbRGX2GyG6hyBG3ZmeOXQJyH2sSRv2NBGcxLVVMma/CWsFyhSCqh19YimnC/yGJTDBjOacgFQuPPMHG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998350; c=relaxed/simple;
	bh=GL9qHGCG4sThqVD6IprE+pvwDhNHuYCFrn+VTkznd7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RFhfDdnmKW9/eZJosbLtzZpoQQeqlxTyLHBfOO8GfTJvZy8XnWwaMCAo1asbgprx0WFDYNKYoPQ0TZGKm7NznkUEbsxSYazbmK7rnXJdoRHjp5lNpAA+q4rJnaKuHL0rkVTvRnInptpGT+Wj+f7E3w4tUjSvXv4F7j1DZz/32I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=Xyl956T9; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=aM3vrtjf; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568H3g52004832;
	Tue, 8 Jul 2025 13:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=YfbGVIGk3rAepAewQmqXj8PHwFA
	3Er+uj2vFPM3xx8g=; b=Xyl956T9dcTnkW8sL+hdLsbR8YrPVVunpXOrUQwOzz3
	nA0+Yak2FrPKgFjGRAAUDh2R+xwFvSiCxfCpyiU/bsHIsg9LUF+7CxRseBc8F76Y
	UjgCJMZLdwrEVChz6us8+Dl5ah0pli2QCiKchgyNZktP2FbrTjnqPUBLPEfdGx1P
	BetfSH27tMN85ENW2G5fHvPcW48NPYnC9WC63JXMjnWaLfvcZEmVpauJ3blBhjc8
	qOVHB+YmZJxvAsUCfBKGPhJb+W1KEOD9srE3W7zdYRwEzQJrTHV3iCgUyeziXfoZ
	2YyhGaM9UcEAOagqFZ7bplFHHIA/0bryRUc6nGZbDHA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 47s7d183yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 13:12:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBo4ODk7sDJcf1TZ0tUlO/niLQMK3Rtjb9XoTHtUnTWhUmN3Pn7Oobkghjr5Hdsf4likZBxE21Y9AYxkCWyhStNrSNBGbRAnbH0kS/ICDA3mbgF21a0MDprd1LzkIMzev1oueyepvfbOvS4wNGdDwC54/GJbT5M4EnNbF9r28Btjp8Od3GJy+duOYyQOjqeUiULxiP4C7bONCm84mGf+2J01s08KG3L4jVZHRrK28p8EG9SsNFHz0S8Ks9XOG9HDk1K4Ee5hWlzcu4aM8eUA4UHVERfYHTKZgtApxNf3aTDy/5iAMN8KVM7dGlCKEfy5JIuaixE5JQhvi0uXTtF4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfbGVIGk3rAepAewQmqXj8PHwFA3Er+uj2vFPM3xx8g=;
 b=K1X03No3cOGyo0q0k+HsddkjnBKLHXoc7EkzHNOZRGdFGr+XvxAV+oWjVk7AVlRNuWxXgQAYzXuGu5PaSbS9WNucjOKfPQ4PJaOQusVI8wfhDhlaNaaIAOQw/Xr2T9mtKnLbHNb5zQKiRwWQsVk46YoLyXEAgXDVNabrxU5h/eRU5ufeR+7FrdBxTZu3W/FNsrKJnyN77+UN18KNjAHiSRtOACHGNYJmE7xaNuJf1NfgSKKULQquSc5x3NVb/0KZ7dGmB01n/aiuIkkyyXY5R8RhlWQ5vtTlSN8o/r1kUVdrt8J0jbEKTNL6WeF8nE6AoCu01HCvjr80MtCWVOkuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfbGVIGk3rAepAewQmqXj8PHwFA3Er+uj2vFPM3xx8g=;
 b=aM3vrtjfHmQLUE4LBs6liSiuhQUriBuDkDahvbrBM8bTbsM6HBI+sb62c9UH9N7Zhjvfg45RwbjhhVVE0kYmB6HA+xYWTe02EnsU2ptSYXYDNYwaGvRoLCwy015ciRiimuD3TR0psEfZskfY3fyyWdw3OUsbYxP/h/DPz6w0ox4HE6LRtxM8JqJycBopN6isg9kN6dRjnxNV6VVpu+FeTXV++C9O+X6/SJCRYYBSd1LuIthiq0K8mzkroSqYvCzR4x+pQFAfhN8ZrjUY/JrnaICYkmyWv1wKuSZ8X7QwZ7zCvkgwIlSKInt8ZDBUItX++O9cEkGnQGaWWQ6vziaLbg==
Received: from MW3PR06CA0006.namprd06.prod.outlook.com (2603:10b6:303:2a::11)
 by DM6PR04MB6987.namprd04.prod.outlook.com (2603:10b6:5:240::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 18:12:13 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::e8) by MW3PR06CA0006.outlook.office365.com
 (2603:10b6:303:2a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 18:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 18:12:13 +0000
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 13:12:00 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 kc3wpa-exmb3.ad.garmin.com (10.65.32.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 8 Jul 2025 13:12:01 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Jul 2025 13:12:00 -0500
Received: from OLA-JW4GN34.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Jul 2025 13:12:00 -0500
From: Brett Werling <brett.werling@garmin.com>
To: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>,
        <brett.werling@garmin.com>, <bwerl.dev@gmail.com>
Subject: [PATCH] can: tcan4x5x: fix reset gpio usage during probe
Date: Tue, 8 Jul 2025 13:11:53 -0500
Message-ID: <20250708181154.2987123-1-brett.werling@garmin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM6PR04MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f44ddc-1bfa-4df6-77e9-08ddbe4af6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qimjZKXR3z6kK0fHcJ442k0hjMXKTV8BJxGPamYMX8/RsXbBE1gKBgINRG/N?=
 =?us-ascii?Q?5mfXNXMSXWK9Y3pDbWpvSMuBSlSOtjsAFZuIROQ/u5qxcHqqsdpT8+ewEmYX?=
 =?us-ascii?Q?OR9DvFM/IUyZDwbc0lORw3BzE+vsB1c9n8WfPQg4n9FFWeQMJCNY5UqczWi1?=
 =?us-ascii?Q?AMgaMjUTEM+FN7dlgcYfXcZRABGH9IoVpkKRHIsO7puila4jMOFLVQX1oE7H?=
 =?us-ascii?Q?NIkZcumB4xG3fguzR9eA6plh9arnFPGFVPgUUHK8Uya/TO9a5qKfVllCe1zU?=
 =?us-ascii?Q?egRYjR4VNvEVURAq7nRTUMA7rSwg5Xk4aMZ42TrjCWuDi3ZT2Tbg6RmepmaT?=
 =?us-ascii?Q?J0EcvhnhJiDzpAnun54ZNHuQBayTNK93wZOVUxDJ3fHqeCUs6W4aaZ46WgyF?=
 =?us-ascii?Q?ecNs6y2hMjo+y0uAWx+gNLRUaB+lpoDQDDUD9FGai4l/Xd5xq3/vGCgRjteD?=
 =?us-ascii?Q?1MZZWV3oDY2mngbdET6MikJf0lWrYOWwT4e47RKL6Nrr3zYqRQvbnK3VwvZu?=
 =?us-ascii?Q?gWk7jRJfcnQD/t4uQC28GAIaW1gDWVCbyE3i3y3vFJKozcqXTfwvWEjhAFAu?=
 =?us-ascii?Q?S8/8RqD3UB6Kyb5z9mnMaSX5CwDOpWHTkA/pafB6kDGUTU9jjwDi/WYnWX5H?=
 =?us-ascii?Q?q5kbng+hdPCOnR/KpXvA2p9tr1wOoy8ueiQy14iI5saiAQt4hW1bv767vJL5?=
 =?us-ascii?Q?LQkhN5SvZ/q2gWwv8/0kuSDUVI9Rvxd96tUWc9FoMBphO4INllPvwNr0HWtx?=
 =?us-ascii?Q?p0F+cRKpPLKmdn6Jc/XFVr+rjZ7MUjtHQmMdW5hmlTSVph8DiKbKJ/ehQr+H?=
 =?us-ascii?Q?SnGdEo+yh4i+hfb205OzYhNdncfFvn2DegPIv02vvegCPf14htY+1iqyfg2J?=
 =?us-ascii?Q?YZzXSYMOr3CXxyOaoJnlbh09eAc+mnGOO6an642ZT42vEqqtO8Eiq9KMqinv?=
 =?us-ascii?Q?UxCRVV9mgja7yMNpwSaqcEdXwA+89jL/kU5YXhDg3nNsRQytE4euqaGYw5Lw?=
 =?us-ascii?Q?uJZ/tCgtTemgRzuwt+dUSlElw6Ww9Q9J+wG+UzWcaOfhAewpFt1242Hb8yC1?=
 =?us-ascii?Q?JypmQG07mPelwV00Kn83vOgl9v02Yw7qJ+l764r8U8dGY4GV5PWoxHZ0+AFJ?=
 =?us-ascii?Q?OHr2YETKK5GbAjJcApV87AkJFykqI42M94SXDbMhJ6OdzH9LgJ2I+rEvPlQU?=
 =?us-ascii?Q?LcZ+U5HAHPK34f1ifW0JJv87Nqok9KL2WD+5wyJmLIO8ZR77/SEcUyBmeJld?=
 =?us-ascii?Q?YTHHXnNxV+bZE/cFHxdltZ25l7AmDJ1T8FaFaK/m5H4O6TZ7hNBHrhflWA9L?=
 =?us-ascii?Q?zjQs5Xx4vKYc6WMZnNZl1FgEBjgIlcN7Dcz3sMeSeJ5CIYe7KHQB5vS3JUd3?=
 =?us-ascii?Q?StH9Ql9MNgBp0ReUbG/tD97MlbgWyevXBd5TQxZckS8wECd0wPOa1zcrcBjr?=
 =?us-ascii?Q?+44eXQkXBFdalJrwtjY5XevH4nfZ3P5f9wBy2eJmuN6QzWDGbuAeV1/48cBz?=
 =?us-ascii?Q?sEwLYzIno3vlNSI1VwuGbBGValb5RpfmP5w+?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 18:12:13.1436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f44ddc-1bfa-4df6-77e9-08ddbe4af6c1
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6987
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MiBTYWx0ZWRfX/GsgGSRuwR2X 8qfKKIUleOsjCUBvhOMtvkhc3O4e0YNRKQpI019CiWtVBpfUwUW/kTf6zXB2Jg6gdbaAhGGkqxg Gwxg65X4DIEfQiCO1r7LTYJdxQyMp4Qb8fGvt20kVa3v2ZYVy4BMA9N2nS86OcS96kCz4RQZ3zz
 finA6aJnHxEWO/g0A+cAqbLJYk0FOIY8hTM7ra5YLJP1vHvsROMvi/Kb2Ht3a8Q6oIhzH2pvOOh 7s09vfp0/Ips/ggSomHeZTvoEWS89ouLKIYLE/3yvoNXvO5CnfqjMBb2Coe540TXBITBrn47TDv megcY7K46GkAnMsDtS7TVjNfiLLj9KvaekrpQDGDNnZwfzBkwuSP+k4I1U4M+WfhxxrwssPrCb+
 GIFW+8SM4DKfVkTNWkw4o2Ay5TfXuTjlK0OSSVoQfzHEdR4nmGwnHU1HeP59K5p2cZ2xLvkG
X-Authority-Analysis: v=2.4 cv=eLATjGp1 c=1 sm=1 tr=0 ts=686d5f80 cx=c_pps a=skVBa3wrE/bKtdGVm523gw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=A8m-6ulFSmVBG3JXLxQA:9 cc=ntf
X-Proofpoint-ORIG-GUID: FNbqmpU5QxfAo0o9pgIVOqKGnfZl7XWK
X-Proofpoint-GUID: FNbqmpU5QxfAo0o9pgIVOqKGnfZl7XWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507080152

Fixes reset GPIO usage during probe by ensuring we retrieve the GPIO and
take the device out of reset (if it defaults to being in reset) before
we attempt to communicate with the device. This is achieved by moving
the call to tcan4x5x_get_gpios() before tcan4x5x_find_version() and
avoiding any device communication while getting the GPIOs. Once we
determine the version, we can then take the knowledge of which GPIOs we
obtained and use it to decide whether we need to disable the wake or
state pin functions within the device.

This change is necessary in a situation where the reset GPIO is pulled
high externally before the CPU takes control of it, meaning we need to
explicitly bring the device out of reset before we can start
communicating with it at all.

This also has the effect of fixing an issue where a reset of the device
would occur after having called tcan4x5x_disable_wake(), making the
original behavior not actually disable the wake. This patch should now
disable wake or state pin functions well after the reset occurs.

Signed-off-by: Brett Werling <brett.werling@garmin.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 56 +++++++++++++++------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8edaa339d590..c37733bf124e 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -343,21 +343,19 @@ static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
 		of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
 }
 
-static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
-			      const struct tcan4x5x_version_info *version_info)
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 	int ret;
 
-	if (version_info->has_wake_pin) {
-		tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
-							    GPIOD_OUT_HIGH);
-		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-			if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
+	tcan4x5x->device_wake_gpio = devm_gpiod_get_optional(cdev->dev,
+							     "device-wake",
+							     GPIOD_OUT_HIGH);
+	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
+		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
-			tcan4x5x_disable_wake(cdev);
-		}
+		tcan4x5x->device_wake_gpio = NULL;
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -369,19 +367,27 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 	if (ret)
 		return ret;
 
-	if (version_info->has_state_pin) {
-		tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
-								      "device-state",
-								      GPIOD_IN);
-		if (IS_ERR(tcan4x5x->device_state_gpio)) {
-			tcan4x5x->device_state_gpio = NULL;
-			tcan4x5x_disable_state(cdev);
-		}
-	}
+	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
+							      "device-state",
+							      GPIOD_IN);
+	if (IS_ERR(tcan4x5x->device_state_gpio))
+		tcan4x5x->device_state_gpio = NULL;
 
 	return 0;
 }
 
+static void tcan4x5x_check_gpios(struct m_can_classdev *cdev,
+				 const struct tcan4x5x_version_info *version_info)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+
+	if (version_info->has_wake_pin && !tcan4x5x->device_wake_gpio)
+		tcan4x5x_disable_wake(cdev);
+
+	if (version_info->has_state_pin && !tcan4x5x->device_state_gpio)
+		tcan4x5x_disable_state(cdev);
+}
+
 static const struct m_can_ops tcan4x5x_ops = {
 	.init = tcan4x5x_init,
 	.deinit = tcan4x5x_deinit,
@@ -468,17 +474,19 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
+	ret = tcan4x5x_get_gpios(mcan_class);
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		goto out_power;
+	}
+
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
 		ret = PTR_ERR(version_info);
 		goto out_power;
 	}
 
-	ret = tcan4x5x_get_gpios(mcan_class, version_info);
-	if (ret) {
-		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
-		goto out_power;
-	}
+	tcan4x5x_check_gpios(mcan_class, version_info);
 
 	tcan4x5x_get_dt_data(mcan_class);
 
-- 
2.49.0


