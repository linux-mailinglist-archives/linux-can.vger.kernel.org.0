Return-Path: <linux-can+bounces-2219-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E7D9D8A61
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622061628E3
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566001B4F0A;
	Mon, 25 Nov 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QgCbI0bZ"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4AA1B4F14;
	Mon, 25 Nov 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552336; cv=fail; b=SQ8te0+w+S0js6cRnuiEwzMXPgkRb2kI7f/AE3RtdFY4Jo/9P7l5Nlx8iRL3ZSgJB0l1sv8EHodQOx2WWzwtYvee2CK1+cHWvevACH3WVgt744xbWQ1BD1XoBJv9zCD7NB64AZY029E7LNwE8O23OKVZOCxUloYjui45GNlirVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552336; c=relaxed/simple;
	bh=cT2SNZZceLc0I6oInJaPuMW0b4czwCX3CYXK77AJEck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B13Uod8g8vfqle9J7r8RbpV3Fbhcu3qIUITKljptk6aT29s8yYa0SyFJNC4Gzt9vByEI312858f30/FiLbSLmPegZbWDq1doGY9XM28Q+ihgzhZAj6/r+wMRkSoJyNPqS/qP+B5V5PjG7mzSkFduk0MAmI9G4JSguiaqOUg8fYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QgCbI0bZ; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5zQZ6uGUuGJc1iHMinB3JSAUb4HNHGeYq+fLmdX5xqtPUUKqlWtvJ8XjnPddLXB5/5IwLH9Yz07J3XRg8FgKOhe23suSFCLydlsB/+TRcJGel8iba7ih5D8QQmFoKXcp+ivCbK/n5K/CqkhLRkwPUJ+ObxeejjkU8mhI4+s4l6+sMuaMNF1q89jMyjn4VlWS/lcHpIB9rAtJ+amPyHVHbOrnK8mN2fbTJJV8uqUKGsA35A8rthcXFnVKwBK1WMUXww2nG7JEzpgDvQ9hcqaKEMhJKbbXEW9e+zm1+rqBjd3ybTnupUlqFmucZvdqioxTwA5x/GzATgsSzta/SdPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaQy5kDXIKDq/HEQbAR/hWTrTuj8zjoDD+WCajGG4og=;
 b=a4z/keg4Tk8XCRC0lpdy1TxW+ct+W29FVlVrLPRhWg59T6DorTeE3s7vY+nHWGMpwVNvzTMmhEqWjw10Qr9hwUhVprohoy3T7oUHBSqe7jB+lyDSe254QacJdwFDCKQb4biq2XpTNIavibA2e9j6AxECKKdZgoPknhtN022/Hb9AyIyrcq9rTzuU8ponJGSktgVr3coHcE9UFmStzxcLCEgmp7kPa4J5oOxqFuIhkjf3Xx9gqVlE2UfaP+iRBNokdUA+gKMg3Oo4+cUt3byDFs1r3IJQiZU86xF9aSGxmnD8R9NdNVn5q+IjSAIWcPbHK6AV3i9wPhIIH/1buy1SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaQy5kDXIKDq/HEQbAR/hWTrTuj8zjoDD+WCajGG4og=;
 b=QgCbI0bZFigodnjMRbrrGbe22c3e2hqr6PKUb6++xS4ZahvVDzqgV2pSgntc3aIHP9PrKVuGtgHJagpqHhmDMpOpOqF28QocTl3eW//r37/34cCGtjuKOQwf2vukTg7y10wfseRA/MdvmWlY9ZOZBX4rZn3tLfbi+XnqB8HAXlZBuc+zExeNCIOE2K95BXMZ3/OpFKcRG0hDzugoR0H4T4D6iGOc0A6yxSPCgI6DJYMivKK7A+VbRJ8Op7lcEEVtQp7DrwdFq0KurKsoi3mPxBwPXYGfzKgzEROn7MN4a6pMjiSrUUIsSlatTeLtsDwPMO2WxTFgs8afs+KkytZfrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS1PR04MB9261.eurprd04.prod.outlook.com (2603:10a6:20b:4c7::13)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 16:31:10 +0000
