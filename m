Return-Path: <linux-can+bounces-2321-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 088659E34A5
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCC2285A7E
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71F1F6690;
	Wed,  4 Dec 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GPZtHaF8"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1E1F471E;
	Wed,  4 Dec 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298573; cv=fail; b=LnqNgu+fWpwAcO8JtZfYcct+3BT+f2GNv8ok9PLkC127VbADYyHIESA5/nRLucZDTBWompLxXTdfUGOhUEfBAKbeEso/ZoGR/J5dfbgj4XybCrlQbqSldXkFUuIPHPz9l+iAdKkCy3c7EZabMFjm0ywT80QubUR2cfAnlo9/zNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298573; c=relaxed/simple;
	bh=D/27Msja/lJBWRfcJFy3VjNENyNFL2o0U4+oVCpi7ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=neSsbWCjwHXml8ATQegZY9r4uu61TzRlxB8eygpzfZfjPGE/9aekCXxAPQJ2McI0nTp5IFuPAzaEClYKvl0SZ+emUQ6DMVR1L0Tp3+zPf9+b5g/dw7vmg47IYd2VP1XwGXrR2XZiBRPiNdbhE7C2lT2ttprS4iVgYkEke+DXcus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GPZtHaF8; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7t2hP9hCZgat0Md8h4QVirH8umd8dr0YXwRhHIQNWdT4ogX+dt1JJ12nkIe0wl6+shy/AnrUVjgTU+X0hR+nfT7X4cnBn6iPThSUmdA9kGY4O0sTdrizTDImt/F8sU5VGg7bMBAqVTojBpOhvqZRhnssQuPT3jHRO7qFvPHeGs5bKkQREuquLAd2hnEKiaqF6JeW+RxiuvjQKvo4ZJdTKw9QcgqAUgwwdGv1Fz6yRq/Secd/Qd0vmiDrmX75ozF/MsOa2FseiVq8cuWKJaYVSmYB40/BaroKPmlvY1iLA4HMoVWb+TvLeXrLX/5kfriv+z+TXytNtA/7L2Q2RYwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpZ3L6RcAnRf0eDx7wa22XwJ34ledo9Aicworoq88jQ=;
 b=wdDeIX/nSPjneg2WA5SAwaOe0dMjWzl/oVHIVTOxfQAN2z4oMW/t8QsgF0QrB10TGYXN4MXFQ/ugj4r9MAffGAKIyZAwnN6E9ldi+UKopSREUCf60z3QaGDfU5KpO4Zuv/b4T0Nkg9GikfBYCR5hZ8nBykugKq2wm/NutMN1++tUjbY2vqcvuXyIJmc3Ssiw1bjyEiqez4G+mZUQ2m7lP9IjgwHyVxUO3AzXUZ5tI8DpSkdY5YO8Evw7I7HstinwkH5uz+xxE1S1+R3vl82bUekL1FaTa3BHrb6Ezuikutrvj2JyM7XjTnF1Gdk9SBhHtLGdoTF6Lg+7/UlasDHl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpZ3L6RcAnRf0eDx7wa22XwJ34ledo9Aicworoq88jQ=;
 b=GPZtHaF8BHsiEWnInX98bsuRT+IldufzvFk6uQPAmOYQYx8+6b/53YCuTESDtq+rNadAwBsefx42zG6nan7G7zZe4xm5Zd4yQ6y4rBc3x/AkcFKfRJCowy4Lb9t35QcA+PU3oomxVmi7AoCoscsboxNzdTiKkRZlGJ3poMiGNA93bPlkbSWbMgruotQLY1FG9O0K7wu7B+CUnmL2XyBc+l0SuOM+p57b1oAnxpzXFwSiLKaVdJ46IGmGlHxuiCUOUIhpaK6W2jD5saO1bvIpN7HZqGKEqMoArb3yiNIED4mN7s4/P27udUAuE4zuwFbF3aK7vOX0CS+XmW5aV+9cfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB10769.eurprd04.prod.outlook.com (2603:10a6:102:488::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 07:49:23 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 07:49:23 +0000
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
Subject: [PATCH v4 2/3] can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
Date: Wed,  4 Dec 2024 09:49:14 +0200
Message-ID: <20241204074916.880466-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::18) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB10769:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a610a8-6bae-4b4d-1b23-08dd14382b57
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFIwcnQzNHIzbHlLenV0YVVYZDU5b21TSXdza0Q3WFNkU1lEcTRkZ3ZmTmdY?=
 =?utf-8?B?Y1lNSTBVWDdpRzIzQ1YvSUFlSzFSZG15eEdIcU9OQjAwNGY3TEI5ZUtDUjNS?=
 =?utf-8?B?Y2t3WTRaSExlTnlBaVowcG9BOTFKYkRGS05EN1hIazh3SGVZeENKNVZBUEli?=
 =?utf-8?B?bkNiMzVoTTI1bVJEeGJwQ2djNW1iczNSWXUyN1pLamlLa1lPSFR5MnY3L29S?=
 =?utf-8?B?VExIa1BFNDJSM0JuZGJyL0gwTU1GK2hYZEFJZEZiazBCZmpydVkyNzBaU09N?=
 =?utf-8?B?YUVpUFRlajFCSVRLaXhXNjFGdm5KeHI1U3llaktVY2p2b3VVSWx5NzNocHZL?=
 =?utf-8?B?RjFOWkhZM3hSRUFTSVVjR3dkaUhTZlYzK09qMDBwQlBaQmdNU3BPczZRSVUy?=
 =?utf-8?B?STE2M21aTlRacnFyV3Q0eUxIaFcrcVh1ZUNVTEJKdFFndXBlQVFEVEVkQjB4?=
 =?utf-8?B?QU9teXBneDBYRjg0TVlrQjJESUtZY3AvWU1jN0VSbzJOMStabXJiaHVSWUts?=
 =?utf-8?B?eTIrLzhSb1N0WEZEZ3BDdmJqbVpBYjhNemlkcHVqZHdJS1RBTk51M1ZNZGtW?=
 =?utf-8?B?SHI3MW9QZDdBakV3cEpjdDF6QUZuUThTQjVXMVJ2NkZYdDBwbU51bmd0WjN1?=
 =?utf-8?B?N0FtU0FvdEN6K1QvN013QkVhY0p1NkhmY1dpOStRNjJOd0l3MUJFeVkrRkFs?=
 =?utf-8?B?WHdMc0RTWWNmYkhGUGNlSHUwVFNGdTZjUmx3bkUyLzZYejFIRFRxT3d3TzBq?=
 =?utf-8?B?RENPVHJjaHYwWkVUMmhiYlNPbnV1UDByS0h1aHBOOWNyU2lLQzRqbldHVE0r?=
 =?utf-8?B?SzFKeDNCL3dwVWFoUG1pNmZKMFpLdDBYTFJqbWlSMXVoNmJLdEZhbFh2QUJr?=
 =?utf-8?B?bGdLYW1MUys0UUJOVHU5UnR2S0xKcExkd2VUdXpvZUdZMllSQlJxSE1CQjRo?=
 =?utf-8?B?WG41WUVZNmlOenFHeUtzQ2RUSGNpeWZ1bzlsbkNyOUNER1NzYVFoZEppS2hy?=
 =?utf-8?B?cTF1RHZXUWlMbDNxRjJXSmlRYWFZL1dXdGZmY2Z4cEJPZjd2bDlEd0Q5Z0o3?=
 =?utf-8?B?VjBsVmFycXNaUnM0SUlUVytMSVIvclpBdGJIbHVJNUV1ZkFJemU1T3hxbmh6?=
 =?utf-8?B?WFJ6WmRkTEFaWkwwdDJjTUNIeVNqNzRlQXNPenRycU1UanJ0ckRlL05Jcnk5?=
 =?utf-8?B?dFhySTFPMGNQdm1nNVNlVnJXMWNjL3hIbXBxOEtodDgxTGl1bUpSWHdkT3U5?=
 =?utf-8?B?eWJCQWEvTFBUd3ozdFpPYnprRFduaGZBbkg4eUkzcnVvU3hCbXZiaHI4eXhv?=
 =?utf-8?B?a3FMOWpvMzBpelU3Ukk3TCs4enBiR096aWthTUo3OWhiWmRXNk9sWSs5QkZD?=
 =?utf-8?B?OEtEVHFGcWh0WFozL1paNDFpb1RCdkEwWnk3VUtCclZ0dlFJOUI3Y0N5WVJS?=
 =?utf-8?B?N2h5Z1EvazRBNVlJRStzcEp2dzdHNzhWV0YrbEJKUno0T1lvVWp1ZjhRQzFz?=
 =?utf-8?B?dzRsKzhlNXc4SE1WOEFJbGdNQjlwUFdiU2QyVTdzWXd6c1UyYXlzY0ZWZVli?=
 =?utf-8?B?Y1JJQVF1dFdDS3BVTEhkblBZV0wweXd4QXhQVy9qMUttZ1lBS21UbkhRR0ln?=
 =?utf-8?B?OGZ2T1VRYWNxREhocEw1bHJRcnRTVHIzNnVUUTl4VVNvdDdpY0hTay9GWUR2?=
 =?utf-8?B?QmRKZXZUUy9QY2NTNEcybEswQTczcE9SbjlpcXVTT1N0eGJXcHlPckxRVCts?=
 =?utf-8?B?cEwySmRHS0RJa3NpM3JHZUpmUnEwK0IzdWk5TDJWWk5HS1M4UWZHZlVvcUp0?=
 =?utf-8?B?ZDNaTWE2eExFK3JIMC83dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzUyT1Voa2gzbVpZUU1MNUFUejl1bHkxdnU3amw5djJBRFc0VEZrQ09uWnJi?=
 =?utf-8?B?VGFqM0hoS2krUkhLclVHekJqZnpGcGNVUVVidTRGUmhLT0pBVlhkL0lsdDc2?=
 =?utf-8?B?OHdxNjUrNmRqdDV1TTdndkFJMjkrR1NQWmtwOW8zY0FFMldxRWZ1V2tuOVR6?=
 =?utf-8?B?ZWNhT3hZb25RQ0VhY3VTMnBSMzg5d2xsK3RNLzVEbVI4dDUvZVZZcjIzUzdk?=
 =?utf-8?B?WDd6NURucWkvU0gyMnpUNWJ0U2NpM0VodW1lTjVnazhLRm1ueGhYczljNWhI?=
 =?utf-8?B?bXpTSFFIZit2OWxVNkw4L3FMU3c0eFR4OERGZHpOTEI3RnJiNUxqbERQekJT?=
 =?utf-8?B?TmFvQWE5S09pRlV2dlMwUHJ0Nkp3ZEtqQmlxUjl4UzlFdVhMTGxvaG90WnZM?=
 =?utf-8?B?L2RwVFRkVlRLR2d5Nm9iNjNxeHBhZlh0WjhqWHhQcTNvMCsvSVdWL3RVMERK?=
 =?utf-8?B?Z0tqRnp6VjIzSFVidkpBQ09KU3lJZHZUUllhV1Z0YzdkU3NDU0hMTC8vWmRN?=
 =?utf-8?B?YlVmTThVWVBScnBackgwbzMzL3VNWUxEWnA0WmdlUXFRSW9oSXBTVXNkdGJk?=
 =?utf-8?B?YXVIZ2RDaWF1eURHcCtJNUtvRXUwZ1hxOVZsb3RMcVBsakRpNzZZdXFOV0ZJ?=
 =?utf-8?B?d2piMlVGNEpCSndCVEhKSEFjREhyT0NvK2ZxUC9nY1VNMUFCQTljVzdMbURM?=
 =?utf-8?B?YWVldFZMYWJwUkNVcjdjbXAvVGJPdXJ4c1VHVjRMTjUyY0x6bng1OHZCV1Fo?=
 =?utf-8?B?YzZRbk9wNnlPaDNtZ3AyRGkxNW94VlVxNWZsVTE1OHZyMDMrNktUY2JDY3Yx?=
 =?utf-8?B?K05rNDFqdWRTekdYekdpQUFHQmhIb1pWQ0VsaTVXVXVJU1lsK0I1OFpZZFpm?=
 =?utf-8?B?VndVV3lrNk1FSHZIaGVKajdWaUxham1ncFBjU3BZaVZTM3A1VVZDbVd3RmlP?=
 =?utf-8?B?MHo1enVQVFUxa2JXNmd5SmhyTUJIdlRIVjRheTZJTlQzdGRrQVA2Q04wc0Jo?=
 =?utf-8?B?eWlCV1ZWNjdIOFFMWTd1ZmRsbE9URUx1ak01K0FkWWFPVE85M1BXRjJsOXJo?=
 =?utf-8?B?d05Yb1FwRzdoUVBUZXAyQnJ4VTlBdWw4VW0waVhNRTk0TytMVVNPc0FCa2d0?=
 =?utf-8?B?bHFLdnJhV21aUk9mOE12dGxZMURXdHZDWStFT2xOU0lycVVraFJ5Tjc5SWp5?=
 =?utf-8?B?b1hmSU0rV1ZpWkk4TVkwVmxtVWFsU1JTdVZ2SDJ1Y1NTT3VwU3pIMzlWV3du?=
 =?utf-8?B?NllJdGJvYlJ5bk02dmFMaG5XTGFEMHpFaGFneE5zbXZ5UWVUU29HdVp2b1lt?=
 =?utf-8?B?ckhtbURLZktaeHAxbjVlS3VBNkZtdDRvaE9IWERFY2oyTi9pWUNyYUsrYmlx?=
 =?utf-8?B?aWY5N2pPR3ZEeERRQkxoRFlaWXJkQUFUVXMvUTBDWGZnU3YvWmV5ZkhFd2ZC?=
 =?utf-8?B?ZUVkb0hoNStZeVVpV2NKTFJsUU9Dd2NUOFhDbTFZU1hXS3lqeW0vcVk4N0Nq?=
 =?utf-8?B?Y005ZDVmZGRUc3plUnBKWDA0bkZFTHhOTDBjaGVEWXJxckd2emNTQ0plTEgr?=
 =?utf-8?B?ZXdTb3pIS2tSSnpUeFB1N0JpR3J6NDJldVBaS0pmeUlFeWY2UnVJaERuUG94?=
 =?utf-8?B?Nm5OKzRRSnlvUFQ0SW1oTkprQnd2dFN2Vm1YWGpLN2sxNkl4Y0IrRjV1b043?=
 =?utf-8?B?dzM0TDVOVGdRdjd4eVpkdGhvRTl6MXlLNUdyNmRnMjZ1L1RQWDhSdjkzWTVj?=
 =?utf-8?B?T2VKcGlianI2Y3lDdWZjVCtxdXp0SjRmZnJEek1RU3JubnlBR3FybG13WTZs?=
 =?utf-8?B?bFViNGZWV0UzZG9qNkNRcnY1T0lCL3pMNjhiS2lHbWpoUmd0ZFpBQUdUcFZ1?=
 =?utf-8?B?UytpLy9TVWlyQ25MS010QWU3QWd6WDlZcndwYmd1V29jc21KdFRiQWx0azNU?=
 =?utf-8?B?QlRoWGZmemI3N1k5Smgza0VSVHFPeklCNjgxS3B2TFdtclZBRTZrSmZjVmNK?=
 =?utf-8?B?ZzdsQjN0ME4wL3VlcGNpUGtYUi9iMHJUVlBpVVBVbWpqTUt6cUlBRmQvV09i?=
 =?utf-8?B?eEpVWlhkbHI3aUZyOFQ4end2TmxjR3Bid0xNdXFHclJQYTZkOTNFcUdHampE?=
 =?utf-8?B?TjdxV01UNms4TEZqeHZUYXl4TjlOUEdPeFp6dHpoMHUrZVIvTWlzS09EUGF2?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a610a8-6bae-4b4d-1b23-08dd14382b57
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:49:23.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxOpABf5eZsqpik5w+jVQIXslgXfCwYEW4z2ORcANxXc6+eioEuxRXa3B/wsK/Xn06yNdDfvGrJghy6kToR6k8r3tt37CtwkrHQ7GktkkYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10769

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


