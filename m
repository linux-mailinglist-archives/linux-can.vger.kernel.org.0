Return-Path: <linux-can+bounces-7268-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II1dDkXRxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7268-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:49:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B4A349408
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA2CA305CDC8
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F3937C111;
	Fri, 27 Mar 2026 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nfHXafdG"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC01F1537;
	Fri, 27 Mar 2026 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637327; cv=fail; b=Qfrm1p9zwqGVoS5Xze4P6NZwPCmL9kWBXnKo1RJ/p67eleMPaeomfU9O7kUtL1C0zaFVMdPhrB4gJ922YQkKtriU8NKbj1fsHld3qoaep9D/39SQTnttZtCx70NvRHiQSVFcKG04NRCWaXZd59nHir8i7UcN/AZ2g+YH+0kKSn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637327; c=relaxed/simple;
	bh=nef7IITTzCDj2D2+YXTFSZzQZs7/knUhe2rNny4WZsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0fZS24Rp5lVDbfelv8YKV9W8gGCcc8LxydoPws+OURzjW+EAgIMoQc2Q2PWkZDZHd8gCMSz3+f+WQ5Tgk79TRYbM5g7ncK90RHl01iulVZ7u5Jax0XPZj13EcjJC2Lk4zpRM6LQzkMd4L9QyHO1xjUuiYluop7/kadxFL80wG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nfHXafdG; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFHNReiHhFMOxBkFJt+tux7QMbo614CGeEoyeBJpk53x+XK21d7a4+IysXXCN8TcmeksKge/dEndVrNVKIwYh1meQc2rA2HK494x4VPCjjTBcQr+q2DLXm/jj1Yshlt89mlMJR/nyARSHMH2LIjEQ52R8zks8BDU20D+p4G/Ext/aDG+Lj/f6HOaiLKVEx7xm9bL6da14V6InveEDznql0ZzE9RMwAwu4SBDY9E3DPnOo9k88adOxkm+6rfK/ez8RlmBXi9cDObeKd7xiGITFQRsQMOGfVnlaazxwYnrXW1bmIPz+46S0OhHdl8GTz/FA2oAfzGdBYdb6wD00PY29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OA0u8lbuZB2avT05bLlemk/pB+c4Pi8L8sChfnhmHk=;
 b=kAwrn17kE0bDgl/7Lup0vVHFg2Owhdg8ycM9KWDvxbc3u/nee8iFXvsNXsg3dwg6XPGEgNbaVPsIWU8usqlj1N1k64bFR6a2VVN72tRG82cIyyxMaNE2XTVzJx4zhJNpWvg0uyX+LnQX9ETm+h/pNHryL8iSikDOTxp9wIesoiepr5KMJlL8+opyNdLTt5MPPixYudnpHfogj/ZFBhv2jL1XbxY/DZcMIC/NFW784FVpmoczpcnNIkXCe6BbV1763QkzJbTx1Q2m+J29m/clO1s+PohSb/MTM07QM32DfxN00wWbLvQ7FGokx/pSg4yeaURxU7d9SfL21+viFuR88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OA0u8lbuZB2avT05bLlemk/pB+c4Pi8L8sChfnhmHk=;
 b=nfHXafdGCsUey/6zI32ZV+k83niMzEsvmN/sW311cFZcInE9OY2dkB+En0ig2FfbZIzvu6DKK/7GLt4YkSlekmSsoOZNtqv/JZckMdWflD6Qz/fmqft/GmDYAqwi1OnSmcxbiNfh5Iu/X0A6A2Vw12giNvWzIM0eA/ewErowi0/8ni6pTQ8m7Kampo2YaX0X/0ZT5D6yPtxBGJ6H8N+ZeOuQAnWAUn5w1ya1yIKal1dwN5IFnVioRtIAaoOLmkvKd2JmJ3EUxgnBEjY2ZU10lWkbaCxH0hJoec4xbDlry7jZ27E9jL+ovmvbCHORpxRoKFCrx87Y+ABQhuKzbiK+tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:38 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:38 +0000
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
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v6 phy-next 03/28] usb: add missing headers transitively included by <linux/phy/phy.h>
Date: Fri, 27 Mar 2026 20:46:41 +0200
Message-ID: <20260327184706.1600329-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0217.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::38) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d03609-9170-4256-6c07-08de8c31757f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1FmqFMNxmsqyUCklu9Fk0o4G+isG/u6EXfk+nvVhOX9zzpxg7zIzh1deyRuu9WfTpeGNnnGHHhF4vOOTTCQMbCwUABez15OidB3OnBIU+wUju+Wce6Kn4ZaSBuRVYWtmJMesUAPSlwlAQQlgmD4MjEPnS7GiMF/PkvWSATb2ePNCUh1XYuIIGty5Ri/Bix/HEZX3fwUjfHu6yMjw0+uo3dHuSSDXJNmlW1MOC3btTdjfUhP61nq9CedC0rjn2rs7D5uSRfKP02QePC/rHUbomAIx3srk7ErzP7yKLih0T9BrC7r7erIXXHQN7QzXXpdMGjrHG/OUOq10SdukParLQybChFH2rwAuXScLBURfM7XMTEj0hvkRcsJ/PM/LXIC/9k7Q+fwh09h0Ojxkzlg93+05QQ8Ee4BRz09Fai2xyvTKk0PTKcoGO7vWB5PV0qos2/7L7dQRw+r418dipbNXVu9uTVvQuu2rutYr80mXY/Gc3tlmt9/w8m1wdR560PZe3KeaAeEjOx2Yoc2Lyj4j3dNizzcoh7+Kzsqle7ixSxT7GdwdiEtulStefZEurjdaxzhSBzluWROnmg0jVj1bxk1T26PT0Z9FZEMXRL0sOJaojccoAGfLcALKIlEgnrJahSMurYnWFmTgjEYBfHHMC/k8+zK8Wal17D70GNxMGIXi1E8T+dOjKcx8a3TEm3w7fXuKDD2UfPJAeMKdvCeo9oheN1z4xAufQ0xIyjBLyTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BORRSXo37oiEkcTj4oFtHRtrwDLKbXwFyVXDN6n+Ef6FRmHV1OthmZ4fhoyZ?=
 =?us-ascii?Q?M8pG7tRZO2+5ziWRSnxsZius8gYc48CoxX7aHIsUoJafo4x7xwtdJ9cqfETh?=
 =?us-ascii?Q?KjyPLHNeqotrm5Sfi3m0NlJ3Ew7BmxYuvdzIfmivKIXH8JHEidJgXmDCM4/S?=
 =?us-ascii?Q?eWu+rOnnurVUPr52G+Kzo9/emoCj28hBtUG0YKO8+hTJiZ+emHrctnxeQccy?=
 =?us-ascii?Q?c/c6MpWQvpaInXKkTSdHiOWGMrrc6+SHnc+rTDj5ok+/V7XHUhuK9pfvVn6h?=
 =?us-ascii?Q?kgl9UJsx2nC6fFvDXcJowpF/kKzcbS0JJ6llq3M366BhKdiAXlzrnFSFbFDP?=
 =?us-ascii?Q?7LMK+GWpqiwfYgQ2TRbBtU5Ia39NPlvwPoy2vEVQx2u4nLSIkrda3A2LUAWX?=
 =?us-ascii?Q?S77HP9LzjO8GRT2V0Zip3qs4SnW9FgBG8o2aDKoP2rosexTYFAEtkMTQK1Jb?=
 =?us-ascii?Q?9l+TgnOtntsIDiJYCIHHu47N3CKVs+wOVGZhnzlXPUAICUQxY5l2qUXh5uu4?=
 =?us-ascii?Q?ip1lnMG2LGDQE+DnJ9k44XTuJtLyJqZ8S1ZHFJ60e5Hcbiry+2ojXc0e4+9C?=
 =?us-ascii?Q?ALuhNuRyhUw0LluHYJzBlYtYq8tMah7pCpPrxmV2V9j5GEcLNCyzyYGLlFc/?=
 =?us-ascii?Q?AHf/hROmnEP64898bzNwUej2GG6Bs9K9gE00Bj+/M80v5D7gRJ+l6Z8yjYHQ?=
 =?us-ascii?Q?YZdbeo2GcnNlV9i39eGTC3DZqApq0WlN0btV0XfyJcbP0TDpipOuTGrTrKFn?=
 =?us-ascii?Q?0eRagrFrRNybN9AYAJW5AMNYaFHqEUWNvbTWoAzbaTlkSBXe33jCQAlB/FvZ?=
 =?us-ascii?Q?DACHi+6mqWoPZ2WYc9AsamF3TulmFMfx0x+ROcn7zfja9JNNZCJEuHyP+cJx?=
 =?us-ascii?Q?5CDdu3K30/I5ZloqUn35kdlget0Nltn667L3iVXrYNbq3ydVr2ft+tldILEj?=
 =?us-ascii?Q?os7BBOljFoNg6ODcGXiK+9LSolWMC/OYxJtEqtDJpTgK6nceZ70lxeCK9f2l?=
 =?us-ascii?Q?nYh2qhXSJ9XDK4VVEKsVpQepE2WKED7MQQZ7rX/Exqnm1XAlhHRWqpcPmkTS?=
 =?us-ascii?Q?87LQ8d0NWMDdZivaHi12f5wBJqXHgburHmiC7IYh8ZvpvdDc6ec7EqnmBMbI?=
 =?us-ascii?Q?AfmYzi12kqWmnAOKm/v4vH7qDmc0rbfAZ20imfZL6KZLgqG+6WZab9Ju04Bc?=
 =?us-ascii?Q?HOA7/oN88x+2XY2lHCiUgFr6N+ckJQXnmeDPjTTJTWsYpW06NUs+E5R0y7Tq?=
 =?us-ascii?Q?onfyhXHPgg5Vr438DA1wsdn/ggfDtFNZDOQ+nwfsfIPzeuk9pdRiMaQHifh2?=
 =?us-ascii?Q?z9fIY4RjB5r7FMSNzGQgC+Io1hG+OHlpPJpJyB4Rpjl4iwhuuus9n+1APNLv?=
 =?us-ascii?Q?X8eWN1fq4n10/NBlOX9AkVemhhA1y2675cAgC3jB5Z0QoQF18D/x5x6PS733?=
 =?us-ascii?Q?JPvnxG4zaIZbMGeFAFRjZfsqwc3L3uA244ebjNQeEzah50oe1Spw6PMtBr/A?=
 =?us-ascii?Q?t3kP7Xa5R5PDKomRpL/l2PGm1oIegHn9PEkL3/H++ciMycdCrp5jcctvu348?=
 =?us-ascii?Q?HVUKzSiu0FFiGGEPWcppHOqCe1CV2WShlAKd4Sjz7e8yv23cFFf2uH/85jxr?=
 =?us-ascii?Q?9Ige4Nr2s9MnulNS+DFMhHKn2362vIRkKoSE4d7qG/7YjFqaGOcMUSBRqg0A?=
 =?us-ascii?Q?5NOWvdWnEH5TwukX1QlCvlT0pCUn0f9xKw6yZtU6m7Gl9se+AGbJFN2C4Vg7?=
 =?us-ascii?Q?1SlA+0vOZmSXN/dPj1vbOhvKqAyy4U4Kth3PvLXbT/Ec7ibbB1IcLXNBdnM6?=
