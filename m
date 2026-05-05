Return-Path: <linux-can+bounces-7503-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKDwMJDF+WmmDwMAu9opvQ
	(envelope-from <linux-can+bounces-7503-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:25:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 339BA4CB265
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6ED830DF597
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1DD42188D;
	Tue,  5 May 2026 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cNQxRuTN"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68659402BB0;
	Tue,  5 May 2026 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975580; cv=fail; b=LBcYvyYoaBPHs9aR6INUS4bVSRj5ohjaZ+7K7MLRjx7zQArvJWOzOsFf8/6YisoC1a0K73bcjT+DVQKxIsFdmistyoGAa89Fdx+3kPFpsUI9gD/9jdSKkf1MRbq1judB6TysizarGRHvMUx9a7/GTEKchL7Ic7vJGfCqCLJPKpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975580; c=relaxed/simple;
	bh=CfXKLF9lqq7BPaGPcDHYGnIaOnUu3XX+cPlKN4w1UDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqUw4VbopznGgQkKkc0u59mrlZIWgyzC3IkpYu1TNIQiUDO3jXvI+KzJInIXTdfy/O31o/LXF9qEPlf07MnDrXHfLTVQ1OY56JWkBjVCT+hoQothiXk3YoZ3NSOq2rBb3vq+jBrIl0seVU95IA/l8OsGoNtoc09AoPszY0ySzq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cNQxRuTN; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G98hC7npOLIMH62MxkJDUAMJRszlDgMXd7xLvb3e1p1ObammOhDIlP5IO0dsrgsR2mgRM+vGL3ZKuRsZct+bXCUeey3tcF1afDIxcWDSBF02MXPlFgbSgjNAtWelPWLIzClTpCkmYwRoKdPNUtqUqBqlEiPNPXIIW9A9JNkWUj/RhwBZ4Xqz/k4BNcqSIQFl3vBE3qaUU1gKuoSNeYg4Kt9Dcy1g4Oiokq9M3zXtjzO6E3Dvhbunq2WcYgtnKWNxJl6YZ4N2bfiOVMeAQ9IN15Jq6FV9LvKQYJWTPVFr0pRJK4tve4sodJm/T0cu3XzhngXvAboUIO43va15NcF0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfmEKuSDebMAxunONx1yWbnk6UZDGWJuV+B1JzN3k24=;
 b=eGpmAe7tNXUNj+VmivAv2BWz/oYqER3iVI9HG1oMZPrx0tGDDR/GCbSTcHAWw+6yj7eabe/IfkOQmGc8s3rjy6Redn9gXM0WD53ksx9bC777SAqVZD5NjwLdwsUpcP4hsyQ4hY9tSylT6f3GAAaa+MPRn3IRgZ9h1PYHinAlTqVPdUi/oMqsHLypxDPmXJS/IMd0/KcEQONHquV9YPvAF9LU3OEjKiyALf6e8gRPS3ikrwKOp4TQJdKVrDdRxoq+hE6ufGJB+4WgjohxPYlM2BsGHsMg3+jXbJSPhyy9yzwuFricqG4T99pfe60hKGDNXJffzjKLEOHa/ki99kG8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfmEKuSDebMAxunONx1yWbnk6UZDGWJuV+B1JzN3k24=;
 b=cNQxRuTNSB1LEy6NBckZ1ok4y+QQHgkQbu9mh1IPhHoiGpW46UY2hrJys7s37ZgYbvas00Mg4K/CTvuBHwfVcq3tlo6wNFAuahYU5f8+rI5SmTeZ1sqIK5k24+G1A/1NOz6q1GZgJnLMaZKKs3d39LgvFTXEQ7yBEPZHSelmZYfdC1shoyvu6xQPjl2aiauJoDOl3DN2vz3sT5LZLBLdbMzIlrlxfy39YBYBAP8QEZhBw+5/N2rvmdI0SrG2aHfjiBhtCUKJaD5THkmHdSfmjc5kipZmZxCL9c0U3LkuMsYPrzWF/bGhbfLGYK0Hwyjof4raKDaEC0LN1nSjvZqVsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:03 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:03 +0000
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
	Can Guo <quic_cang@quicinc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v8 phy-next 13/31] scsi: ufs: qcom: keep separate track of PHY power state
