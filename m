Return-Path: <linux-can+bounces-7264-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHL0BKNqxmmkJwUAu9opvQ
	(envelope-from <linux-can+bounces-7264-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 12:31:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0623437DA
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 12:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7126D302F419
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5E3E3168;
	Fri, 27 Mar 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJ6eg8dW"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148993859C8;
	Fri, 27 Mar 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610953; cv=fail; b=JKAacydEBSD/d4bAonoy+oUkjpYPN7/CBNFoONS9GLM0TnEav+HcUI90uL19aE3nc/bgjm2wTqhcnQ//XhsD3sYTzRBiepSRXwllDulsIaL84WVZa6EjwfQiMP0s7bz96Vr0mHkOClE5908fCIHYl7LNYxlmGtcNX0XFGALBVQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610953; c=relaxed/simple;
	bh=UsWlxKNIqdyGIq7UkdYIWkqRn526VBWMZP4wzLJ0ZxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XAUs1ZmHupoGdYBfH9xD6aeCHW25E7niKxnDud9pcJehp26DX8ONNSWfvfkCYog8t5Hg3IXW4SKK4RlNWgM8imZo/OvEtUjTLzQz34T2lUSRIjW9CDwKR8tngaDgUjcy/sJNwtqx7GrwHugu9Li8sn0G2/R1yzPk58hfSD/9HvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DJ6eg8dW; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bi+RNwJJNC5DaXrN/DiRuzn66oz6WTXTnoQ7E+lh9ZYoX2uPo1X30A00tqc6HETW0GvezzbYAhiyRkpRhCAmW6pQwMSa8p9M/wQXB2fAHRP+9VO5dG8UbtHCPxahrmrhcU9sByc6KilDZN6MjMmIbSp+dOoC6IdYIUiSYPsw9cR6invRE/7g3OGQFfss3n6GlBUTTYL7xvv1cO8TQWQjzR8fcttvXeFZiJhfQLGIoE81f54TYAYdyD8el7Q5xqzrWZjDVpmTwYAe6FI9R/p0GD9vHqhVBla3qt1x+4mWwGM236cKGYHs4mQINDh3c7BQagGJkRVyn3S+ZpMCFoKDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1zVIvmAcRlEyydV7FuFfw5IxvYqfXEXsDEljHz56Fg=;
 b=IzEDytsqXb4rL9VntYmZizDvdZlyl29W6A9PCfCNlZuV6aTR7FsBub8rbwfth4nLBrpEDNPriAuEVUKogk6aAcdrvxMqc3Msxa2iXyK6Ais1Lam1CJ+/eV17Y9ahD49QJE+FelmaXLvOg3tdpGAoACWKKkn84TSAfFhQP3+w0nPXakZMynHwylJdNSMeI69wdGoehl8lmBO9ogfh1RJgdNI9VhJK5eKk74/yc4xOdTXBG2yTqqP0E/FBed34c5jAtyNAGTYEZ/FnF+dysJlBEwgiOte8PzAyLqAw/fw8a4QOzNduvfSy+lQiOU5qgKyGCh26Ewmn/y/yEMrD0jPwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1zVIvmAcRlEyydV7FuFfw5IxvYqfXEXsDEljHz56Fg=;
 b=DJ6eg8dWqU2iXeCQxhnZvFrWRhnsbUkPDRb0cZbPMPxdTlaUT3HYakrDZe4CDT/8bf+fWgVoLgMGO42MkK8bLzSNvtSxhthCT5gf+nlzGrXpF+58lnRUTjacJpEAx75d8mIIoT0nOQuO6uLWdGFsjIjIyZgl49t3mByGwPNvbqEN/gRRmIEgLXMJXKI2PRSqsXNTyyWqTrpX1pknrf4dyZJPJJdxXHx11xHOaKFJ3bB8gFgb655ZX9112Y+IPuV8IZRTokzJK+snlwB44Fgdd7x6dAuGyX1zd1eSE1fLaU8cbySh+6xVYE9VB7/E9yXP7VZS+X1ZqoTvZz7EAj9sqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 11:29:04 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.030; Fri, 27 Mar 2026
 11:29:03 +0000
Date: Fri, 27 Mar 2026 13:28:58 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH v5 phy-next 10/27] scsi: ufs: qcom: keep parallel track
 of PHY power state
