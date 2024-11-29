Return-Path: <linux-can+bounces-2282-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C939DE86C
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9FF280EFD
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62905588F;
	Fri, 29 Nov 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PcYg8Owx"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5E39AD6;
	Fri, 29 Nov 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890357; cv=fail; b=eY4/Y/JQvSDUvh1LxAWZRJ5rLGOavsbpm3AZm61QzwP2Y5+HH4PVTeNa7LoBQjjcGh3r/cl23xzr+ZSqP9yUPdWX/WqaxwdCKQE1o/tM3O7OoS9XoioIV5N2ng4/80v6PlLiFDtzmiaoJiGS56kBR+ET0j8/KKMvJd9eXr8SVUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890357; c=relaxed/simple;
	bh=D/27Msja/lJBWRfcJFy3VjNENyNFL2o0U4+oVCpi7ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fe9Rm3hVVBB8kVMenXwNnIP6CETsUXcco9ozf2tU9fHqwtaMQbe6Gn324HC3CtguOPWNplKhzB57IX0Hdlhn62qjiuCQdZcCOTJbSJInx5mesRifZ2s0+S+WTpoSbz3+3CXNzaxDQHduWXB0DZZMZVDTMrNAaZeYeXQ4/sYRJcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PcYg8Owx; arc=fail smtp.client-ip=40.107.104.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXdWa2wzZboAwkkU9P3kFbScYcKFS8UOWIKKGZafhfMWoBVNS9pWRF7O6n9mXx4iBxI3+z05qK2xrU0W2BOSOPJ6H32euLD+NdFjM/ZmljZllyAKm+sgXkFEnpLfoWnQyPDjsRVBjGxCDDeCDcaX+AIhKN06h6+H6cruthxZAV3o17aOtUjZAGCFpnIco8W4z5sns0itpBRX/zEKIsFHoiZIvqJZx6o1WD+eMD/I9XnQzZAN4JfwF1f6e8D6Up0Q+SJJK2IySln81PlpnzbQ03esF0yK8DCyjnOHbDDYDWL5M8WAyHWBBu6R8hViWSgFQmlYawMK5wJ/GGGRj05QnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpZ3L6RcAnRf0eDx7wa22XwJ34ledo9Aicworoq88jQ=;
 b=BqH9ad+b5PC1EAyBzNG6NLnzNalQpowIC1jm+J4oe0daPG/d7Hsu7lprK2MiIvUY8qLKAT4mxNAFg7oschzlGTnm6aWLbbfizcCxDdlRI9NNosRA7yVS/meGh84R184pVEI1nu0E+VvnRAUvgF3nfRwPNsMQUdwwb6n0M46EsXphYIC6CgAKE9R5SwBPrRQn0WmpnWc+W/XTEdlw7X7Gi1k5NywBsiA4sjqGCpYLlQNiZ2mobJrDtq0axxvWJC0P0e/O6kiRCOh78T8rJ0EOuAEK0xzemdGm7XzueYiPTTTV1bQ0ivyKaU9HcQYuXeXuTeFN1IrD5uYQoGYk15c2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpZ3L6RcAnRf0eDx7wa22XwJ34ledo9Aicworoq88jQ=;
 b=PcYg8OwxOnCnvB9Hg8ObxLToawfOR5GW31Y4/jPsL2TH4His3qIn2bdzxvhxc0rVD4Grx3BHgAOktoxpW4hbLcnfPVVra6epFs8J8RLC5w4kUIVtEe3o2Fh4Y/ooocWxLLJZ/cmhL9SAVv2/Poyr6TEeWdKU20KUHb71fNF+9iw7RGkzqdm+ZZIFGwcsDwr6beOivC3KqNwqHURT/YilwILSPgTCWJ34K1sc7mo0XTqhH0SbUkrKPUD8gxSHqZBMeok9O2nx21tqH3iB0uoCt/l9v6z7WQ7v2+c4cwI/zo/6TP02pWUaPgxWUwrdapHoffFgHG8YxUZNg2jBu+SFuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 14:25:52 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 14:25:52 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 2/3] can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