Date: Tue,  5 May 2026 13:05:05 +0300
Message-Id: <20260505100523.1922388-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: ed82a3ee-85bc-486b-5dd2-08deaa8dea31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2ZHidZ2Z9XG1cUXbqmlQK9ajqsxCHl1TDtw5FP0bz1JO9Zif5/lv8mMRG15eqeTY49ycBf8/gOu3aps4JDXGPvvDw2Ji1J6Mr7xrVPatlT2O2Sl4BFGxG49TYFoA43igGaw7Q/oSXTudwWeyP3oTUR8rHdr9UsyGWwvZMRdO6DcwtP1JohNpOd5Eyxtt3kFEXzjbHC2KM5F9BorqJOb7lzVB0OCB5XZoY5oI+kE7EWigMu4ygsHSLIJ6P3ug476hURVhkeBp2C6TFsE05Q3AnLXVNoQEEoTaxihhFmWxTC0LwgAA3nUIMs42I8V0AEGh/ACOqGj9dCaSphO2kDo5meNhFG1IWRjaPbXVuI7k2rK3IN6Bv5waHZfAKYIt4VAazoY9pgMGF6cclacadREjpHCUqCAlMFEZ6LQIrZWp/s+BKaG9zoElPbgnckbvn/H0KJ6lO5r/QFf+DwGXZL/SbfoYbmJlhs4Ms7KMM9byRH8c2Bak1KoVq2CBfgA+kAK5MBlsy1ioHZOqcN9veew2OVn4wdHlAjok1q5nIv8+Ph9xf+QBeEcu8mYSdTBekhsCNbvqENYhOR4uX+I49Spl5Ui5f2hYZhHOXQF4n0WzyarxvtWbuKbP/4fXrY0nPAIL9Zz1SynwZ0feLItB02JM0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RTADKoQWT0uoDwOTgZUdxgAVzPb3pml9Qb67ygWFJWHTxcf1hVkLAlgnNM4w?=
 =?us-ascii?Q?pZ9a2yAjO83adLRx13mhC/togpTw8FNWfJbbhevPkTOsvgKEJ9FLeWn2fB8H?=
 =?us-ascii?Q?AQL9z5QQtz5kNucwHzBxfirGSsZYnnW631OXNY19Yvcm/1/vxyzm5UxdfqQS?=
 =?us-ascii?Q?/OPjy2C0AMHDyOnwm5lk4DJyNR59acUY3FmuhXe30HOIhGeGyLtwCZdzby+p?=
 =?us-ascii?Q?yRguK0+vnVmMPHJuCOXEiifxDs8N/4kYtOOsSm611VVQXqyyAypdGB9X1u35?=
 =?us-ascii?Q?wSCYqaao9WFDnzhQJzBvZ0ZkxwJSeuu/6MCnyg7+bSdjslmWs7Re/+zANWOe?=
 =?us-ascii?Q?paF+LCoskwR92LLY5urEyfnS0zrZ0PttNCYVOrSGhmSC5nR5qXgSSCnCZGwb?=
 =?us-ascii?Q?9nejn1AlEzCsTMRmJhHgitgT/d8CF8DJhoazc2JNoWvkfaLYbSyYed7G8QIF?=
 =?us-ascii?Q?JHZO3E2nAaJHS1M3jl2JPWwhHERCcZh/TgPq7ehsOTKCq55ztCw3nBhqVRqb?=
 =?us-ascii?Q?5AaYS3cG3NX8R8R5sFcbxTQLISndhd9RV8hg8WPPSSQhh7S/wG1JITBF2NWO?=
 =?us-ascii?Q?GtcWkGxn2n7kkokZYirSoc5Ztbt0etryoLlDNvNwfRjBR68zQ0XXIQNnqRHd?=
 =?us-ascii?Q?9jhDIbm6PNriVQV8aR4g3cu+ph61Sixmvk7vAHy+U/uuINgqd8yju+OWAknd?=
 =?us-ascii?Q?Q3BspH0lH3TvxjT7ufg/nlRu/NYhZ4bRFW/CV/Vw45yOaWn/SHT6e1XT8HHc?=
 =?us-ascii?Q?kxwmNytRYKqsGmySFgtuylo9Fq/csl7/5fbllbhPlWnRDZ2zNXHpWl5K2SZ9?=
 =?us-ascii?Q?sFbERv9bsiL9ayJFiw3bQCrWXDU2F250Nl5nfmiapQ8ai87t9Cwf7aN43cNf?=
 =?us-ascii?Q?aWGw6TtVAmng+uNjSXgcPW7soznEAQQCu4HqLN2E70TzOxj7Qx5FqMaLlILB?=
 =?us-ascii?Q?q0EpSBH1ve8gsZ4pZWX5wxE6t1RWlC+HBR6N2dTrFFLlOpS2T6kTRnvFfrxR?=
 =?us-ascii?Q?LemWJ/2Qy+Uh0F/sFKDw+135dL2lqMqSlXVf3R5zQD93Idi+t/xBM7j+G0KT?=
 =?us-ascii?Q?1LnYBfnUdsr4RDTmfTLlj3WcQGSHilarH47i6d/vTJZNYRYIHwGiFAvMvvvr?=
 =?us-ascii?Q?kfTY4GLsWU4+MD+o35REcGKwPh6NhbHe2+FFQURJm/5vLhh4maxj4zW82YWf?=
 =?us-ascii?Q?pdIjkWy+xM7J7QamxISCgo7o0vupeG6WF70axtWE2a0iHFb8Y6JHMyVY0apY?=
 =?us-ascii?Q?Iy+Q6c3Veo7qDwIbafjfRO51CM0VwED5qkPTPvnuB6/TdI0Mp3LPjY/0HMUc?=
 =?us-ascii?Q?iSgA5NGuQUNubQLqAZQC5lx/I9ssHeVkd6ik0yuPfWyFBBzhqmZi89fbC64x?=
 =?us-ascii?Q?1fAsxhfxPKW4OLxis6MZu4djr4qsSPmqvt06Oa745gtp2Cf0MOZcYSoxuNfb?=
 =?us-ascii?Q?8Ct1CNrWXQzq5Kg9fuCykaRAywRDRSJcC/YWahFIRxZ6XYjFgka35al68tCX?=
 =?us-ascii?Q?4OZ2bJ1+NAX2gLuQygttT9PvPbhMj1V4F3aOh13qUYE5OEqt1vH3Jk54zEct?=
 =?us-ascii?Q?icxEqCXmDzJVGpBFQQfF5FY+vk2/vbcOnnpG5M3EFtrDNiSUTGH3k3yLU+Gy?=
 =?us-ascii?Q?swP4NtZeTTEHY6ou65ASuvYURP+flZuhRwLvD8khJRn28zmx9ACboKHz4uUj?=
 =?us-ascii?Q?T1DObpcWUwQJSndzcUostRsLhWCrDLE4+Rb8N3weFV4bOVSapg1iDfi3AClE?=
 =?us-ascii?Q?d8hNkhYzsQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed82a3ee-85bc-486b-5dd2-08deaa8dea31
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:03.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74OiZfYv6Q5G0wNXi3L0k9sfGcWt2YDI3PCFJcXjzIj+HvoRn265eWOU1QWM8moWjPOlIxFo+Ja3xrisvCk1+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 339BA4CB265
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7503-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid,sashiko.dev:url,hansenpartnership.com:email,quicinc.com:email,qualcomm.com:email]