Message-ID: <20260327112858.r5lpqygtvsane2vf@skbuf>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-11-vladimir.oltean@nxp.com>
 <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
 <20260325114309.3k7xkfrffpxp5xq4@skbuf>
 <vu3cxpynr5mu2fzkrtmjcwijc5jz323wlnbc3r7lp2wxqmhydx@z5xhgf4myw2d>
 <20260325115731.genmq2yew2p4dvbs@skbuf>
 <20260326080444.gbesciaa5zwvcgoy@skbuf>
 <gq4sswslkjaoe5hhxe2mz6z57uiumotqknkryadvfsstj4srx4@qgenqekgrqv4>
Content-Type: multipart/mixed; boundary="5nqk7qqoimem4szp"
Content-Disposition: inline
In-Reply-To: <gq4sswslkjaoe5hhxe2mz6z57uiumotqknkryadvfsstj4srx4@qgenqekgrqv4>
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1dc106-c1aa-47b9-7d5a-08de8bf40c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|6049299003|376014|7416014|10070799003|19092799006|18002099003|56012099003|22082099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	wO7exTkz0bVlqUvNuNmHpJy7npncU/7L/KRFfR8SmzjFDeWcCnNIR802dKo71Gdzzx3cmNg3G3MwtxUS6e/0QZBfgVSax0b6CTZacQ8L96JM1FVcJpWQjBZDSN0dHPiKOW+XdscpBe4gXBpJoOVtryH640LzTRRD3OPYZdGk4gi5kfbcpD8NDVhxifvS/V5QlhZgNAeaMLt9HWGAVwScPDrwgcOMEBnkL9mSwJIqzEuMrlMlgJ04DEUCfYwn1SZUtO4XPuzyrAFcctSU2PYsI2uWR8VRKxDtKuqkjyqaqja2Ez3JiJS04EBl8SVmUt7b2vfTP911fzIzw7vpMMFWnObsZjrevxxVWS8SaY+IT0o7IhG4KAiECCQ7c1XxVSh2V3VkzEMPLHG05sf2O8oOhp6WUP/rRFTk6InswrswlSvVmX/7K2gupR+4kcdvffwYnZlf8LaxDNgUsThmzkVXCYx9y5qfew8hAMMq+P6DrEUBP3Ulw83+EKbtJFNrR9zaQYcH4qHoTEBOU2fq0F1ZSB+XaHOyJNyEyEdwtXtJkS0BQsHVZrwS48679qh0AKgeQnXJznS+1/8Loemw8qRlEDRJdlHehhxMvQ3JyEQRcJArVM3aRIlFcP01QZGD8CYu9ooqjybTFOiURmlZ035TJfU4r4mJRCMkgMuNIKVzTTUWAgwGHNP74ILL1fJoRaFmI6ymnSnPSo71ykacYYgrnBAfRviH89WRgmkmK1Cg0HM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(6049299003)(376014)(7416014)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yoRvvaCKMRsezlqrOkzCOMGXqO9duFmQXCFD1Na33vm1wSMr4NhOtpqMuhaS?=
 =?us-ascii?Q?pTHquA5L7BI9IbTcqi+sMkIJjROKVj6oEvfjPodcyRlHxKKRdmjr7ut1H3XX?=
 =?us-ascii?Q?hoUJwiXz5oDfeSBUz3YVskdSUxG3eU2eJOi4Wg4W+O/O5LOYNW1twt5ESjiP?=
 =?us-ascii?Q?YMzOYocu0T3Mqdcq6Ze59j/1JFQy6PUVVKud2ujPkMlx4X69WwRIuBBMCi0M?=
 =?us-ascii?Q?NYQMIko8zYyzHFNinjLPNMYY5g2rdWWwgX4WyFGhoKbyal5B43chHY0poz1V?=
 =?us-ascii?Q?Ea86Jq7KPlKP3bk98wua+AB50keXNKUBgq4NPpHFYl6yYFCryfuoz9fxxD+I?=
 =?us-ascii?Q?q3kcQAXo5Ub/B1rP8cgxXpA6N8iIBo9dOv4znwn1zLsZ82twK9qdBVuI/Xqn?=
 =?us-ascii?Q?h60J82pKIUeAO5ZjJrfEA4T3TOwTBYqSnDaKKTXn5xRFMGOzzJIV8W8mQ9H4?=
 =?us-ascii?Q?O39eMvcPQEdLY6v2cJn+zCxcWq+H3L+mJfEGjD2gOqHWxLLCzL1mzeqkyY8f?=
 =?us-ascii?Q?4+dSTAlwG8Sd5BTajNzLnEM1GI6xh/INtIn8ciMkK/DsSEUNjSUN2dH7Idjb?=
 =?us-ascii?Q?lXDg9gBpanSRMiyBhCZiaElDMpAniEV7Z25yv2VpHQnV0fJqtKfC2XBoj1/3?=
 =?us-ascii?Q?0fXfBbXCc3G7FkL8tyb0p2iclnRWzbO435qO7uunQlaM9IqmmrwcdtgXp2+X?=
 =?us-ascii?Q?ufvoMXHywiVoBwUWHNbzn2x58lz0W1SU8QpkBJlBQKBu2rezjxhHR/GX8dYB?=
 =?us-ascii?Q?wGWdvg0GDAffe2auxLFID8iyhlVGRbHilHjlFaaaMvH4k8APhj3pi5QE3ZCW?=
 =?us-ascii?Q?q9Zy5VFWOlI/3ekKOLARhTWh4krcKlh/SQrnPJ5wYMpzs96cD5tobo/+VXWD?=
 =?us-ascii?Q?qVmvUIRRR/a3cMYUgJLKzWlaTXKqVEHt3kGtT8jX+41GNXXS8iikD4Y9ixTr?=
 =?us-ascii?Q?xOdaXUBMMAbQ2hyGFj3AF5WJweIr3qIJOxraEEO1GXhfsWkKAe5wQZ649MHf?=
 =?us-ascii?Q?8t02pUAjj/NnzMeRsmGWDFhbzmP3Oydq/XneNWwyyzktCIpJyB7JKVZhPYxQ?=
 =?us-ascii?Q?Y1BRNEU3linGq1P9BmejJ/wxLKG0b8qcz/616BvJVin49ymcEkj+9lTWYigx?=
 =?us-ascii?Q?Cp81n2KJUtSzfYf98obcH0Rs3P6usH3lQ+wk1LE6oRVmIdDf5sm1iA5X8hII?=
 =?us-ascii?Q?pM/dWDpimDUNHoR8dheGyeF974JBL+nsaCb4kwBbCfuAOmYCxOo27OmTGyS0?=
 =?us-ascii?Q?NU9x08zjXQxL2OfM3mnQw3NWBdT6acfZ74zcvBIOjGbLNFxViEl5Zh7/SUPh?=
 =?us-ascii?Q?SYgJ4XcrS5bSs/wS9a16QkHmXyxk5tC7I+AulIcdS+yRb84oTj4qGB++DbC5?=
 =?us-ascii?Q?+srvK+xIGevHtsHVJ+2sx7FpRSuNb/9L/zQCLoPY2wQsgYbSZEisDXF1PSxj?=
 =?us-ascii?Q?gp0QHKqO59WoTH2Zw+rzxAhA5KkfPWeKHevJRIDGSdgqbEGNvkaofcWdLkvo?=
 =?us-ascii?Q?+YvC8SndkZAYXmQTNm1VqF+NzjMMhlkhb9o6AtvYUj0sBEQEXoa/EAh095n9?=
 =?us-ascii?Q?s93hRNK+v3TGbymOGQ9Xuoq4h9p7ljqB65cnwNtn/HMJhMgZV9ie6PYY1ai1?=
 =?us-ascii?Q?F5g3f+iQhbPUrixF7jzKdI2fc6jmvRNWr02s62+7uwy082zKk1hcRJ88Qnqw?=
 =?us-ascii?Q?QeEtAC4kg95zLbmFz4zydLIvEA76IJpyKXvsHSUYgAhBAy/v1wQ4XKQ6M1lq?=
 =?us-ascii?Q?GlrFDj9nrOz+m6dc64m40PlgFW0oHtLwO4c3UcFGAUK+xziAOem8N95JDR8s?=
