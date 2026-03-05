Return-Path: <linux-can+bounces-6945-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AZbHpt6qWkg8gAAu9opvQ
	(envelope-from <linux-can+bounces-6945-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:44:11 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB44211ED5
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11ADD300DA72
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96216371054;
	Thu,  5 Mar 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aVuZ/pCp"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66039A7FD;
	Thu,  5 Mar 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714406; cv=fail; b=iEXpt7QMuxrA3BfjA13CeRXiF60h24RxYeS/e5aHI8Gletho465nzs1mWERvgn6OeSDbudsmMvJZ9rmll/uzWXE70o2L5pRGDms0ZZ4b3Im+FOnjGn6CNoIgMUEGLZJ0IHWea231Eab9d2HMVTR9mNMXmFvQPQMSt1vpmOhgDIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714406; c=relaxed/simple;
	bh=or8sc0WENjxeyhmMzwso0wV3aL0FTia/JVm9o6LNKPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i3/Mrfwvd67P63cVlIGQnLL2mshI148nSbofgUzaGUZGIqZUT1VZyyA9qqlPqjIyatRBtjQo5yjqXJaRVHzDIGNDjxncZnMGYwTpVogLYaEWMiWc5L6nl2hH6m0yd1C7I6UMaL+UsJf1bWN+MKmu3SmUvwZLN9mXA3fEwRoIdhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aVuZ/pCp; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAM8CYqSO909Ua88/ZGFSSZgdsRO17HH0Di08xXLaVVqaUpuJdvi91ZJ+/hSMrlkhxXK/ThnTLKZlo5WsFVvRQGs6Q4nr22xXZzWlNAJYdbudv67nARR9RHyO/1odoQrlzhOhmN6wZrvKhPZal6YM3pR7qFjeyIqsUueVVmBFKfaQX9p9igcezgc4dK+VLHt47pOeP5Y8Tgb7CvVe8xEV7W7YqGcZ/1iewXG4j3nBJqSBSwtFy823dwsFFuWFPAHY+Zyg1TgWbw8LSFY9Cu+grr7hluvvbbBYgW9O7nwyYYJuQAr2K38yvWux09vg3yTvRKCh8nUKm4rxn7qTd+UYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFHN5nbkTUocV/DU/WX1AAVjcTSA69wM1/q5lcW7HqY=;
 b=BS1Y0luIS4Xu2V5lmpXr6UoGVm/5ZegaUTM4JmkK7DDsAONzHk78hxHVCXJOVdrnFnXrGrmh4PMySl4ZJGf2fmjkoZOCMHOem3ThELlgHhUP10ng0ks6jHiABS8VsDWroPNVH/0L6Vu++n3tNqzpOxavytBdDITukxUpcTfh8FhUAgJ8mtM4EvpgLjXlqP5IB1jfzC/RLMH6FVC19SfAgim1N+oQCasu6FIlelT3DdrTn3SShcuQs7sizNqNu9oYSC9XsWfhFBhQJ3js6JiyvdV4rJQ/XU++apsZciFnEPKWh/J70pKtbvP4fwRkMvWo7tJsaykn8izjnL+Ubnj+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFHN5nbkTUocV/DU/WX1AAVjcTSA69wM1/q5lcW7HqY=;
 b=aVuZ/pCpnWlMFp6nxLQBvwTT++JGtr38bS4i2x138FZ1NA4YaP6tBzJjIBUrgGcRHDcG+46cdG6paKmYcq0Xq3K0AaRptskKpkaR/ym8VFr6nZb04sUCJ+Z4e8XrGjYsR9FG1C7ttkTLAw8+rPFc6bVT/S3mCuSNubGB5BbR/+esUTZiCCCEacev8OZ+Ull6bMIEJQB7A2bIlyjP08FtJqDq8n/8YcdZsjunIEmZ5QXTgtgTqtNWiPfSUiHHItCTL2DqaWaGNGens98vC6tIuBoG3ppBtBhhvDb1RJtbkrWAWwrZfJ9eB+9pxVQ0GMORZJS7euKJ8lsyIW0DW1FQcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10677.eurprd04.prod.outlook.com (2603:10a6:150:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 12:40:00 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 12:40:00 +0000
Date: Thu, 5 Mar 2026 14:39:56 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Joe Perches <joe@perches.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <20260305123956.ojkt4k3ly64xz7fu@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
 <20260305122957.GA1652563@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305122957.GA1652563@rocinante>
X-ClientProxiedBy: BE1P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::9) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10677:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c26c6a8-1de6-40b7-bc41-08de7ab45099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	IaTAT9N7eaLnIdsyfqG4mBpi/u6wYswEPJvXXKsPKygroxQoxKFo/b5Co8mpkCgK4gaGxTrffK5F2phEG075VVz/8iEcQem4bWCeodqEUlvhtge1LNtbhPpa2l39wiFbbh2rzUw0ior7YJiP+bWgEQtNDd/pR/ipWg1o+sdgmb8W3JkotxApRnFjsWAKjYO3jVjLdp/jFL71I1b2Iy4UmzUoAcq7S7iuxmmTNUDqOrbBehNrtGvw23/y1e8Wnz2NjpEEcMg89SRKUmIvZVoO4z1GbJbrjvVFoBUUSkUcphx8Yy21DRqehPEq2fnyOo/PLt8wBp2VS2dL3p85qyQzx+T4C5iKQ+oFfomsCiepPTzVQnEjxHJaBHHgE+wRHoU5eU55i3Ryek3T0SO9nvvJYQJ/2bFHln43RZKLZY66+gBhKTXuyRjqbONQorg9tEVXNVfGo4EjcUq7f3kovx3HDqTzsZ21P/pf/m8AfH+zrudvLaX1CKBN+Un2ofpXnUuzNrTGd9g108xqLcmz4PZ3CVT5eWF1YrTRfjLieGa9vIQXYcANLqpKpcGSL36tqJmG2Q5a6L6xOK03M7R7FAzc6vwUT891SLUWXA92xalTdZi8Kr77KAM9w2OHYGfGEBC/SGrsXRdexoj6tNHbrbXZ5G9gpBev1DxooEZx/ZKJ5WYfVU3AwCqZBc/J7MXpw0yPPMZxGGnW42NsGRXCJxz8KeAIBPrBKDXw6JCAV+/RPgA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTMzWVJzRkhodFN3a3kzWUNHVnMzU1RtTFVEcUpmcVlDTjI2ZGtXMkdJdUFh?=
 =?utf-8?B?dE9iTmt6b1E1UHA5SXNsY3RHNkZYMnYwMkdmZjc1aG1EZXVlNldaQjRzZ3l5?=
 =?utf-8?B?TjRVd0xmVEthU0dwOVZNajJranRteEJZS1dLVDJ4MVhsdlhXcmNQaHdEbEFH?=
 =?utf-8?B?NEhVUWszeWxyRXIwVTVoREZEQkxRNDlrV2Ira2NvWnI3NDVPQ2tWcWZlb215?=
 =?utf-8?B?TmRuenpnakFIY1ZYRmdYc0wyVkZOSjUvMEljL0xMTVU3LzI3V1Zxc25mSmgr?=
 =?utf-8?B?NHNWdHo4NVFoZXBRK1pEZERtbUdBakRSdjRuaGpqTGdEdVZBSEg5VzZlSVB0?=
 =?utf-8?B?TmpoVTFGVlBhdlVhOGFvZnowcXlzMkpNOTQ5aFEwVE85VWJ0SURRajFJQ1Nh?=
 =?utf-8?B?N2hxbERiOUYwZVppODgzOGdWQnNNVk4veUkzdlZVSDBkWGNESHdPNGE2bmww?=
 =?utf-8?B?Y1hSNlNYdUE4TVp4NE9QYkZjbWViNVVzZjZQclp5WmtFNldvQ0htZkRxTnpE?=
 =?utf-8?B?eXlkV2d6TGxOV0JORnJaSEZUK2FtdTNMSnN6UDF1SDN3MDV4TzdEaWFLZ2ZW?=
 =?utf-8?B?K25jb3dyN0E1VG5EV0EvMUVLYk0yMmhVWSs5M1hMOE9YcFdWVXY4cFVKTEpr?=
 =?utf-8?B?ak9ZTm5KRGgrVnoxdzVFYWdFV2hPQmRsZlpvTVF6QWRVWVIxSGpaUWc3aFdI?=
 =?utf-8?B?RWhZWDVaMzdIbVkrNzkxSmFBT241MFhYSEhMWmpnR0J2NStwYXVrQTJyc3VE?=
 =?utf-8?B?d25rYVBnR0NhZEl4VlcrOTdHQ1ZKSnRqVGQ2QjJWOE8vVit3R3FVaVhBQ3R4?=
 =?utf-8?B?RkNvUjZWS0VSQ05FQW1lMnJ3VEFqVE4vN0Yvc3NvdTJ4WWZzQ2lrRDcrQ0Nz?=
 =?utf-8?B?YzFqNWh6bG5FTHY0aVdMZ1NpWENUUGNWMGt2bkY0c2tYdVFTU3IycUd3WEZr?=
 =?utf-8?B?S2JGUWV0dFJ5SDBKaE5BM3BqalAwY2RVZlljQ0FHbWhVZDI5aUoyY2s4RW8x?=
 =?utf-8?B?c2pGczFWQUZlUE5LUWU4YlpPQkJ5RzRKRlZDVEVuTE8wRHZjODdHSHNBa3NE?=
 =?utf-8?B?VW0wc1ZpdzZoaW9LTC9acm1XYlFRMFNWN3VwVWVmNzZCSUpQQWFabjJmcTdo?=
 =?utf-8?B?RzJ1S25BWG5zLzcrWU8yWGRFN2pDcWNhMmJmSlJSNHVkMFJySTdIckFIWi9l?=
 =?utf-8?B?R0E4UHRoMlZHQWZ3aE1uTGd5NVhjczBIajQ3eVNZTUxkOVlaMFRjQ3RNcEdh?=
 =?utf-8?B?ak9ZUzNRUEYydWdkUjh5KzBzNXZkL284VFQydEV0ZTFyMHlkZURtSGdPVnJO?=
 =?utf-8?B?c21Xd0tRR3puUys1Tm5OV1pDSHpMYVJvQ2VkaGxPNGlxa1JKSTR5cWEyQlV3?=
 =?utf-8?B?cCs5bjBqYXNnM0x6WGVVdnVlNC9LY0g2ZVpJYVBMMjVBZEVIU3Y0by95UHB5?=
 =?utf-8?B?bXlQY1RpN0NuaDFQNVBvOFVFMHphZzhkT3JIY0ptaVQzQXJqSkhaWllHZm5J?=
 =?utf-8?B?SFAxK1hIVjdYSTlTcVNtTXNNOUFSVVRKVG93SVZVcXRGUWpQUEVyOUx1blpP?=
 =?utf-8?B?NzlqN3AwK2xrUTFhM3NUOEZPRnhEeHM4TXBTMWg0aUhFckR3UjNWenVDbFcz?=
 =?utf-8?B?a3pSME05ZDJ0dHdMUjRaVXdkUlRZMEZGOWpUMTg2NmkzRzR0TnQwYWVDWE9s?=
 =?utf-8?B?b3o1VUtvOGs3NTkyV3VMbmtkNHZmQTRGSFBXeWc2bzZuNjUvSjRYdUNjVUV2?=
 =?utf-8?B?RjUyc3k5ZGhwcmZPd0NwcjVSSGZMZ0FPY2Njak1FR0R0Mmw2NzJwQllHMnhR?=
 =?utf-8?B?QWs0b0YxVTg3N0ZkdzVRUHVwL3JFTTA2N1dhM3dyRGxIRXRyaWx5anpPNDBQ?=
 =?utf-8?B?cVlMeUU5emd5enI1Uk5VQi9JYSs0dGM3eCtQbVhIaEhnNTQvekN1OUFoUDE0?=
 =?utf-8?B?K3E2RjZoY0F3TG5YdHAwUFc0YVl5NXVLRm1rNE11NkhES24zdlBUa3Ficnhw?=
 =?utf-8?B?a0RsdkpNTThTRjRtcmJjTlhDTWZqVmFDRHlnVVF1ZnlRUTkxSUNsUHUwYlhl?=
 =?utf-8?B?OTR6ZW1xZzFQQms1NXdudThOQkYxNGZUS0J3Z3dLNXVkZGFkV3k4ZTdhcFR4?=
 =?utf-8?B?Nkw3V1VNdE1NWDNhMVN5NHcveUFaVEQyekdBdzZjdVZMeEFoSDBPOEZuZG1M?=
 =?utf-8?B?VFRFVVdqc3ZYNEpSeVpSU09iTTBYY01tVm1YOGNIdnNoa2xxUkdaa2x6ODFw?=
 =?utf-8?B?WUZqU0c0NGg2WXRUWEtHWDAxK01sK0VzcWNBUXdldTc3WlFvb0t3WWV1Vzlw?=
 =?utf-8?B?bUphN2J3aFhYZGpWQlFTcS9abkpNdHZTYkdRbkF5Z3dORmt2QlpGazcwcEZu?=
 =?utf-8?Q?q8GejVY/u/NMJ/yMvRiEW6xaWcnXPWY4nlP5dtwcyZp31?=
X-MS-Exchange-AntiSpam-MessageData-1: TQz4P36Rl6INlkOZs8Xp89OeMO3pzoMOsoQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c26c6a8-1de6-40b7-bc41-08de7ab45099
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:39:59.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWdFX5435tWNjkjZkFJGeC+dzkqrulaSQhTwgHRagCXFYSBDsW71HQY69+ORkIB/u0N9SdD8hbuYCvMgtO1ZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10677
X-Rspamd-Queue-Id: 3CB44211ED5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6945-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:29:57PM +0900, Krzysztof Wilczyński wrote:
> For content match, it could also be:
> 
>   K:    phy
> 
> I believe this would match everything of interest?

Yeah, and way more. Think USB PHY, network PHY, etc. Don't want to drown
the linux-phy mailing list in unrelated patches, either.

