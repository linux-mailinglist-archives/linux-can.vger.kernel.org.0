Return-Path: <linux-can+bounces-6928-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLAXOjFEqWlV3gAAu9opvQ
	(envelope-from <linux-can+bounces-6928-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 09:52:01 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7157B20DC1F
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 09:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C05033019C83
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DA72EB87E;
	Thu,  5 Mar 2026 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C+bTmHYX"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AA3659F8;
	Thu,  5 Mar 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700716; cv=fail; b=HgXy8IE/SAgl0YzJWs8I/yvmCui88ez0YkiPFjorwAE7SJEmS7GqFnN4CDwchxWVS7r9V7k7IX/e1TN/rjhQLEpqqz/ixh+K35hRms6nJ2m56wmDRd1zd9QRTbGILhlvvRPALcZ0ACVkOzOhYDKrqaq85///0k0C6tvWLdiS7Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700716; c=relaxed/simple;
	bh=bHiBMcheBliIVn6QB87OiX0XT/pDnMMUtqmyR+KICi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ne4HJPBJDBGtqhtdv+CYYlMb/kkqsENwUWb0y/4MdgRiI4QdibN7pV4DQSk0Lfdb994BRjcNH69zcMKA6PzVaynVM7dqZi5+nUJxKb58eBZmx5bmwS4gsnYSqObRaGn2UfvynGQftiebh/tukuKVly3RugVSQyz/KSXK45pQMmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C+bTmHYX; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAByO/jqb6mUdfc1nRUWLmcodNPsbWLQcJoYdh/pu0elyJChyxZFB1dbV0K5Gz6tsLoZlb7t5vHJHH17ORM/JJI0T8QeFYC1W5ZYP4po2776AOrQVFQybb2gN+3Tywefp5DxO6JD9LxrRt08j98QQQS3m6k4cfHyHkfQ4uZy8AwS1w4ORwSQV3ZpVCsENpbsdWeSG8UTRKIBImtWrddnouztkfugKxSiJZLJvNBtkt1O2Hdr5Y4bWV91kZbj/esf26AVMmVXhE9cYcpPl0VEYJzRkrjGtctrycHIeZmeMxM6/6XzEVXQZhqTFr7wbxT1La6sRogx7hwEB0Gj/9u1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn80cKSe+gXqxGplEDzaGs6vJx+xuyMZJX1zgh+9xkI=;
 b=m6nHWl0UM8t31p+Lk9vrhr0s52x1TMfE0LanigWgzFrEYECT03jLszivor1bp+DL5g9pANX8Zm1KWhvG+WbE2eayiiFpFg/cQcxXZ4qnPJG8PINZGFdpWBF7fT8b9QcYknSHm3fWjjH5Q+0PlGxxr/PIBNyjUHTq5dyEAkUmfVRes6UCgP7O2NMTvf3QVbshUi+6Hscq/3Xn538MhKbAdiRsR7EQETQYmv84kFxxwTfoZiHAWp+pnyqZUJczT8kceYJNAC0jKLkpQQkY63TYhwT/9EmcV4JsksL1IxY8DqnG9f7SiSvcICksKlMhXKmf52PbJ7JdWju7MpnvhQUr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn80cKSe+gXqxGplEDzaGs6vJx+xuyMZJX1zgh+9xkI=;
 b=C+bTmHYXiM/8qbNSIABCIW7sPlOtEek3sQptB89NdJ428z0eFOqwSpazkDwqFQH/JKdmi34p1LjZ0VIE8uU0DUVQqLwvNMeOcja9ieQHzcDAy8XuOR51G9FJ5mOGjisuEtBhdCCmZd+k1po/Ov2bteJI1PPnvCU60z6rXKIS0/GrTfKiJ2jCEoYnBokoHu2j0KwUyWGTAdGDW3/5RJiPXX2nH74cZROU5Y5M2WPHSJpWRSc6Hlxi+Quzyj4U/7twafKWWYCDnr0ztcmn69Bha80gisu5YFWqtueb3EgAsdqIJWggSzek1MwxFylKEZ/SpY92HteS7pemO2W14Blnjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 08:51:52 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 08:51:52 +0000
Date: Thu, 5 Mar 2026 10:51:48 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305085148.7cwo3yflp7vcfldf@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: f3794075-8f10-4c5a-7756-08de7a94722a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	HVVOfQwxdDmxSz3P8/MbGt4uP1dgx0+vQ35z3nC9LmY/OPQe90dIa6fgFsLF+wE70xpEBm2htokbQf4jpAWudymIfm8J2yNCEcRuRqo5C2XBDA6zkJ1dstfF61J9RNDtSgRE4AAIVN0fVIsm0+o6c4ai/tCPI4WFqhxwDVIG6P4hrp00OWar2Vo4JxWPdVBTC2p1Y49UtXCCbbbjMRI36jDM6BSvKecO/aQNtVNzDlKlDo/xXQUkVpkYvDgDq45BSeLf9vuA3C9RmG0kGTNUzDaZA2AH/QoEiMQ3IXSBaSFy6bOCaIyuN1ow+mHrzvye6hdWMdmwRytoWqF4FKBRmVGZx61EH24WFUWrHk3TmLAf3cj1C5pIe0aj8LLomMCYvBbOVhNTFB6EpzH1ZEiaeWUkgssGptp2Njdo6M6RLZkrM13vGHWqn70+fJR7v2FudCYQ1bGyNDTBg1BuatEynuKmi1WSZbDR5wnE9OkGv8JlZLS+7v86TBRxME1PdfQJh9UaitRfRIUJ4Uqo8DAyg4crxhQh3Nc2tIQ5+beVbuGnSLEzoDJZOX+JP8Gl2jLUpcAafiUf2bzezZL2W9ssZx0i05eVQ7IJr7WRPAVv9cownPUUe6S1fnzTUKjYFGbJLSxtyEgQTaTgNwBICtoyOPuTwWQTf6OR6pW+UTPOfH+arMSo0Q0hcdnf77Gs1a7UEV3BDYwRJ3xijZ6B4An5JPl/K5DNkVCiRpiq5/YnTrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Wg0RTbJr9xq26XXL3fWxdwYiqnn3CLZVKs7wvIj1p4/glF+msfF3igVUhEk?=
 =?us-ascii?Q?KCrqL4R1O31j4GlOKrxe6L13t/5l1cFMXeuycRmlpnm+hVML5ol4Ix5k9++z?=
 =?us-ascii?Q?ENHi0slX1nFivxmkGsBq2jZ/GE1DdINOegGdgT1LiBqHp1kOUihGBJn2NKFs?=
 =?us-ascii?Q?u6nGJZCRf0GAQywqQh5scqoF6GHMkpDbc2YbtTNOYOxgz3nyd5J1PS7399ps?=
 =?us-ascii?Q?QZsv+uxLSZbqnqddfe/4ml0Z96N1Zrtnp/NQVSp7hhV4WjBPqJ3fPUxxAjP+?=
 =?us-ascii?Q?VRjARKN/+wIQYthv4YYtLEk+5kuPBNdAZJOZYrZv2V7fjXGpb/HUsb9Yk7XZ?=
 =?us-ascii?Q?AOf6Ubz68j+n5jXmUz6QhGG3tXT/BS+otZfXL7m0izOoDysUdFRQjJ+Mtna0?=
 =?us-ascii?Q?ZhNF+Td6TtsFjRzrbqKZjhtctZoDOmi2bEzOGaqYLOi8tazjyOpulv4QFDWp?=
 =?us-ascii?Q?qrNdXS6JqXyLGhnnwUVnydvNsIqR9YrbzDnC5FuWoh3xIQ0+5mFK3ijPN0eZ?=
 =?us-ascii?Q?Vo/vOd3RXOe0oTXlpoo0EehEIMR9THbVxoVjfMsgrhzVmPFgxh6GOOjHyR58?=
 =?us-ascii?Q?8Lu1h72yT3veAsP6kvtoHxzUmtvXCKixC1RBMf/8Sk97St9rkh0H5TYa6S4h?=
 =?us-ascii?Q?XfRW7IDsk7/sNFyMyKyjus0nOQIkcqPY8HEw2NXYerbfhtDi+gxpZFtUg9/4?=
 =?us-ascii?Q?Z1XEPhoT4j/Uhp2ufaUIQiSxqzGF2cMEBivy3NSlfbnBjwu98samuDjiQLm0?=
 =?us-ascii?Q?eEix2pHT2S8KRHOoBjohlTXojoLKZVt0GGbRr7idsAbI+LwaYMiZVOcQKsrn?=
 =?us-ascii?Q?VxzCTrL/pVqi2abrg7QskZdShspViikyZTSLotT61X94gkB/nqAIF5o9v337?=
 =?us-ascii?Q?Upj/zjMlTvsam4s2eyvnXWz35zqSgncttHtPMcurUnutsse5kG21xlerkenB?=
 =?us-ascii?Q?dft9OtJF6j1D8mWsddb5mn6bBefH+eBMNzpzR5LVPlgpjcTU2gCO69lmPZOi?=
 =?us-ascii?Q?FysX+sCdWJLeLPvD0WcHsuJmeyr319aEXLbomL1dD7VN3kw2fvAhugARwiju?=
 =?us-ascii?Q?aldqFp9LnqfD5lGrK0rvWeL95T4bCNwCb6erOrCY4dovC8RHA3b6Os2givgw?=
 =?us-ascii?Q?KC3XN9C5LI2kWRMnKmmiJyYtQdwZ9yR5ceMLMktcDNerCi0Umt3RiTH8Mjue?=
 =?us-ascii?Q?Xh9eGrTuhykA/BB+HllPlGSAGN+cc7n6XuJWX7BtA4Yoaks5yVQRrVXiX4s9?=
 =?us-ascii?Q?NCCeqAjChN6GQyZMzZUdwMih9h1pNSkDssrt2c18HczGr/dZgooC4Inouxjn?=
 =?us-ascii?Q?ozb8ms/EvkClLQ2whMD9Xz3mkKFgp70E52b0VOjBzO5mDfWK3sJHK85/A9TG?=
 =?us-ascii?Q?poeHie6ggNcL8VOqu4x4pKjWtCxMzKkuOVMAKhy4maRK5EKllvs2e77iZ3vc?=
 =?us-ascii?Q?Tigh0A5HwW+xT7T+5T26pufK7ap4/7rTt1ycR9NX++6ZYOaX8FXn+JzBq0ii?=
 =?us-ascii?Q?ZQlRqfeP4EA54jerfCOFefliHhxgVGiXBgwBrnxjutI99pYBEX3cwDFvisxr?=
 =?us-ascii?Q?/QlTnIxu5DjY+Wg8k/Q48pZXHqGOGBTzD4bLpL1gh9WjwxP5oO1UXltbRWgA?=
 =?us-ascii?Q?xw9w/deTkKZ9KGyzotH1bJHA//64/ANkkd+hwBFyJQY9ds1dPIZuOe0xHTuG?=
 =?us-ascii?Q?/7Xug35243duqW9muCFVZH4AkTRtwBkywcDDw1cySXdFOog3U4HMzw2uKKMN?=
 =?us-ascii?Q?4PSdUyo3njuFZnydZVcvx5cJookxkeuml7OASINihJWnyA7cuUqquTrX1RCK?=
X-MS-Exchange-AntiSpam-MessageData-1: fWnlM+bZmrVk06iF7ehT70ZwXbi6ZEOkcK8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3794075-8f10-4c5a-7756-08de7a94722a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 08:51:52.5667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEuVcQAeBdYuEQfCMqrD9vqGTo4XMNyAvV0aKCkz9TdQwqrWu+DWT/dWho4m8aKp9DX/eUS9C6p2HqafjCcG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
X-Rspamd-Queue-Id: 7157B20DC1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6928-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

Hello Konrad,

On Thu, Mar 05, 2026 at 09:39:35AM +0100, Konrad Dybcio wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 55af015174a5..bdfa47d9c774 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10713,6 +10713,7 @@ F:    Documentation/devicetree/bindings/phy/
> >  F:   drivers/phy/
> >  F:   include/dt-bindings/phy/
> >  F:   include/linux/phy/
> > +K:   \b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|off)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvdata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|state)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\.h|phy-props\.h|phy-provider\.h
> 
> Would looking for the devm/of_phy_ prefix followed by an open parentheses
> not suffice for the 'has function call' case, instead of listing all
> currently present exported functions?

This would maybe work when you run ./scripts/get_maintainer.pl on a file.
But I would like it to have good coverage on individual patches too. And
since the devm/of_phy prefix only matches when you "get" the PHY, not
"use" it, my fear is we would still be missing out on the most important
part of the patches.

> 
> My worry is that this approach is overbuilt and absolutely no one will
> remember to update it

I think I can add a test in the patch build automation that correlates
function and struct names from <linux/phy/phy.h> with their presence in
MAINTAINERS.