X-MS-Exchange-AntiSpam-MessageData-1: pI7j9jq+ytydeS6doXzniOLt7qDpCoouen4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1dc106-c1aa-47b9-7d5a-08de8bf40c64
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 11:29:03.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yk4qGyQhUqcxqxg18o2Ny9wTgOBR7nJTm7QqFObWEByjDith/2+Nnt+0shNPDCfiiQtcSXByx8cZbqVFlH4J5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7264-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hansenpartnership.com:email,quicinc.com:email]
X-Rspamd-Queue-Id: 7E0623437DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--5nqk7qqoimem4szp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 27, 2026 at 12:22:46PM +0530, Manivannan Sadhasivam wrote:
> I tested the patch. But it fails ufs_qcom_power_up_sequence() if PHY was already
> powered on:
> 
> [   31.513321] qcom-qmp-ufs-phy 1d87000.phy: phy initialization timed-out
> [   31.513335] ufshcd-qcom 1d84000.ufshc: Failed to calibrate PHY: -110
> [   31.565273] ufshcd-qcom 1d84000.ufshc: Enabling the controller failed
> 
> Funny thing is, it didn't affect the functionality since the UFS core retries
> ufshcd_hba_enable() and in the error path of ufs_qcom_power_up_sequence(),
> phy_power_off() gets called and that causes the next try to succeed. So it is
> evident that, if PHY was already powered ON, it should be powered off before
> ufs_qcom_phy_power_on(). And due to the UFS driver design,
> ufs_qcom_power_up_sequence() can get called multiple times. So we cannot just
> remove phy_power_off().
> 
> Below diff on top of your patch fixes the issue:
> 
> ```
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index ed067247d72a..2c9fe03f349e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -567,6 +567,8 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>         if (ret)
>                 return ret;
>  
> +       ufs_qcom_phy_power_off(host);
> +
>         ret = ufs_qcom_phy_set_gear(host, mode);
>         if (ret) {
>                 dev_err(hba->dev, "%s: phy_set_mode_ext() failed, ret = %d\n",
> ```
> 
> - Mani

