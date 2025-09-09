Return-Path: <linux-can+bounces-4535-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7010BB4A154
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA6847AD7E0
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5009D3009F7;
	Tue,  9 Sep 2025 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MvxafVT7"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409A3009C3;
	Tue,  9 Sep 2025 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396461; cv=fail; b=J6K5BjP/U84qhxewhDxpm4iCV4ZBAWSIGYl9a5BVoNx36G706XBAiMeby88klGEW9achNrGcxxe/RmcIlQs1uLul3BQh6nIU8PKhxVIv65rgR0YSYzmzGh57EEQ7KDM+weynmkpxMmMNbURsNb/8o2ILv45HiN+ts9CQWIXkadY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396461; c=relaxed/simple;
	bh=/3/NVxy4+ravJJ72BLKZ+T3BvDKv/86w6dSaeJCvsUQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CSNKnaIl9NDBWSVSQYJ+X/zK6xOOjBsknG6Y/CkiU0bLvdvGXnxq9B02jexnaCSkTVeTaiWu3tJeQ57nPht/ozqhio84FNQHDPsbl0Mhl51Gx2EG4/ZQNuPcAy5HLF04MdmzI833yXoxxXV6Bkc9lnPcDJXOwLc4Dt/cbiLOJM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MvxafVT7; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7f/8MnTi7meoMJTwBHAi7EeyguNR5glal071/SqhPGUh/IsEG6MGxEt5KOKDsG/aoNFl65AyHc0WG1MLHV81rhCR1i42cnDDRtQs8vgE+adGrxeQX4zScAc4r84nt+Vmm/iPC0nFCgbGDNVrkLtZG7ftvRkt3CzpbSvRNNzd1/B/XYQ1ZYYR41zCJU2K/Duz02d4UxNXp/c26Tw4CqvDGO++9oGp0yGSzKqtoDiFsorJjv5uiGb2y1ui+giIjjIQ4lHn0mjmU+EIfT0E3VXqZugllssIX9toHBKNEACSAnSGugOIp5B1LAQs3SLsvICS9gq0hYgjVw1WlaAxBvzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3V6kTbskdKC+t507jTwHcL+OBpbu0uINcrX4Or1PrU=;
 b=H1X6XKfdtyzmSZyIa6rf8zxAK+6HsswjxFkNH1a3ohzm3e4Xc8ywh4g5ibUy92eYFR5ggWWxLgQAGSPZG1HJGl4/IvILJWwYdzzhxqYiRdDFAvS/698qah94fAEiCfshGkxQrN/XdfbA+rDEbom2Hql/rmRuM5nzWTWhR/GbPvjUyCyfrBSaQ1YxX/lSK3rZzn/rX3VAhGXU6XqluJR4zr8JXC43L5jVWtbWMEOpHw3fyIaH6V4bmGfmvWL9UJRkwwqYfgIVW/JYEbaOtZgEO2N/ku6McxlD++Z/5Y6/rSK6YSHvTrGgbgIy9CEZ66megXjHVUgbS/Frgtt3M749ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3V6kTbskdKC+t507jTwHcL+OBpbu0uINcrX4Or1PrU=;
 b=MvxafVT7JJ9GbaO5xNuXVPdjXxq3ixp7kKdcM0oPFHXTlA9s9ANbjPs8bZjRXgOhENyqwC486nHGq3fsEqBskS5haRiyoe8mLkLIaax/68yqHR8U0HAYgj/iwnBNEjcokQKLBaNT8GSMwHhd0X26G3aGRns6gg9S0k9lPXZ5dwfdfJLUxyxhJv/oVdS5TKObGvEsjFC3pa4lN9jbIFbXcTSCDa2EUyF5ox7jZzGjjgiB3rforlrhXq3vEdFhwJF35joe5DEP0t7aRHE/NrEek4KvDG1hWEw7WZktPNuh+sSlhzwXKwU7vK2Gs3arq1R6lPx0zqm01FQDBGBnSJ4kHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:40:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:40:56 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:14 +0800
