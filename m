Return-Path: <linux-can+bounces-5081-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76FBB07A4
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748F419469A2
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1D2F1FDB;
	Wed,  1 Oct 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rym6Xxf2"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261082F0C60;
	Wed,  1 Oct 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324986; cv=fail; b=psReWlkT+5NvFMCF96rw2b+a0dLw0SRWqCpdXC6XeXt+K0ZBj1AFNTR3Z8MQJJh+c8ybGTpv7HERSsWQZXxdfLLtxS+hnE2KqSPC5Ah81BOtM+LRRdMemKRO5/aN0VuA6TmD235sws5q0SqX8WzvgnIsoo+7cRDfPL2apxQP3ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324986; c=relaxed/simple;
	bh=NjJQ49c51mjuGfQ2+WLTvqtXNZNcrw7I5aaAWrUEI9c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AKy7JwCAPvvga3/s2KzpaGr7DxEp1ZClvzyrhLPG4bix1ndj8Sev78vuaBsiLGzKowXOmEEZDVZha3p+Pwr+G2+GFoxEViyY6JfTP+p0g3AWvTrQRwu0TqDAnCYSn4JVV8oG4rU5wiRbZtvNf7jc6kdBC0yBkUEMz4W7jRmajP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rym6Xxf2; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWUvN5BJzjGXN4V45ZJ/6AQJqjiehiwGMrBHs6/7CfUacn9OWRDIeeKvQ33dhxc1uERI+ZQuuEpEqKGn+3oQRqM3nYvEo9DEoPLCwb0HC+kLADl4isg6+Xo/x85WV/UysA+j6HAmiE6JzfIvb2ZJf5yA8StoXXcE6LvoIk+BjJbdpxzHkK+AL/SMXgCU8aIw1q19YpCcGPL+4WriKusYBy5fXCDmpCPHOI6crKqZYcYt2jmJYiudJyRcojcioDgx07NNHSBc9J5ryt6080xifYEBs7y3Q0R8rqhjnmo5AlSAG+IjdgU6e41wC3GVHjHlZdHA3hNoZxgA1OkfIgSraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7yHRQZFq/26Dfn70Rs9CmEeDIlzo8fb8RRMbLLw7tw=;
 b=G2TXaPiIdB+Q5rjJKAJxTE0BHZno+2eNGoj/bZE4qxKGQwjm9LX9bDljwsPv1vz+OPAdyJprqgDXXykP1eZkaocp4rkYBrygbLiu/Ayrt8bx95JDy3BPjbuU1xi7OHuxWhVCPKoZ96Ra+BMYljTJbAoUYkgkF8E5tyo5I0WmpFd6JvipAGkkzcu7UBHwlMNQcactIMGm2Ig8WAqR94a2dhfhc+7SibnzUW8RIVgy4xow0CDlde+KRWmlev/wPUySlGrSIGhaeFWgxg8q7IVeYZfQrpqVi1HDAXTR6m3lK+49zwCgfhBdSjl6hUGmxJ1RBaypY9zTinQUSd2HZi/yyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7yHRQZFq/26Dfn70Rs9CmEeDIlzo8fb8RRMbLLw7tw=;
 b=Rym6Xxf2TWuEhjcPogH2BbzdphhN+FqJt/rLp2X1TxAMjys0ocgDE0OZcNiWQjz35Au47ph0++NOK3TtWK061izZ6580jN19UQS5bML/wTDbcb0J6rkEyRQrCaZXWMal2KlpGLO6mbSnUaEA6/s0kWIGfzzgg4o/RN0PVMYXlVEng8rGoKgqmnq5X8FRCvf3YrPuwWcsimy3X9tXhOFds8iUrfjCMzTa99ojOQGaALWFliAvDk4/Q6Q/BXItFwglLI0QzJ455Y0bHKROxnMVuGYVwbv29+i6f/dSCa5FSQzbaQmuU9l7sRT+oBH+HSK4Q3zGPfIvGybQh0mHaCCTjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 13:23:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:23:00 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 Oct 2025 21:22:32 +0800