Understood. Thanks for testing.

I'm still not satisfied with this level of complexity. If I get you
right, ufs_qcom_phy_power_off() is still needed because phy_calibrate()
expects a "fresh after power on" state, otherwise it fails? That would
be the second reason, apart from the first one I already identified
(undo a phy_power_on() done prior to phy_init()).

If so, could you please test the 3 patches attached (no relationship
with anything else we've exchanged thus far)?

--5nqk7qqoimem4szp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-phy-qcom-qmp-ufs-support-dynamic-gear-changing.patch"

From 2d42c2d40e6ddfd0c73fc39601f93f7b81a42401 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 27 Mar 2026 12:41:00 +0200
Subject: [PATCH 1/3] phy: qcom-qmp-ufs: support dynamic gear changing

Currently, phy_set_mode_ext() on the QMP UFS PHY expects the PHY to be
powered down, and it makes no change to the hardware state, instead
phy_power_on() followed by phy_calibrate() must be run afterwards.

"Order of API calls" from Documentation/driver-api/phy/phy.rst has a
roundabout and not really clear way of saying that both calling
sequences should be supported. This was further discussed here,
documentation is pending an update:
https://lore.kernel.org/linux-phy/E1vo0mF-00000007kbg-1OeA@rmk-PC.armlinux.org.uk/

By absorbing the phy_power_off() -> ... -> phy_power_on() ->
phy_configure() surrounding sequence into phy_set_mode_ext(), consumer
drivers can be greatly simplified, and we also have a proper
self-standing phy_set_mode_ext() implementation which does not rely on
other calls to do its job.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index df138a5442eb..e75b059bf246 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -2004,15 +2004,24 @@ static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct qmp_ufs *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	bool powered_on = phy->power_count;
 
 	if (submode > cfg->max_supported_gear || submode == 0) {
 		dev_err(qmp->dev, "Invalid PHY submode %d\n", submode);
 		return -EINVAL;
 	}
 
+	if (powered_on)
+		qmp_ufs_power_off(phy);
+
 	qmp->mode = mode;
 	qmp->submode = submode;
 
+	if (powered_on) {
+		qmp_ufs_power_on(phy);
+		return qmp_ufs_phy_calibrate(phy);
+	}
+
 	return 0;
 }
 
-- 
2.34.1


--5nqk7qqoimem4szp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-scsi-ufs-qcom-call-phy_init-before-phy_power_on.patch"