Received: from AS1PR04MB9261.eurprd04.prod.outlook.com
 ([fe80::7b16:7596:6bb4:c5fb]) by AS1PR04MB9261.eurprd04.prod.outlook.com
 ([fe80::7b16:7596:6bb4:c5fb%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 16:31:10 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
Date: Mon, 25 Nov 2024 18:31:00 +0200
Message-ID: <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::19) To AS1PR04MB9261.eurprd04.prod.outlook.com
 (2603:10a6:20b:4c7::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9261:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd2cd64-00ce-4590-fed8-08dd0d6e915b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWhSVmhvREF1dm4ydHZoL2VtV1hadlNobDNrUU4vUGc0VVBhZmRIVnF1MjBm?=
 =?utf-8?B?Q0hENHNHTUFCWkQyVUJzSGU2ODdhVDNSWnFITkMzSzBOSGN2M0EvT21pTkQy?=
 =?utf-8?B?eDVLRE05VkIxbzdJUy9yQzQzYnJDeURBMVlkazJZQUNlOEFveUVCNDJxME5W?=
 =?utf-8?B?MUo4MGw2K3lhdDc5Tko4ajVWVU0zcU5EWVlEOGswM3NNTnNYV3ZCV2VTRUtv?=
 =?utf-8?B?eW9oM2ZreFluSW5nZDkzK1lQY0lPdXBtb0s3bEZkUlRqSUtzRkNMZCtTVkd2?=
 =?utf-8?B?a1RaaWVTcExmRi8zZTg1TGMvaHpkajVGTHpsbDBVQ3MxUWlkbjJaVlRKMkMz?=
 =?utf-8?B?WmxBemhES1I5Tm9TUmM0OExBT0dBZjhCdVg3eTdNbmlPZjFuSXRwaGlxMzBt?=
 =?utf-8?B?bE1FSnpFcG5VTi95TWt4bXMwL0FGOGRpdHNmWndJVjBFVXlJblp3Qk5PQjZ2?=
 =?utf-8?B?R3ZWQ1IvL0QxN0hpSTFwbDFyZVBacXNQeGg3a2pGcjBlRWpMc0thY09Ldm85?=
 =?utf-8?B?dXpaeFQ3ZXZFZDNTNEdER2plNDNYL0g3K1g4QkF1eUxvUG14TnhBMnQwZktW?=
 =?utf-8?B?dHFxdWZaN2x0NFhtcFNwQ3Q5QkdiMnhEZzNtSzFhejlpSFovUitqTVBRRXNl?=
 =?utf-8?B?eldjU0JJVnJiNTQzK2tvWTJPRHdadGVWbVZ6U2tNTHNRVy9jOTc1a2NVa3BX?=
 =?utf-8?B?MjVBeVJ4TVRpSURIR3hzUHFWdzFSV1hTblMvZ1puNjhrT0VXNUZ6cVZuMVRu?=
 =?utf-8?B?RkVFM2tDY1BMUGRiakNZc2I3OW5BUkJtSEJnZDlJNllyenFFYjRTelBNOHF1?=
 =?utf-8?B?SEJ6WTgxMUtFaTNNaGZSWUJQYTkzMFVjVFh1NzZLczQvVFFFMjBESEpCRlZE?=
 =?utf-8?B?UkVQbEpGOGdjbDFSQnpuRm9QM0Z0QWEwZ1RlSWt5RWZjeEhmSHF4VjBKT2F1?=
 =?utf-8?B?enNkdU9pdzcyZEJUMTFKUkduNnVtMTJFZDdJTmZnZWdGeStTRDN2Sm9EQ3U2?=
 =?utf-8?B?MnQrRitMTmNUM041NW1maTNiL1lRQUhnMTNYYUJGc3d3cThTTDJqYXkrRlA2?=
 =?utf-8?B?aDdiTW1DM2ZMckdGSzR1aHdvcXNRWFY1ak9La1lweWVsc2cwNXRhazY2dFQ4?=
 =?utf-8?B?Qk43WCttcHUwVUtRK2h6WXc0ZGxlNkRoT0FZQUZVQi9Kdm5LdDA1M0ZXdUo1?=
 =?utf-8?B?UWJWYjBHZ0Y5RDI2dkJhdkxqM0FrTkxGY2RXUHl5ZVpMU3JDZkN5MkZaam9Q?=
 =?utf-8?B?T0cvaW5EZDRBR2U0UVVVYlJiSWlUeEQ1OHFyNUpURU1XOVRsL3Aremc5ejAy?=
 =?utf-8?B?eXhFRDg3VHB1Y3ZFWTUvbUFjTER3K21MTUJxWkc3bE1NK3daeWdyODFsZ1dS?=
 =?utf-8?B?TWJNL1BwQlR4bk9aamcyK3BSajZkUjdtV1dlL1ByeEZGNmdqSlBLdWVsTHJS?=
 =?utf-8?B?aUhqd3BvZjlOdFRtN1hOcU5XcmpBV0VKQTA3dDhqb2lzTzlET0M4L0NlWUVY?=
 =?utf-8?B?WjNIdzdSMlhnSHIxTE9iZDNUVXlGc08zczZvVFdSNkRFMFJuSXZVeWFjYkJC?=
 =?utf-8?B?MlJGMkxoWklta2VaSXJ4Nmcwa1lKUTZNWHN3Z3Y3NDJjcUNTc0R5MkZha1Yy?=
 =?utf-8?B?YnVhN1ArbWVVVVEwWENGclZCaUhERFo0WExaT1pVaUJMV1o0aDNHTFFDUFlW?=
 =?utf-8?B?MzhyeTIycHlOSW5DUmh6WFY1bGd5MUprOXhHVGtPVGNKdW1IMHlRclNUNlBv?=
 =?utf-8?B?eEc0elBITHpFblJPNEhBbTJUU21jS3NIRHJsTXFSUnMreVRYY1NWZ1B6cDRi?=
 =?utf-8?B?bEZ1V00xYk1aUFk4dllxdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9261.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SENWcjk0RFlhQzdDTzhQZEJRTm91ZE04QnlYWkhKcXduRDN6T1k2d2M2WHVt?=
 =?utf-8?B?TkVVMnRLUmQ1TzhrWEdIVkduR0tpd005cWErWlQrMXlDN21ZOWZySGtueThC?=
 =?utf-8?B?cTlCSGJuVDNTWlV2dnhSZFJidzJ6eGxiWmY2OVlhblpGRE0vblBEaVVQc0Uw?=
 =?utf-8?B?T3B2OUNtYUdTS0tUbFgybHhRKzBkaHFDNG1Zd3JOaWdxVUJlb0tMbkpKNGU0?=
 =?utf-8?B?Nkl1QndKbFJmMmQ5UWRTSUVTOFFlcXZENlUxKzZDMUZNeUZOQlVLUE9qSEJ3?=
 =?utf-8?B?WUlNTDNQajRMQjJycGtKcHZCSVo1cEF1SGczbjhFV0dwNzFtbVlQY2M0Vjl4?=
 =?utf-8?B?MEV1WXJwelhRSVdzS3NMd0xhZ1NYY3M5RWx2NVgySDhOOWRDNk5hTUJ4YTdF?=
 =?utf-8?B?dHJXUUo5cDV3MlhQTGEwSzB0a0sydGZkZ0tYREZKMlYrbG1vU0d1cGQzTm13?=
 =?utf-8?B?UTFLZUNObjIwcUM2L0piczA5a1pKMDdkSDVLeGVkQlcwdVhMZlJpMmtKazdD?=
 =?utf-8?B?TTJsWExqM0VTQ1VnUllGcG0yemZsZnVhR1VvT3B6N1B2bUpxVDJNQUEvd1g3?=
 =?utf-8?B?enRVMGpFbnY0Z3ZwSXBvdGw5cEtHUC92N2NTZnRHaDRHbWJFOVVuRGVYYU0w?=
 =?utf-8?B?OXNFOWUxYUpGY2l0L1FrYzY5UFVlblJlUklCbXY4UGxvM0d1YlZNU0c2Z2tM?=
 =?utf-8?B?NWtpL1lqSXUvWDZhWUMvRWZpZ1QrV0pWbEJPWWVaaXloNG0yMmpCQ2dOS3A5?=
 =?utf-8?B?QzZSYmlYYktnaDl6bE00UWpqcGx3N2ZpQXZlY0UwZTlWY1ZrZWJVdFRVdFBI?=
 =?utf-8?B?cEtNU1ZNTjJCMndJd3p5QWVtUW8yWjBabWNLT0FFRTJEdFozWnMrMEwxcFdv?=
 =?utf-8?B?aVcxTGYwbVo3dmd3OGxpaFRLczdNakVFUVA4aHlDUWRWRjBRTFUyVUFpSXRC?=
 =?utf-8?B?UUgyYXg0Nmo5czRTZWt0NmxOa1VLN1dnbCt0MTQrTWFCVzM1VDdnNzJjMEIr?=
 =?utf-8?B?SVFSQm04NGpXeXViN0E1a3UrYkp6RDhQNVRqaHo3cWhFUUtSbFFqM05JOEpJ?=
 =?utf-8?B?Njdkb1ZxaFBCOWRBa211OUhSdXpEemkyQmdSd0VjY0JkUGFqYXQ1bVQzbkQw?=
 =?utf-8?B?WWpFV0hrY3drSDh5ankwTUllMTVGWThjeXlYRHJHbUtuQmh3bTFKRVRjQmtM?=
 =?utf-8?B?V0NMb25GMEdwem53R3NqalVGNWpJeDVoUitrVnVGNk5iQUlISVRsTGorRllF?=
 =?utf-8?B?VWtiSURBenlpaVJodGJ4S3lZNjY5RjdEM2h0MDA1SmFySG9URTFFbmhXcnhN?=
 =?utf-8?B?SkFzOHBTWVQwRHVUZ1I5SHIrSmRHbGszNW8wYmx1V0FvOUtSMUxwcDVHUE9Z?=
 =?utf-8?B?SDc5MU1IZmdZNEE1a244TWdpWjZ2WTcyQ2FhWnYxY0x3QTdoRG13NGZndDRh?=
 =?utf-8?B?cjhoNEtKeldIVm82VW5mZ1lTUExHMHVxWjBuT0xNTUQ0SEZUMHdOajBtQ01h?=
 =?utf-8?B?dFJtWFdReE9mSDR3di90OXdtNzhza0dzOEVDS2l6UEpxMzVOS3ozM1IxYm9s?=
 =?utf-8?B?U01wYmtnMXpsdnMvMEd6QWtEbkVKZFByKzNaQ0FVa0hkMS9ZekIrd1MwYUNG?=
 =?utf-8?B?YUJqamJuaEtveDBpRDhpSnEzeGhHQjJ5U1BnWmNxYy9OYXdiTUlJblpIelNo?=
 =?utf-8?B?S1dvaDVVL2twS0JuSGhka3VyMHRHUVhVdXo1cUh4eTRveUVRenRXNG1JclNj?=
 =?utf-8?B?N1lseEpod3hrVFE2cTZDOGZIS0FCTitmNitJd0hVZ3J3T01qaGJzeWt5enFm?=
 =?utf-8?B?SWgxTWNRang1WmhHUE8yNVF5NFpObk1XbzVLRFlBd1U4QWpTMUlxblZrN1Iz?=
 =?utf-8?B?UU00YkNQTlpqWDZtbzJmM1RXQzQ5alJub1EzcEZjaUFNaTRhVXZOTktPeVhS?=
 =?utf-8?B?VmJUWGp2aWszK25ucjNnVWFDaFhUb1pmWDdweTJueDF6ZFp0QmNmaWVrdElu?=
 =?utf-8?B?SFFtY2xZVmN1Skx4RjBTeXFmOXU0cTBDRkgyeldCZEZ3cWQ4TStaT2dsTWdk?=
 =?utf-8?B?ZXBiT0lWZVRjSmF0bWJxMTR4WHJmQkMwZzcyNFk1bFNLa2VMVFkxL3MwVWhp?=
 =?utf-8?B?VzQ3TWdramlUSzRPUGtqeWIzblVVeFU2ZVJ5UURuLzJSei9CTkxzZVZHZFVs?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd2cd64-00ce-4590-fed8-08dd0d6e915b
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9261.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 16:31:09.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BlaU5608z6xc+E4A8Vd/4DKDLy8oO/ChLL8QyRkX8L/c6N/3f2hE+HiIbN6E1DHsm+bxqkvFt6391vSm3cQV8RFK1N39V8tMsIWTwS1UAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add S32G2/S32G3 SoCs compatible strings.

A particularity for these SoCs is the presence of separate interrupts for
state change, bus errors, MBs 0-7 and MBs 8-127 respectively.

Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
same restriction for other SoCs.

Also, as part of this commit, move the 'allOf' after the required
properties to make the documentation easier to read.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 97dd1a7c5ed2..b2c16a7d864c 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -10,9 +10,6 @@ title:
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -28,6 +25,7 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+          - nxp,s32g2-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -43,12 +41,21 @@ properties:
           - enum:
               - fsl,ls1028ar1-flexcan
           - const: fsl,lx2160ar1-flexcan
+      - items:
+          - enum:
+              - nxp,s32g3-flexcan
+          - const: nxp,s32g2-flexcan
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 4
 
   clocks:
     maxItems: 2
@@ -136,6 +143,37 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description:
+                Message Buffer interrupt for mailboxes 0-7
+            - description:
+                Interrupt indicating that the CAN bus went to Buss Off state
+            - description:
+                Interrupt indicating that errors were detected on the CAN bus
+            - description:
+                Message Buffer interrupt for mailboxes 8-127 (ored)
+        interrupt-names:
+          items:
+            - const: mb_0-7
+            - const: state
+            - const: berr
+            - const: mb_8-127
+      required:
+        - compatible
+        - reg
+        - interrupts
+        - interrupt-names
+
 additionalProperties: false
 
 examples:
-- 
2.45.2