Subject: [PATCH v7 1/8] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-can-v7-1-fad29efc3884@nxp.com>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=2956;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NjJQ49c51mjuGfQ2+WLTvqtXNZNcrw7I5aaAWrUEI9c=;
 b=F6opmY0hcl/LBJzfY6l6mFa+TCMT2J84skpbaYopkBnZTD/N+8czqYnoViAFanm6Codrhqk0w
 OhRah4GhEe+DOU/jMj47c6dq7xlZwJqluULfG1qzXGWFJk34wUkdxl9
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: a2067ab3-df8f-4854-91ec-08de00eda461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXJYQ0Y4U2lLeFVsNE56V0UxbkpnSitVZTAwRnVOelh2UDFzS2w3NGFXMjVE?=
 =?utf-8?B?ajQwdG5mTG0xclpENEt0YWc4Yzl5VU5MZ3N1RkhMMkpNeU50Y05peVdsNGZD?=
 =?utf-8?B?U1phaUYrd3VxS0tVbExrVVpDYzA0djY3bStZdUs4NGhvOFV4VWp1TUxPL3hi?=
 =?utf-8?B?VUlQUGVrdUdnZFdISC9ZNjVYc2dPQnBrYUU2WDMrWWVCR2QzM2xTZUIwekxZ?=
 =?utf-8?B?dUhZL1F6VmU3VWUydmNqd1hGMEFkWU1iTEE3ZytjLzhqalFJMm5MZi9RTm00?=
 =?utf-8?B?dkNKWU5IbFUyTGJZZlEvNVkwTVdnSWR0dUNBVmV6amN2ZVRjaDlSL0c5bjdw?=
 =?utf-8?B?elprUStOQ0Q5Vnl1a3JKUzZnTlhmajNsZWFSUVo2OFNrMHgxWENRakpoZnAz?=
 =?utf-8?B?Mk50RkJLS3FDSmUxbEpFYjdnNHp6Sk83UzlQTVpqbFIrbTF4L0N1OFFGbzZE?=
 =?utf-8?B?dXBZOXdodmNIdWFKdGx5aWhHN3QzeFNja0liSnF5NzY5U3cvWkdjRk4zbTB5?=
 =?utf-8?B?YURGNzFpZm5iZ0VjeHJFNU1Da01ab2R1RE5SUUhyMTFOTVpkSmtPRDNlaUFa?=
 =?utf-8?B?ektPU0xTRkJWd3dRNDg2OE1vZUJYOCtoL3NweXV6dEt3RVlNbS9ZK1pMdmdh?=
 =?utf-8?B?Uk84UEVOYk54UVdCTDhwT0Rkd01OZ0NJQlhXZS9wcnB2VnhiTTlSOXVXSUht?=
 =?utf-8?B?alZ0dGxDQ3RNcXpoZzBVTURRSWFJd3VZcnA3bjd4MXUxSGF6Rjl4L2RNL0ZI?=
 =?utf-8?B?T2lhVHg4a3dyL1ZvdjVITzYvTG9Tc1QrQkUwelRHWWV6RHRiOS9kR2dxUHhv?=
 =?utf-8?B?YWtWYTRBYWo5cnZXaUZ3aEYwVi9LUUFiZW9kSzRWa1VVeDNPdzNIakt1bkR2?=
 =?utf-8?B?QmdnWCtORXU0a3ArK0ZUcjc2MHRPOFo3N1hjRUZvZGNncy9yU3hmQmFsUHp5?=
 =?utf-8?B?NzNSeVE1c2hPMk9RODkxcnZVeDlRZnNtR05OVGlzSzNZYXM1MHM1Z0RJTXhV?=
 =?utf-8?B?RUQzVDA4ODhkQnkveXI1Z2x4OHpFRmJHRStVN0lQM2Y0WHpJeGZrUHk4UGxP?=
 =?utf-8?B?Z3kvTk1SSE9RaDVkQ2t5N001SVJlSURKYWUxbm91ZkkyeElIRTR0QUxDb05C?=
 =?utf-8?B?VU5vNFJVc2ZaNyt2elV1MzNuL3lPVCs5c243SDFzZ0g3Mlc1U0RnU2ZMeGw4?=
 =?utf-8?B?ZSt1Nk51QlZkMll3OWtXY0ZrRGhzOXR5aEhUYlJDYTRQMDA2bXJmamVpa3FM?=
 =?utf-8?B?UmhNMGFHNzNOczZDM2NYZFNZMzdHMStYODA4QlB4eG9mMVJNTWpLSW9LOWcw?=
 =?utf-8?B?bGdYb3krdGNEUWZCdzMvN1REeTUydlIrbkJwOEhDSzRZTGFwSHhuNkt0Q2NO?=
 =?utf-8?B?Qzd0STl3R05Qb0FvVEZ5REFxYTJQK3p5R2RhK0NvYjB0ZUZ1SmgzREltajVY?=
 =?utf-8?B?Ly9zWU13czJqRjUxZ2MwMHF4b0l3czdOTlpoaWdJZ0tzTEJmRzJlbUNoYzlW?=
 =?utf-8?B?NVFxZitYYzhxRmNyWGloTmhjOFdDSm5NWVQ4OUI3bHRhdXpna3IyeGdKNEhF?=
 =?utf-8?B?dkM0eVp1VnBDTTFrbERaYk9SNWFkWGRQZVRoRloxY293ajhNQlJobm5ISjcz?=
 =?utf-8?B?V054SGJUdXVQMmZSRUQ5amFWNitKNGQxNDRJOW03NGR5WFNDRGhMNmpjUXFz?=
 =?utf-8?B?QTVnNWNUQk9kUEdablBlOFVYMkdwSkJCeVJPODRzSDZxQVNwM2hwd0tzUTJN?=
 =?utf-8?B?blk2aWUvOURZdlZSdmlqbFdzdSsxWXJwU1hvbU5wd01QTFI4TG4yVFFRQkFq?=
 =?utf-8?B?NitqOGdQQm9EclVIWEVVRlZNNkxEWnJnT3pCb3M0dWFaWnkxYVdqNVVqSklK?=
 =?utf-8?B?MHdUUlZGbmhVUkNlNElWc3BWS3ZCaXRaeUkzWFBZYlZ2Z0s0enNreUV0cWVj?=
 =?utf-8?B?NXVCT2lNNEQ2QUNPdmVXZ1htVFdRdmZ2eGdxVVl2YmdVQlcrSkFoV0ZsY3o1?=
 =?utf-8?B?MnQvakp0bDIwMzhIRnZlYmNHeTZ3bEFUK05sZ25TQzhodVJzNnZQMUY3aEU2?=
 =?utf-8?B?VERvd0hhWjA5Mml2Qy83RisxZUhqMDJYTUduQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEs0cnhZMFNKV2Q2N3VBVzdNSFZDcllCZkhnazh1MXdnaE9WYXVVeUk0ZFFm?=
 =?utf-8?B?ZkhhaHVtZ0ZNbWtuQTF3Zm5GclAraE5ucWo3cEsyUDY0Zk8vZjZJYlEvUXJU?=
 =?utf-8?B?dC9CMDA3UG54U2FXcXZGVXFxZi91d2d0eWhoNVZRbk1oMHNiOWw1TEZnMGZa?=
 =?utf-8?B?Q0djR3gwVy94bDFLdTdTRUViVm9XblJsZ3k0Wk9pYXhHbytOMWc4Sm5vclk0?=
 =?utf-8?B?bEhVWW9YVzJ5NkFDQzN1Z1djU28wMWpRVlJuaUYrd09DQ3ByUCtmK1ovWk9i?=
 =?utf-8?B?NGo3dmZnTThMVjJsRWxUY2VXSzZpbXJvV21UZzVWeFRKaG1kaXl1YzAvUFRN?=
 =?utf-8?B?ZytRUWJGcGptNTlaMHJ3UDZ6UXZ2RnVxZFI5M2Q5RnBIUktFZVEyTDhiOG4z?=
 =?utf-8?B?YWZDWjJUNWNCYVhtOUpuOGlSZVNVOUxxMTB5cnN5LzIwUWlqbHFzQlNCSzBh?=
 =?utf-8?B?ZmUya2xXcGFXRFdlTjJGbnI0MGNCL2xPNnZzMDZYeEk4QWgzbDQzWWhoRVdk?=
 =?utf-8?B?VUljWU5RTnhCMEVaUTVRbXlDRFZudWtHODFzZ01hVkVKekZ2RHFlQ1dPSEkw?=
 =?utf-8?B?U1R4Z3RLb3QrRStaMk1Ic1l6c3F6Nml4NHpYY0habnN6UklQUWMrblFoVU5T?=
 =?utf-8?B?QllSemNCSzQydnA3SkVNYXE0UWMyMHBrbEtaZWVnc2RQVFB6TjVMS3NFNzhI?=
 =?utf-8?B?RXRUcVJWSG9udEtTUG9SNU51SitPSllxbHFWZTJlNE1BYTIxWHFkN0dvcEZ0?=
 =?utf-8?B?T2kwVS92L0J5Vjc5eVAxaVhUbk94MGR1QTZldmc2Q0g4bkN1bXFRRC9MS2RJ?=
 =?utf-8?B?a0V5RGlqSlFGQXhtV1lNTVprM2pKbGprdVB1Rm9hd29nNnJzZlcwM0p5a21o?=
 =?utf-8?B?MnlUbEdPa0lrQTUwdU5la1I5SDA4OFJsWlAwd3k4cU13YTI5QnpMVi8yYnNG?=
 =?utf-8?B?OThNNENtWmhPT0xvT05qYkZuanM5ZlU5cld4Q0VDd3lIeWlVcFVlZklSQnZr?=
 =?utf-8?B?R1RFRituczBsUTZkMTFWSHNqYVI2WDNsU0ltSnNPeVFTRlR0aHk4Q0t1OE1V?=
 =?utf-8?B?MGdWUzMreTVML3ZaRWkyOTd6Tk5IT25MS1IyZVRabDZsMzZhL0tQUjJ5ZjVO?=
 =?utf-8?B?TmlVYkRUb3dlNjk0ZTN5WnQ1anhYb25qSlBIc0l2TUVMdjNHSVJENGdveTJ5?=
 =?utf-8?B?Ti95aUkxaXEvMlJtaXZZSWRMTVVGWW84Rmpla2RrM3JYMlp1VC9QMjNCWVhX?=
 =?utf-8?B?VlBsRW9YK0VZYXZUUnY4ekkvYnJFenQxQXppYTRSNEpwNklnK1V6OUFBZ1FW?=
 =?utf-8?B?RFhBQWJyTi8waDB3amFlb2hiSlhpdzUvU2dMMWxjTTZqTjVwcGxCek9pUmtw?=
 =?utf-8?B?QnhnZmY1OUpvdVdLWDFsUlZxbzBBeWdqZHJDQkcvSjdsamhlckMyUlMyUXgr?=
 =?utf-8?B?bC9JakxoZXVOTzhMMUI4U3ZmWUtxQVpFVy92R3dEYzhrZ29kZFpqaFlub3pk?=
 =?utf-8?B?S2NBM1RreW1FZUdCd2NUeitsU2JiV2xIYTNGcFhNNVFuYUU3eW9uZzhWMGFF?=
 =?utf-8?B?OHF2R05adVJXalFtVUs2bWgwcVJXSk9OMnRKdEI0MTFKSVAxYjdSVm5ER2VJ?=
 =?utf-8?B?TUdSZjhaMW5wYXhncTQ2RzFDUy9VRnY3VkhYaTdnMG5mY21XTlFDcmpuRnZD?=
 =?utf-8?B?dDRLdkVoRXlQUVE1Rm1WY1JlTythc2Nua0dTMVpJUWFBQzZqTmdvNEp4aEFv?=
 =?utf-8?B?Mkh0RWdxY2p6SFdWenBaRnI4T0FyT0NqN3F5VWFTSk9LTEw1V2Nwb3pDSStM?=
 =?utf-8?B?TEc5K0FUVVNkOFFHMTFKTUFTZFVQOFFMMThuQU9hK3dveGUxRGxzTnk1Umhr?=
 =?utf-8?B?dW9ZY05LMmJBYWRJemJEMDAvVVduTGZTS1BGUnh2eUhPbUtwWkNiWFh1QUlZ?=
 =?utf-8?B?UHJDR0xjL3ZVcE5VWGJ0RUVhbEorTjNUYVduQ05XVnBYOUJoT3pTQ2RheEw4?=
 =?utf-8?B?Rzl1RGQzWFp4UmplQVFPbU9HeTNqclBoZHdiOGZZd0tMMlpyOERoNWlLU0Rn?=
 =?utf-8?B?V2xoV0Ruc0I2V29KeTVjSXpqZitaejBvdERvVWc4RlVuUEM3QzB1dEZOcVor?=
 =?utf-8?Q?AcUGp3UvhxQWdHWr5KoaqmHDI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2067ab3-df8f-4854-91ec-08de00eda461
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:23:00.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P96ob8K3oB++3iZVGz0GWFqU5lZikY5FAvYpTYfb9w/6uROrqbk7r6e2Q6u/LsADXYdZZRH+mkwf2saOHMs2mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227