From 8d156781d38597865da37a86417f553143d74eaa Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 27 Mar 2026 13:14:39 +0200
Subject: [PATCH 2/3] scsi: ufs: qcom: call phy_init() before phy_power_on()

The Qualcomm UFS host controller driver violates the Generic PHY API
expectation, documented in section "Order of API calls" from
Documentation/driver-api/phy/phy.rst, and then tries to hide it.

The expectation is that calls must be made in the phy_init() ->
phy_power_on() -> phy_power_off() -> phy_exit() sequence.

What we actually have is:

ufshcd_init()
-> ufshcd_hba_init()
   -> ufshcd_setup_clocks(hba, true)
      -> ufshcd_vops_setup_clocks(hba, true, POST_CHANGE)
         -> ufs_qcom_setup_clocks(hba, true, POST_CHANGE)
            -> phy_power_on(phy)
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
phy_init\n" condition is detected in phy-core.c is if the power_count is
positive at the phy_init() call time.

By having that "if (phy->power_count) phy_power_off(phy)" logic, the
ufs-qcom.c technically sidesteps the test, but actually violates the
Generic PHY API even more (calls phy_power_on() *and* phy_power_off()
before phy_init()).

The reason why I stumbled upon this was that I was trying to remove
dereferences of phy->power_count from drivers. This is a PHY-internal
field, and using it from drivers is highly likely to be incorrect, as
this case showcases rather well.

As commit 77d2fa54a945 ("scsi: ufs: qcom : Refactor phy_power_on/off
calls") shows, this driver tries to couple the PHY power state with the
HBA clocks, for power saving reasons. I won't try to change that, I will
just move the phy_init() call earlier, to ufs_qcom_init().

After the phy_init() movement, ufs_qcom_power_up_sequence() should no
longer need to do either phy_init() nor the conditional phy_power_off().
However, phy_power_off() is still needed, for a separate reason which
will be dealt with separately.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>

v5->v6: rewrite after actually understanding the core issue
v4->v5: patch is new
---
 drivers/ufs/host/ufs-qcom.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 375fd24ba458..ffa70c6c7143 100644
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
@@ -1441,6 +1434,13 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	if (err)
 		goto out_variant_clear;
 
+	err = phy_init(host->generic_phy);
+	if (err) {
+		dev_err(hba->dev, "%s: phy_init failed, ret = %d\n",
+			__func__, err);
+		goto out_variant_clear;
+	}
+
 	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 
 	ufs_qcom_get_default_testbus_cfg(host);
-- 
2.34.1


--5nqk7qqoimem4szp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-scsi-ufs-qcom-make-use-of-QMP-PHY-dynamic-gear-switc.patch"

From 88f4bdfee770cd433a940a14e318d8c8b5dfa516 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 27 Mar 2026 13:18:05 +0200
Subject: [PATCH 3/3] scsi: ufs: qcom: make use of QMP PHY dynamic gear
 switching ability

The QMP UFS PHY can now tolerate having phy_set_mode_ext() being called
while the PHY is powered up. We no longer need to power it down, back up
and calibrate it.

Simplify ufs_qcom_power_up_sequence() by relying on just phy_set_mode_ext()
and let PHY power management be handled just by ufs_qcom_setup_clocks().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/ufs/host/ufs-qcom.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index ffa70c6c7143..cf7b67f2021e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -508,37 +508,14 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	if (phy->power_count)
-		phy_power_off(phy);
-
-
 	/* phy initialization - calibrate the phy */
 	ret = phy_set_mode_ext(phy, mode, host->phy_gear);
 	if (ret)
-		goto out_disable_phy;
-
-	/* power on phy - start serdes and phy's power and clocks */
-	ret = phy_power_on(phy);
-	if (ret) {
-		dev_err(hba->dev, "%s: phy power on failed, ret = %d\n",
-			__func__, ret);
-		goto out_disable_phy;
-	}
-
-	ret = phy_calibrate(phy);
-	if (ret) {
-		dev_err(hba->dev, "Failed to calibrate PHY: %d\n", ret);
-		goto out_disable_phy;
-	}
+		return ret;
 
 	ufs_qcom_select_unipro_mode(host);
 
 	return 0;
-
-out_disable_phy:
-	phy_exit(phy);
-
-	return ret;
 }
 
 /*
-- 
2.34.1


--5nqk7qqoimem4szp--