Date: Fri, 29 Nov 2024 16:25:34 +0200
Message-ID: <20241129142535.1171249-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
References: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::8) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee97418-e821-4ecb-1794-08dd1081ba4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUF4ZVZTQjRzRCtNNUMwb05GL2U4WUl0VldkcmM3K2lkVTlySkY1K0NOV2Uy?=
 =?utf-8?B?NWZMZkZhNWxjZncvYVlGc1ptRm5EUGlWdUo0SGErcDBSR1RQYWxQRHB4Y3Qy?=
 =?utf-8?B?VHVPSTk4VTFvbVBGWmZZZzFtQ1RncVhYT1dobUtibnZPc2xaWEk0bHh4SnV1?=
 =?utf-8?B?a3l4bHZKamxtM2ZkNy82YW9iVUNpYWZ3L0RiWmFXSVlqbDRqSEQyKzVsdUll?=
 =?utf-8?B?M2svU284RmdDVGsrNnFjNnpMRHZKazlwTDRxLzNOMEhhWnYyZC93clgvWkNS?=
 =?utf-8?B?NHQ1OFh5cUFuaVYyUVBIbTl5V25Tdy9KSkkxUWtVbzBvRXZSVUZYSjBwNHln?=
 =?utf-8?B?Vm91aWdRaXRheE1KTUJibjFoMFk5ZnVYSlRlYlhBV3R6RjNPRkZCY2trZFNw?=
 =?utf-8?B?dE9sd2RZVTRtejFpTVhSZkJCWHJMR0tEOVZVMzlTUEtmcElJSkdhRkM4V3dr?=
 =?utf-8?B?YmtKZmR5ZTM4c1NHQ2xRWDJ4UkR2UXFjTFdXanF5cFRHZk9XbGRIdXd4SEJ2?=
 =?utf-8?B?VGk5ZUdwaVFQVzdwb0NEU05ialllbzdpbEhUdGxyR0RuMzBTSklmYVA4ZTE0?=
 =?utf-8?B?b1lBVDVzSm5qZWpsdTJZVkYyMGJTMnJ2aFBpd2RibU9CWFVPSStxQmRzWkhF?=
 =?utf-8?B?aCtVWjlxdUozYlFtMnlCK1JEYThaUldJd3NwQkJXRFppYXlsMDhwV1hZRFVU?=
 =?utf-8?B?OTVaYkEwSm1waDg4WklVNkJ1a3Zkc0dpNkR1LzZLY2dvWFVJT3FiWXR5Ym1Y?=
 =?utf-8?B?dEd0ZHc0elQra21wQ0E4NFA0WWRJYmF3VDdBZGRGd1NIRkdRTTBUWVJUZVc4?=
 =?utf-8?B?RXAxbE9TcE1lSjlaNndpV0h1QW1Ga0lVMW14dE1QazZseXZrSjF1S0ZWQUVW?=
 =?utf-8?B?VEZOZm9HZ3JWY2pYdlp1VDhsMTRJNXRFYWJObXgxelZFZ2JpZ1pNT1daa201?=
 =?utf-8?B?aDZNNVQ5Mm9xeXpSTWFTRjBCb3UvU3dqOFY0VldSdUpPNExyU2Qzd1BvS09C?=
 =?utf-8?B?UHVyRDYybUlRNVZUTElHRWh5NC83Z0MvUDN4NGNSeVhROGdyN3QwNDBzSWlr?=
 =?utf-8?B?M1g1TmpLdEY1MDNGbDBjbjVXbkZhQkJGZXVmZllMOGpDNnM3NllNNnh0NFhO?=
 =?utf-8?B?UEI4NWRFVlRvMjg1NXpXNnA0YW54NS93Vkd4Y0pRK1lJK2VObXBrZTlYeW9F?=
 =?utf-8?B?THRqbFBKU241SHNpM0dJUW5VRzg5T0l2dEljQURaSjRXNjdLRStFRzBNUEhz?=
 =?utf-8?B?OEZBL2VRL1RrTHpPNHhLeUxRdm0wa1FIN2kzVkNTbXl4aFlLNXJOTDBNcXFJ?=
 =?utf-8?B?a0hoTlNxL2ZqclRlZnFFc29xSnFsLzY5MkNVYTF6eDVNMUxzdzJFeDhDc3JC?=
 =?utf-8?B?S2YvS1dOTEhUWGc5b3VuRUFxUjlCT0tRWHdXVm5HL09MR09yYnk4RExOYmZs?=
 =?utf-8?B?d1JCZDdkZkk1RCtvWm9VUHJuYlU1R3JHN0JGT0UwT205d3JwUXJDNHVZSFZo?=
 =?utf-8?B?SjRMS3p2bTRtWE85VnJtYlRXd3RXd2w3a29KUjhkSTYxemg0aGZKQzYwZDVr?=
 =?utf-8?B?OGRsclV1MUs4eE1rcmxRZ3pvNmp3aEY1MW9kM0p0aTVncXFjcWxFTTZXeis1?=
 =?utf-8?B?dlB4MjNvOC8waThXQlA5NkxVZjdYMTZaTHlNRkFiQUM1QWtubE9pOS9SYUhF?=
 =?utf-8?B?UFZKcEs2SVJTVHprNkJNMlVVeStid3RNT3RGYlMxUUg3dHBSMHVnVFhwYkRM?=
 =?utf-8?B?QWowZFZ3RXZtajczeWt6NmhKSWNxUVZwSXo2bURjcUU4QlROU1ZETyt0cktI?=
 =?utf-8?B?NWNYZllueHVTZUphQnkzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1pWM1MxK3BiQkVxZXRBQ2hzV2pwbE1WSDdkV2RIUkw0TVZQRWQ2RVRGNXNa?=
 =?utf-8?B?UTlSVm5NdFJIcXROSnk2Y3hsY2xOMlRDdm5UaFQzTG4vTWdhTitSM0xjWWp1?=
 =?utf-8?B?cmU3LzIzQmdLS05ORDJVeHhwcWxkdTRXa3RwTzRwQm1DSDRzZ0tNelB3cW9G?=
 =?utf-8?B?NUVXOUtTM1ltQUFyTVJUMjJTdnJDdWw1aDF0dEo3Sm9pcTMwMWVrQUZybXhm?=
 =?utf-8?B?YktmN2VOdlhRblgvek05blRTN2VHOTh2M0c3VGlJRkFzUTUzVjB4TGkwL09O?=
 =?utf-8?B?WXcweG8rQi9JckViTWNwZUxhcXA1WWlrVnFxa25kQlhZaHZUTnNnU3daUU9n?=
 =?utf-8?B?N2dnOEovL1hLWDJTVkhuOXZBbmllK3laSG12R1Q0OU5uUElkczJIbnNyNGoz?=
 =?utf-8?B?c0RGTklpVCt0TjFXUlhSQytCSzE0c3REK3ZJMmhRUHo5TUJvQm4wRGtRdlFO?=
 =?utf-8?B?Zit0V2hqWXlsdEw2QVVzem1BV0RjMGpIVmxxWWN0ZGh6OXNpeGU5STNITCt0?=
 =?utf-8?B?RVMyaGhBSVozTGUyMVFQQ0ZXOUErdCs3SzhHS2cvQjJOSDNtVVRsclNUc044?=
 =?utf-8?B?SHRqMmFseWt1N3RkVHkzY3BaSTN1elF1OGQrb1FJdTRncERrQndOUXlQY3FG?=
 =?utf-8?B?cFN1WW1YVmJWK2kzamdZclpwSXlHcUgwYUFqYmR6QnNHMXZkVE43TDhnbTg1?=
 =?utf-8?B?L2cyK0JyOWlTWkFJZHA3UzF1T3dpb2M5NS9wTkNEZ2dYU3hCVUVZZ0pjRnJE?=
 =?utf-8?B?VWtaM2lsZlV6TDdvQ1ZtcmtBamJoT2dUSDZOSlV5SVVlM0doT250K2l6NWs2?=
 =?utf-8?B?bW9jcUdhOVQ5Wkcyd1NVQlZNVUpGVzdvYjZEc2ZQaG5XZHFxRnpmWmZwRk1Z?=
 =?utf-8?B?R05JblErQXVwWW5tcFFzSEcxVk5Va3ZlWSsrVFNSWFBaOUs5WFRVN0Ixc3Zn?=
 =?utf-8?B?Wnc4RGlqdE5tQjREUk1OSVdXdVR6dHdNUzVpNUtoNURySmE5dmVFOGY4QVpY?=
 =?utf-8?B?bHFjZU02aklaWG1aTnJjUXo5R1htbTRNMExzc2czdG1CRFlJL3E4RVdMdWJa?=
 =?utf-8?B?MjBza0cydjRBbDhWUm9MTEQvUkF6dERkWlM5N1FlZW9CR3ROQVgvbFpPMGxN?=
 =?utf-8?B?dGI0dEpLYVhrZHFxeUc2bTc1TXF0SWRyUnFwQWowY0hxMGZ5UDhLOUlGRmZ1?=
 =?utf-8?B?ek0vS3VCbHZzd1FOcThvTXpmeDl0cTdUcGRKODcweTNGbk5NZXJuTWFST25B?=
 =?utf-8?B?K2xLRE9Ka2hHc1Z1MExFWDdXLzlmU2I4WWxoKy81WEJEVktYL3lRcTl2cjdz?=
 =?utf-8?B?cHY4blRQck1IMUFNMXBwU2ZrQTNlOTcrZDRiY3ZXV3VkbzdOODFSK1FBYzlD?=
 =?utf-8?B?a2ZUUnVLMGlnR1Q1SFg3bDRRZzZsTW5BZkxkQ0doY1c5NDk3amlxcGwyaVRy?=
 =?utf-8?B?OFBBMzRJQjNmOUI3UEJ2MnRjVHdJQUt1eGZQL3VMM25zc29PSnVINXJLYkhn?=
 =?utf-8?B?U3h0MytERjhLUmhvNEx6TUpNcXZxdGZKYzNTSCtDUTJ1djJZelhYcXZzNnF4?=
 =?utf-8?B?SEZGSHEyRmQ0d2d3VWp5NGhiRVg2UTJTV1JscU5XRTJVckZMWDhqdGlRTnQ0?=
 =?utf-8?B?elRaVjFtVVFjaFh3dkk0SnJXMU40aHU4cnJiM1pBQ01PajRhci9aekN0WmlF?=
 =?utf-8?B?UEEvZ1JqVXF4cFMrZnFyaXdiRTJXT2tudTdRUFRJQjVBQkVmSzlzaWViRjZz?=
 =?utf-8?B?ZDVLcFZqWElmMCtqV01BMHRFUUZSQnM2WmU2QUwyT2tBcFlqbFJpWFNCOEdt?=
 =?utf-8?B?Y2J2bWNLS0NFem5jWlF5OVhYZ2lvWWptSUdiMFJpcDBBYzNDKytrdWd0a0la?=
 =?utf-8?B?RDU2cmt5K3Z2UENGSDJQVnZnS3BxdktWK294Q2hKZk9vR01idGNTRThRNTRH?=
 =?utf-8?B?NU1VUEVmRFhKTW51QW1NZzhBNEViaU45ekY5UW1FQmU4U1NxcytQQ0tMMFZO?=
 =?utf-8?B?c2c5cE5PVE94c3V6em1GSFEzOTVmZTRnWU1WcDRwQUZuVXcyU05ZbHVKYVh4?=
 =?utf-8?B?SGk5YW9RczF3MlFaTTZWYXAyUG5uSnNhNld5L2lhQmFnd0hZV2pmRkVlcnNh?=
 =?utf-8?B?TWVNbnZPMU9KUGlUWVU5cjdDN0ptODJiL0I1MnhpaHNwTVNQNlJWSHNHbnAx?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee97418-e821-4ecb-1794-08dd1081ba4b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 14:25:52.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P11SOTmgBl8zTrH/C7P0VqrNyPiobrLZXUDkZUziBntwY9lxmpdYE1j4ei8ES0bUjqE13aXEzibgU/crXI+A0j6Me7M0gJegDe15AEZ62+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk to handle a FlexCAN