The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported
and no EN pin.

The TJA1051 is a high-speed CAN transceiver with slient mode supported,
but only TJA1051T/E has EN pin. To make it simple, make enable-gpios as
optional for TJA1051.

The TJA1057 is a high-speed CAN transceiver with slient mode supported
and no EN pin.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 69 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 138923ffedfeeb6a0b391cae863723ec70bf2c88..c686d06f5f5619552bf041c951e36b71cb68c2a0 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -23,16 +23,26 @@ properties:
       - enum:
           - ti,tcan1042
           - ti,tcan1043
+          - nxp,tja1048
+          - nxp,tja1051
+          - nxp,tja1057
           - nxp,tjr1443
 
   '#phy-cells':
-    const: 0
+    enum: [0, 1]
 
-  standby-gpios:
+  silent-gpios:
     description:
-      gpio node to toggle standby signal on transceiver
+      gpio node to toggle silent signal on transceiver
     maxItems: 1
 
+  standby-gpios:
+    description:
+      gpio node to toggle standby signal on transceiver. For two Items, item 1
+      is for stbn1, item 2 is for stbn2.
+    minItems: 1
+    maxItems: 2
+
   enable-gpios:
     description:
       gpio node to toggle enable signal on transceiver
@@ -54,6 +64,59 @@ required:
   - compatible
   - '#phy-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - nxp,tjr1443
+            - ti,tcan1042
+            - ti,tcan1043
+    then:
+      properties:
+        '#phy-cells':
+          const: 0
+        silent-gpios: false
+        standby-gpios:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1048
+    then:
+      properties:
+        '#phy-cells':
+          const: 1
+        enable-gpios: false
+        silent-gpios: false
+        standby-gpios:
+          minItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1051
+    then:
+      properties:
+        '#phy-cells':
+          const: 0
+        standby-gpios: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1057
+    then:
+      properties:
+        '#phy-cells':
+          const: 0
+        enable-gpios: false
+        standby-gpios: false
+
 additionalProperties: false
 
 examples:

-- 
2.37.1