The Generic PHY API needs the following call order:
phy_init() -> phy_power_on() -> phy_power_off() -> phy_exit()
with a balanced number of phy_init() <-> phy_exit() and
phy_power_on() <-> phy_power_off() calls.

The UFS framework is not exactly great in helping out with obeying these
requirements. For example, the Qualcomm UFS HCD driver insists pairing
the PHY power to the clock setup operations. But during driver removal,
we have:

ufshcd_hba_exit()
-> ufshcd_variant_hba_exit()
   -> ufs_qcom_exit()
-> ufshcd_setup_clocks(hba, false)

which means that we will underflow the PHY power_count.

Adding a "bool power_count" to the driver and checking it before each
call helps avoid this issue.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Can Guo <quic_cang@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>

v7->v8: patch is new to fix an issue reported by Sashiko
https://sashiko.dev/#/patchset/20260430110652.558622-1-vladimir.oltean@nxp.com
---
 drivers/ufs/host/ufs-qcom.c | 53 ++++++++++++++++++++++++++++---------
 drivers/ufs/host/ufs-qcom.h |  1 +
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index e28edcfd13a1..c547d8643480 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -485,6 +485,42 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
 	return UFS_HS_G3;
 }
 
+static int ufs_qcom_phy_power_on(struct ufs_qcom_host *host)
+{
+	int ret;
+
+	if (host->phy_powered_on)
+		return 0;
+
+	ret = phy_power_on(host->generic_phy);
+	if (ret) {
+		dev_err(host->hba->dev, "Failed to power on PHY: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	host->phy_powered_on = true;
+
+	return 0;
+}
+
+static void ufs_qcom_phy_power_off(struct ufs_qcom_host *host)
+{
+	int ret;
+
+	if (!host->phy_powered_on)
+		return;
+
+	ret = phy_power_off(host->generic_phy);
+	if (ret) {
+		dev_warn(host->hba->dev, "Failed to power off PHY: %pe\n",
+			 ERR_PTR(ret));
+		return;
+	}
+
+	host->phy_powered_on = false;
+}
+
 static int ufs_qcom_phy_change_mode(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -1390,7 +1426,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				 enum ufs_notify_change_status status)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct phy *phy;
 	int err;
 
 	/*
@@ -1401,8 +1436,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 	if (!host)
 		return 0;
 
-	phy = host->generic_phy;
-
 	switch (status) {
 	case PRE_CHANGE:
 		if (on) {
@@ -1420,20 +1453,14 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				ufs_qcom_dev_ref_clk_ctrl(host, false);
 			}
 
-			err = phy_power_off(phy);
-			if (err) {
-				dev_err(hba->dev, "phy power off failed, ret=%d\n", err);
-				return err;
-			}
+			ufs_qcom_phy_power_off(host);
 		}
 		break;
 	case POST_CHANGE:
 		if (on) {
-			err = phy_power_on(phy);
-			if (err) {
-				dev_err(hba->dev, "phy power on failed, ret = %d\n", err);
+			err = ufs_qcom_phy_power_on(host);
+			if (err)
 				return err;
-			}
 
 			/* enable the device ref clock for HS mode*/
 			if (ufshcd_is_hs_mode(&hba->pwr_info))
@@ -1629,7 +1656,7 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
 	ufs_qcom_disable_lane_clks(host);
-	phy_power_off(host->generic_phy);
+	ufs_qcom_phy_power_off(host);
 	phy_exit(host->generic_phy);
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 5d083331a7f4..6eafba3c203b 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -322,6 +322,7 @@ struct ufs_qcom_host {
 	struct clk_bulk_data *clks;
 	u32 num_clks;
 	bool is_lane_clks_enabled;
+	bool phy_powered_on;
 
 	struct icc_path *icc_ddr;
 	struct icc_path *icc_cpu;
-- 
2.34.1