hardware module integration particularity where two ranges of mailboxes
are controlled by separate hardware interrupt lines.
The same 'flexcan_irq' handler is used for both separate mailbox interrupt
lines, with no other changes.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/flexcan/flexcan-core.c | 24 +++++++++++++++++++++++-
 drivers/net/can/flexcan/flexcan.h      |  5 +++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..3ae54305bf33 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1762,14 +1762,25 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = request_irq(priv->irq_secondary_mb,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_err;
+	}
+
 	flexcan_chip_interrupts_enable(dev);
 
 	netif_start_queue(dev);
 
 	return 0;
 
+ out_free_irq_err:
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
-	free_irq(priv->irq_boff, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_boff, dev);
  out_free_irq:
 	free_irq(dev->irq, dev);
  out_can_rx_offload_disable:
@@ -1799,6 +1810,9 @@ static int flexcan_close(struct net_device *dev)
 		free_irq(priv->irq_boff, dev);
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		free_irq(priv->irq_secondary_mb, dev);
+
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
 	flexcan_chip_stop_disable_on_error(dev);
@@ -2187,6 +2201,14 @@ static int flexcan_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		priv->irq_secondary_mb = platform_get_irq_byname(pdev, "mb-1");
+		if (priv->irq_secondary_mb < 0) {
+			err = priv->irq_secondary_mb;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 4933d8c7439e..2cf886618c96 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -70,6 +70,10 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
 /* Setup stop mode with ATF SCMI protocol to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
+/* Device has two separate interrupt lines for two mailbox ranges, which
+ * both need to have an interrupt handler registered.
+ */
+#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
@@ -107,6 +111,7 @@ struct flexcan_priv {
 
 	int irq_boff;
 	int irq_err;
+	int irq_secondary_mb;
 
 	/* IPC handle when setup stop mode by System Controller firmware(scfw) */
 	struct imx_sc_ipc *sc_ipc_handle;
-- 
2.45.2