X-MS-Exchange-AntiSpam-MessageData-1: prb1qxpBMqUhW0dYxzCmUgdHtQke4XwBYic=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d03609-9170-4256-6c07-08de8c31757f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:38.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T46JuKouH00ay4t4dGSE78ENBbReHO8sxH8Kg8oQaDf3ydpkL6M/FhR5HNkIBxCRCol6PqGo9purd1EC8kMLeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
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
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,synopsys.com,linuxfoundation.org,nxp.com,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7268-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,synopsys.com:email,pengutronix.de:email]
X-Rspamd-Queue-Id: C7B4A349408
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The chipidea ci_hdrc_imx driver uses regulator consumer API like
regulator_enable() but does not include <linux/regulator/consumer.h>.

The core USB HCD driver calls invalidate_kernel_vmap_range() and
flush_kernel_vmap_range(), but does not include <linux/highmem.h>.

The DWC3 gadget driver calls:
- device_property_present()
- device_property_count_u8()
- device_property_read_u8_array()
but does not include <linux/property.h>

The dwc3-generic-plat driver uses of_device_get_match_data() but does
not include <linux/of.h>.

In all these cases, the necessary includes were still provided somehow,
directly or indirectly, through <linux/phy/phy.h>. The latter header
wants to drop those includes, so fill in the required headers to avoid
any breakage.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com> # dwc3
---
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

v2->v6: none
v1->v2: collect tag
---
 drivers/usb/chipidea/ci_hdrc_imx.c   | 1 +
 drivers/usb/core/hcd.c               | 1 +
 drivers/usb/dwc3/dwc3-generic-plat.c | 1 +
 drivers/usb/dwc3/gadget.c            | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 56d2ba824a0b..0a21d7cc5f5a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_qos.h>
+#include <linux/regulator/consumer.h>
 
 #include "ci.h"
 #include "ci_hdrc_imx.h"
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index dee842ea6931..7a3261f72463 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index e846844e0023..2ee1bb9d7199 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0a688904ce8c..d06171af6870 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
-- 
2.43.0