Subject: [PATCH v6 4/9] phy: phy-can-transceiver: Drop the gpio desc check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-4-1cc30715224c@nxp.com>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
In-Reply-To: <20250909-can-v6-0-1cc30715224c@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=1735;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/3/NVxy4+ravJJ72BLKZ+T3BvDKv/86w6dSaeJCvsUQ=;
 b=UR33dEXI81c04vi3WsEbruttSLICTkTkV8EeznJGzVxw+8ndX6BaI4BhE6RwI9wM5bepio+9c
 ejXJmHFYN9YBbKr4bbEZqCrN9rFBWizPu4Tnd9Romb3KwXd6xLs2QSW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AMDPR04MB11583:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ef7b6b-aff8-446b-3dea-08ddef6372cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjF2NFdib3VEVFpnZ2s3SThoMUZ1aU8zUGwwM2dLVGszWGpWMGU2YnZJdU1J?=
 =?utf-8?B?TUx5NndKMmNtektpUVF0emlTV2xUd05seklZdWNLaExLSXRkMGtXa3BzNFAr?=
 =?utf-8?B?elFpWGJBQlA5QXY4RHR4RElLSGFEMkFndWtUNFY1Y1c0Z1N4VC9kWFNTbzR2?=
 =?utf-8?B?eXhaRUZyZTlJVSsrVldlR0xwSHJDNTkrRVprYWt0Z1BJTVp2Nit4Z1FjSi8w?=
 =?utf-8?B?ZENtb0x1RWd2NkQrcWhrNzFXQk44ZEJqVHY1YXFIK2ZETWJMWmpuMTNocVlq?=
 =?utf-8?B?eGxmNEkyeE51UWNqSTZNaGxxVlhxYXFQTEd4M0JQTE56a0RYdFpwVXJyK2I1?=
 =?utf-8?B?V01NbDlFYlFiaEgvQkJMeEYzZTIwbktESSsvWXNDajBmTjlXdllQTUFGQjZF?=
 =?utf-8?B?Vy9lQTVJSVJ4czU1WmlwQTFPeWxCNGVsbnZGQ1lOcXUySG42QmdsdzJVOUJH?=
 =?utf-8?B?aUk5Vyt1OXY3RW5aRUkvR01HSHYvQnJUaXJWdmdJRnc3aEFETjN0SmtPY0RN?=
 =?utf-8?B?NVFMSGdjMWJZSER1Ty8yaDJhcDVOblMvYkJ1cnY0MVpsZVp4Y3F1SUo1c0xR?=
 =?utf-8?B?Y0xYaWN2eVJQSDkxQ3VIcHZYaVp6S1BGdnJHSkZRdXBxZ2lNTTZ5Q0hTUFFK?=
 =?utf-8?B?THVrejg5bjZxc01ML3REU2FrYUFsd2N2OGx5NjRRWG81L3JVcmIzcm9KU2hX?=
 =?utf-8?B?VmdrS1FNL1lZN2ZNeXJGb24vQjVqdngrRzNuMG1pY1NHcmo1U05sb096RWdZ?=
 =?utf-8?B?TmNmVU9jbDNQSVNRTldqWkc2eVpwUm9GUEU5a0tVWWQ1dnI0RDk4elFrSTk2?=
 =?utf-8?B?QnNWV29OUUc1SUt1TFczRDF2RWptaVhnSDAxSUJrcE9YazM4WENya1llMXdD?=
 =?utf-8?B?d2NyNEpNVU42ZkNBTEZvT3BCa2JMUzk3dVZjWWlqSGtmOVN1NW1PUUtPMHp0?=
 =?utf-8?B?M2hNRGJoSFJYNlViZjJQME1SajVDNUV1ekkvZ2pwa050bWZ6QTYwaUFmVnJ3?=
 =?utf-8?B?UnZ3dWp4SUVQbnViOThWU1dFbWhtVzAzSDFtV2w4QTdMVlA4S1U0SERyRjA2?=
 =?utf-8?B?eVhGYmMvelduWkJ0MjJHQm0wQ0kxemNVbWJvVi9LUndxNzFHbWI5UlBrbENn?=
 =?utf-8?B?MU95dWtVRC9ob1NaTDc0eFRlUVZWYnd5VDZ4SGo4QTBaRWZXV05laHU0ZGd2?=
 =?utf-8?B?SDdybjVCL09zU3pVMDBaVGVMZS9tTHRLRXMwZDc2clp4UFBkZldPWjNWcCtU?=
 =?utf-8?B?VlFONWY2OTNDSHFacHU0QWJWQmFDeXBUWU43cVBqa0hkVTNzUi9oM0R5Q0Rx?=
 =?utf-8?B?ODlLdW1PRGxhZXQwZnZENTU5cDlGNm41aFpCSGlKZzhFVnIzbHJnam01THBK?=
 =?utf-8?B?Yld0TXR5bmZ4bW42ZkZtL3VGOXRpVHlMa1Bsc05MS2NHVUNaT0xJUGVibkNR?=
 =?utf-8?B?MjVCOGZRa01haE01NDMzSzJpOWp4bDJhTVFPMjVCZDBIaGlqU0FDa0sreFNw?=
 =?utf-8?B?TTJYOTVGMmpDN25hRFc4R2lKaDhnMS9hTnpCU1NIYUFYcnJwcnE1cEtYYkF6?=
 =?utf-8?B?L3BRNEtZdnBqTWlxV3ZGMHhyZjEwclFjTlpubWJ0TWNpZ0gzZXRwc3hsTnpy?=
 =?utf-8?B?UmhqREVOams3Z2p0RTRyOEgvZ3JQbWZXbGtUV0U5RnJUU1Frd000Qm12aXoz?=
 =?utf-8?B?enpLMHFTcktkQ01zZEplMG91eGRRWDIvMWhXRHAzY1dicVRsNDBycmptd3Jm?=
 =?utf-8?B?cUdJQVR2eEJwNHVqT2JEa3AvRldQakJFZHhUZ1dTZDhQbHEwQUduRDMrNG9n?=
 =?utf-8?B?M2VybDEwS2lEM3BURkVxMDJ0L2F0MXdpWVM3TjBoaXU1dDVWMjVXNCtkNnQz?=
 =?utf-8?B?bGc2SXRNTGd6aXp5N3JRZkpQNGs3VXF1b3F1MkdSUkJZVmUrZVZRYjd6cUdl?=
 =?utf-8?B?OG5ia25IRmNtMXNFamFwczhVNXNFZXZ6TytoeXhFY0dpR3YyeHFBTXNoeHBD?=
 =?utf-8?Q?pi+OpkQfPC/3KekMe+J6DdXNqCgqz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFdYcjJmZlF4VWt4bUNsWTJ1SGtQbkNrUnRKWjNpbno2cWZlWnJyQWU1R2xm?=
 =?utf-8?B?eHlvNTlwM2RpS0NxckRuSUlNdWhnb1doODBRRWZEVUdac2x1dElBQ29PZTBC?=
 =?utf-8?B?clhuaG1iRkljVzlPdmlBNFFpNzUrT0dKcGFLM05tMDJqNENnZnZ4QjlZaVdr?=
 =?utf-8?B?Vnh6Rkl1N0hYRnl0R1FaNGJxeTRwWU9QdzJEZXN1bUVWZ3k3ZDZiWlltbXIv?=
 =?utf-8?B?NGoxdXpTTkZSRkxMU21rd1dpQ3QweHBUSk9yNmhCdk95YU1IZXorVm55ZTVX?=
 =?utf-8?B?b3FGb3RCMFdMdkV4V1VWWmxaVzU3QnUrMGF2dEVBTXBFUFUvWFZ5emNQMC9C?=
 =?utf-8?B?bThoOVk4eXI3eDV3QkFSZE1XUHlURGJDL2JHWTFiYzMvUWhKNkFyaXNRajZE?=
 =?utf-8?B?a2haYTkwWHFDdmFGTFI3cW9ITjA2N1JEVlhNS3ZrUkdhS3JvdHk0SDYrT1Br?=
 =?utf-8?B?QmdzSi9VbWNMUm04QjljWjNTMlFHQWdMdHNGL3IzeFBVcS9lT0ZwNDdicUts?=
 =?utf-8?B?QnVqUFVJU05xTENMcGo4SzZSaUV5dFFNeDFxYWhwNjVMU05VNWhxMUJXaUZD?=
 =?utf-8?B?SVhmVGowS3Q0YnJVckY1bE5oUzZmaFgrWlJ2TUptN2IybVRxUlIyZjRYT3Br?=
 =?utf-8?B?RXlBOTY4dGtJeEZ3eEwwTThkQzR4TDZIOU9aaG9kOW54d0I5b2VUMHNuWFR6?=
 =?utf-8?B?Um9iaDNLTnNQc1B5b0RCNURKMnV5RGlpTS8wZGhWbUEzMjV0R1lpeGMzOHdU?=
 =?utf-8?B?SlJYQ1NJSnJaZXJ4UGVNNGlwWTJISzNqOWZVWkpkK1pxRmNEV3lNZFBWdzZU?=
 =?utf-8?B?enNGSi9oOHFzbTg5KzRmZjhnZWFjQ205V1FOYUF3ek90aGZCK3JrMDZxdTJK?=
 =?utf-8?B?R21QUFVqUml3RmpyRHBnc2Z5TENra0RrdHJBTU5TdjA1THZuR2FRa1R0ZnZF?=
 =?utf-8?B?NUo4alk3clBncmVnVGdCcHR0OFQwOWNrZEQ5UllESjBUTDlWOGlWZEoxOUR5?=
 =?utf-8?B?b29pY1BqcXlTOVlyenhMQ0h3TUJjWW8xekEvaHNuekhBelZ1V1NGcDFqNzZO?=
 =?utf-8?B?QmoybnZLeGJGTmlYRlVNZXBRbHEyYjQ4cHdBR04xUzFPQkd0Zy9UWW4rdzha?=
 =?utf-8?B?UFdmZWtMMkdHYU41K2R0NTFTM0VoMGdqRTluT09OUzg0Mm9LM3RRWTZUYkVH?=
 =?utf-8?B?Q0pwUEJEbk84NzhraUM0aW5Rc3pudFlqS01sVThwY25UOHhFNkdUN0toelJk?=
 =?utf-8?B?NnpHS3JqbDcwcGxNRlZLZW1UWEkwVjBXcnd5WmY3aGx2QjdmOW53SWFkRk15?=
 =?utf-8?B?Q1RnTzA2OUk5clp0TFhWcFlVS2Vwa2tXMVZqd2tCajNURG9qUnl0VEdQeXVU?=
 =?utf-8?B?MVBlZHlnck5nZjdwbGdKWEl1RGF5cldoRm9JYUZnODI3MzA2RGY3MW1GMS8z?=
 =?utf-8?B?N1BNblIvZTFvV1VydGJGSDdOMmFXcXROeEorTWRLcXY5bHZaRjEvc1d6c0p0?=
 =?utf-8?B?NGFoQzFMUUpEODFjZUpJN25KckUvRDU4cGhldUNQSFZ2UXVmczhPRDZUTFlv?=
 =?utf-8?B?NXR6bFJnMFJkSGJLL0llWlE0WmNXenBSblNkVXBoNGJwR1MrSFpvWW5iZDNu?=
 =?utf-8?B?bDVlSjVzWlZNaEJqWEcyTWdJTjBiTnB0eXkzbmdiNlNIU0ZtV05LY29JcXJK?=
 =?utf-8?B?RTh2ZE5CazM2VEw0a1daV2N5MzZ4TFBmQWY0dUJNY1NiYk1XQkNybXNKMEU1?=
 =?utf-8?B?bnZKRUJzeTYycC9oK0JLanExWUpGN01YUEVvOFZhN3dWcTVheE0rd1lWYk9i?=
 =?utf-8?B?RUNUUVlqTTVYako0SXh1Y001aEJIVGY2QW0zR3AxUWoxK2l6c1RZNjdZa1Qy?=
 =?utf-8?B?UEhid05zUTVsdzN3c1ZJSUVLTHlPTy9zdzRLSGx5amdibFI0T0c3cmE3Qmk5?=
 =?utf-8?B?bjZQZ016WmNIVkpEYVVUVEhTNEVxZ1M2Q3l4OGhCQU11OWY3TnJkVWJJZ2p4?=
 =?utf-8?B?TmFtMG1BM0hEQjJBSkJraGtQSnBVRHpqeUIxbWZEYklEbkdkTlVvNXk5Y3VI?=
 =?utf-8?B?RVlxNHo0NVF1YjdYdkVYVk0wZW52T3FMcVFKQXBOcUdhK2o2a2pPc1VlbWVJ?=
 =?utf-8?Q?DY2+SAUfZC382a/zsHkjDF48u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ef7b6b-aff8-446b-3dea-08ddef6372cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:40:56.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD4j35/Otfw8esJ+Dupt+GvRwCWoHxoTALHsaPomDeYwR+e3EeDr8kS8NVHM4zEM0Z/DQwfpmHgHJxoGPltLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

gpiod_set_value_cansleep has an internal check on gpio_desc using
'VALIDATE_DESC(desc)', the check before invoking gpiod_set_value_cansleep
could be removed.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f06b1df76ada023f432dce892c3346f45397ab54..b7d75a78d9242e2003660a87d2d4c9f784aea523 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -46,10 +46,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 			return ret;
 		}
 	}
-	if (can_transceiver_phy->standby_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
-	if (can_transceiver_phy->enable_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
+	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
+	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
 
 	return 0;
 }
@@ -59,10 +57,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 {
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 
-	if (can_transceiver_phy->standby_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
-	if (can_transceiver_phy->enable_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
+	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
+	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
 	if (can_transceiver_phy->priv->mux_state)
 		mux_state_deselect(can_transceiver_phy->priv->mux_state);
 

-- 
2.37.1


