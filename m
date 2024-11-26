Return-Path: <linux-can+bounces-2236-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD39D9A55
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 16:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7039DB2A6A8
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E571D54CF;
	Tue, 26 Nov 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NyniO4Sh"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4C1D47C1;
	Tue, 26 Nov 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634485; cv=fail; b=rgcqnkdex/4AiZtiKd4+pP4pKyEzqS7ZD6zK13PD+d7y7Byr4CFdvXagTUNkl5mcx72oIgE/NM/sPYVeAP4WlF5UkNyTscmKtU76yC8P3tAmS5l3IMImlnjjyPrfg2PiGNXuFvJs2LxnDDM68vGpnzUPzDA+/1kSzcsSVBKVGrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634485; c=relaxed/simple;
	bh=0OS2IvzYK8bOHxcoyTqijLSMfGZHUScQH5y+489gbGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bM2lTv9P9uVryLqzGlWLYhzmX2HF5cR+43BWt1pwpeJnq3IfaNGXQM4y39x/zMKH/p17VXAhevKrJQmNmkY1NXWGF10kb5AqEWrDi14eYTtM2gS0fWMZH6xRwR+4uBcB8fDydRMzTIRTfGS5CwuavDdA5f7apYc8SQQGUfEDLOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NyniO4Sh; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbDT0KslF0F4mAZ2Ovb5kNaTj8OaSfECvTdCawpZZFXgvomwtp3Unii9ms6aC+J1rRqlBRmUHYm57RMOzzW1HAmcToV6Vz+h7dJvNvVXl+SYzP6WO1VWDpeJ3UGoFRG9GtGyZ2gb1yBJ8Ksr7LsdITdSxj56EbrF4eoBpeWWUSXyfNr/BPBcuVDaOlQu2IQqcEycz+KaQNEsql0gVHkhxynC5boiy7utkmbyPI1pOY6mD09tRnb9/HSDMXUnZQVL/h92j2tZrvUIvDd+SwbV/TVA1r44In63T/+43TER414nWiakdc/cMxLxc2D8DTU4Hr1IaRHGZJjdA5RYLAAx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97gPogNhEkHXHPr+JzfDBNd3CwOv0B/bhGSdFOyA0V4=;
 b=QJLEA3sDZBX2nCQP3e8RlbRYRvsucY6Esguurw+W0flKnXjnVYA1OfDxX1/sF5ckdAXU66bHT+cC/l5wCzMci66UyXC4ZlLE5tQhfe1gsUr6LE6gdgVlDPPj7bQBWQrjWTXPtA1X8j8ijrjKz6QOjANIXhH3dXrLYdqX+vqWN3aTAvUkXuVc2w/wU2IesM3br9CVyu2sLhTAvwfGxSEpCF+jBu+XyqD2IwFrFbsxcPmvXgC8tiCWQ4JY/PbR2dMeircywU8ReL8OfUB0IefnlnxnCuRdFEJ8bYYn+i7891f8w4zVOhci0YAtCfveRLIuGI1Fhs5m9mjGyA6pL0C0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97gPogNhEkHXHPr+JzfDBNd3CwOv0B/bhGSdFOyA0V4=;
 b=NyniO4ShC7gujg8MuMCHwgfJSnSG/+KYg5HQgHnVHa2vh7KG35HdYr60g7aQWxghMFGxRKstkDfRsEtX7Z/jZBEqhlDA+PvnX7HwCDcWZidM3WXJ6kykg83jn7+ckdErADtq2WGdqCXCerPjZu7+Gb9PAP0d/Wju7+7Yv+rW964h6U0FaU2f9zXzCuAoZVSW3tLJsgxF1Oq4gXtSXd/O8+ZSTN2bBsVSjAGQnFw6XJJWLa7LH5x+YRS5lD+CTHSPiQg3oaYoDi9FQ7pXuzBFS8pU9qwjYILiVJPyApzpY5CANzFHlzNYKawKhp9Mx3PBdRIlfTQnN1SOCujKrNjDdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB7735.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 15:21:19 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 15:21:19 +0000
Message-ID: <e8d11c7f-0bf5-44cd-bb2d-a7e454905e53@oss.nxp.com>
Date: Tue, 26 Nov 2024 17:21:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Frank Li <Frank.Li@nxp.com>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
 <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
 <20241126-independent-crocodile-of-finesse-106009-mkl@pengutronix.de>
 <01a7de95-24e2-4c75-a818-bbc363e89844@oss.nxp.com>
 <20241126-capable-vagabond-tody-8b3717-mkl@pengutronix.de>
 <1a9281ec-3a4f-4175-8892-ee2e1ce1308a@oss.nxp.com>
 <20241126-aquatic-brawny-shrimp-b3cc0e-mkl@pengutronix.de>
 <20241126-conscious-keen-cricket-c603ff-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241126-conscious-keen-cricket-c603ff-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::28) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 102e9400-2c41-453d-93d9-08dd0e2dfa42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnFRbzN2S0lYNHh2V0VtWElxOHNiVVY0SFpwb1h2RUZ6VEtXQ1pzSGtnMyty?=
 =?utf-8?B?d1NXY1ZMWjVXZk8xOTJFdkFIQ3FkeW5sTXkxWEJmZW9ZYW9sRU56Sk4zcUxQ?=
 =?utf-8?B?dk1sUG5BbFh0cnJ3a0FaWmZkZ09EQ0ZhdklnWkkvNVNUQkxBMjRMakpGV2xs?=
 =?utf-8?B?aHRxbTZNWDZVZzZyclppZHMwRFYydjZLNEhIU2tRMmt3cmRnbCs5T0NyK1Q1?=
 =?utf-8?B?TmszcTFsZi9kVVdkOExHVGg3cnljVFFEeE1uVU1iNzEyTzhBWDZnU0MzU3By?=
 =?utf-8?B?enN0c045VEtTcDE5SS9UL0FvN3dtcFRKK0EwK2V6U2JhWkNtcjJYWHlSRnVB?=
 =?utf-8?B?elh4SzVndkMvSWxMWXVJcVROZHMyc3JVSmREeFhYbEJVaGRsb1ZIYlpUdVZy?=
 =?utf-8?B?RGdkamphcUd0SXI4aHpRNmxEUFRJQnlMMmFjbVhqRm9MN3B3NUgyT1hXODNU?=
 =?utf-8?B?S09xek16NzZiL0FWaGc1V2RXQ3ZiU3R5dnRPSnpaVlh0TGNrY1BOU2t2bjNR?=
 =?utf-8?B?MDM1SHRJZmFqZ3F2dUZBVnF1U3NKeE1YR1llaWdPUXdKdTZhRS85ZStLWVBw?=
 =?utf-8?B?VGVXc3k0RFBaclp1SU5zRTR4cUVRMlFiVkxvc004aWkxL1J2c0NrUmsrQTk2?=
 =?utf-8?B?bDVjWkVHUTlpZS9TK3lKaGc0dFdHRFRKTzlrSnI2cmxwT3lWQ1NBYndVRTda?=
 =?utf-8?B?cllJaklyOVhpWkNaYjNsSDhzc0pLU0xKYjcvS2YydnRkN3gzWmNmcytDWXhu?=
 =?utf-8?B?WDZMUWg4UjdFUzA2cWtUaDM4d00rbGZEYy9RMUk2UTQ5bkd1Nk5sczM2VXd6?=
 =?utf-8?B?aE9rU3J0TjZiUTY5WWo4aFpmWWJCQVFYck5rNUNPMnVlbHpQWEpzbmJJZ0pF?=
 =?utf-8?B?MFM1UmkvL2xReWgzOE14OWpXMmxMRFk5dmVCYzMxdHRwVHpHRDIybnNPZ0VS?=
 =?utf-8?B?M1F2bjlJaTFzSnV6czRwaXpPRURHUWNNNE1lOURxeDVtRWgvVndJK3lBZHRh?=
 =?utf-8?B?aUlpL1lzMFJDWnhudHl1djdnZ3o4WGpwQnFqUmtTS1Nja0x2SlVKZ0hVR2xp?=
 =?utf-8?B?S3VnWkdzQkJJKzRCSENLSEJoRk9DcnlwK1hDQ01DZTdxRUR5UFozS0ZwVUZM?=
 =?utf-8?B?Ym5Db0xKZ24zMEVGc3J6UDZoNU1hTHN4bWpKejhFb0pSS0wyVUVrMVhISHdl?=
 =?utf-8?B?SHVDek5QaWcrWkgyWnRkem5QTExwMHB1UGJGbmJSZVpGN1NYWWphcTF6b0pp?=
 =?utf-8?B?Tk1pc0xnYy9RNFFObmF2dTI3S3JKVDhYU2l1QkUzcVovakVEeGxYWGNKeGhh?=
 =?utf-8?B?OEpubEFBU0pjaWtUbzhmdFhFdGpuVTBSNWFMekdjRzFXQUlxQzJRQk9IOVdt?=
 =?utf-8?B?eC9CY2wwNWphaDJFeHFFaFIwTVlyRFZQSURrdGdjcTBZZTh6dk1ZTThEOXhI?=
 =?utf-8?B?K1FhZ2JBR2RQMGxNRmxxamtYcTFaN2c3Ky9Ed29xKzNkWnlIRk5TU3FrU1pz?=
 =?utf-8?B?aCtGaFA5Qyt3cm9EdEFWSGYydWhyOEFpTzVwbmVtcllXOEI3cHAxS0h0Ui92?=
 =?utf-8?B?QjVNRFVFMENLV3hBOEE3YmdVcDhZTEhLQWpuTXF2Sm5aRkNaWmt2aW5zNDA1?=
 =?utf-8?B?SzNDbHhjTGszYmZUVHZwSEZNczJpUjVmbWVYMlFEVDdFRXdDc2dEY25vcHR1?=
 =?utf-8?B?Z2JxTlRtSHd5WEdMTXJwRTlveW1PNXBjOGtZamgwY2hMQVVjZmt0RHBSRHRX?=
 =?utf-8?B?NmE2ZW9kTXdhdS9tdGpESzNYZmZzRnFGU0xTT05OT2MvbFdqUG5oZkc4VXFU?=
 =?utf-8?B?VFAzeWtBTjZOOTFRRjJqZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZMSzNDQ01aZXFtelhuakhsWE1Wb3dNZ0pUTEpiS2V3SlhOUCsvM0NXRG9T?=
 =?utf-8?B?bDNQZGk4c3BQTHZkQ3B2NDlvL01mMkR5Z2NaOE9STWRibWV6TDZYVU12b0dT?=
 =?utf-8?B?ZHluaVhHa3dYc3BnckY4K0l4YjVnd2tuMi92MGtOS0Q2MStPZ2RDUG5idHp1?=
 =?utf-8?B?TTAwV1l2K1cyS2o1aFNGZDN4R29uSTJ6UHQydjF5b0ZEbkdhYWVibHFqUWpU?=
 =?utf-8?B?MEpPSmRVZ3lRVXdkWGpzdEU0SWRTd1R5SUVpaVF0aDdOdHRnR2pHTjFNZk9s?=
 =?utf-8?B?WGFTZGR2MUYyTU1WWEsrZzc4enlTUHU2RTltQVJ6T2x5aXo3VjE2c0JHOVZz?=
 =?utf-8?B?WFkveUpEM3JXOEZpMGNnTFJmd05aNlhNNnY0am01SnJZQWpGQ0o3WDJCSFNm?=
 =?utf-8?B?bXpXTjRZYW14cVg0RER2ejFsL1RhWW9wVE5MRzF2STN1dkFJRUdRV0IwdlhF?=
 =?utf-8?B?VG9WbG9ONkdDOEt5V3lGd0hrQU0zUUpUU0JQYnZDdWpsNVNoRVpKT1JBaDVp?=
 =?utf-8?B?alFqWSsvRE04N0hRRGYxZ0hXSUdNMVNpRDNyQUFsekFUQm42b1BneVdraVVC?=
 =?utf-8?B?NThoUklVbGhqYSt5NXpxSkRxRldRVmVCN0RmMjNFZHN2Z1dab1N4UkMrU1FK?=
 =?utf-8?B?aHhFKzlqd3N0TnM0QnVNZThkeTFMb3A1Slg3NDRYTzlvRnJDSEJnVXdKRGV2?=
 =?utf-8?B?eVoxQWRNRkt3VU53U3YwbEV3alI0a1UzaER5U1BielUrMGZQSzd2NVI3QlYr?=
 =?utf-8?B?Q1IwUTlPTFcxUHdVRUdpTFluSGlaNzRNeTZrdE1Pd3dWR3FuNllkUm9laW1z?=
 =?utf-8?B?U3RPVURRTVRqTEs2UFo0cnB5NGdiUURSLy9VUmxhYWJQVTBvcm82UmdpdU1x?=
 =?utf-8?B?THUwT2hzV3VScUxsSUtLSGpaVmVWS2pJcVFuT21wSWhLb1Qvci9CNlVLSDdj?=
 =?utf-8?B?VThXOXBGSWNvcDQ0RGZnUndlYitaOWdQZEpYZmx3NFpoRXhZSUdXRXNDK3dN?=
 =?utf-8?B?aDRnaEM4T0phbVh6U2phTjI1SUYrM1hhWDg1Myt5M25SeDhpZFI5Wk9pQ2RC?=
 =?utf-8?B?bFFqeHFqV3VCZGhVUzUyQUd4aHJvK2VVUXJMUjRwRnV2cllaWmtMWWI0Y01a?=
 =?utf-8?B?Z2c1bkJ4S1BkVEwwWTc1dVJHRjBrOENYeXNmNGFhcGpXVEI1ZGNFMklBTmZ0?=
 =?utf-8?B?OHN3NG45NWRWV1B6OGJwWXZNWTJIYU55Y0crL0wyYTRjdmtvTEl6V1JjMk1z?=
 =?utf-8?B?b0FIeEFNbHVCOGczanpHR0JudUlqQ1R5RGh4bFlBSXgwQjMxbjdFVlNISW5s?=
 =?utf-8?B?T1cwbS9oYzRqN2h5b3RmakNWb2tLOGlEb3dZMU9pZnphdjVNcXFOdDhIYTFP?=
 =?utf-8?B?T0ZwYTc4RVFraG5majlUMjJKS25lZnd1OFdxUHAzWG9hdW1DVDlzMVRHMENH?=
 =?utf-8?B?VTdlUTR3aG1Sa3NlOUVJZUtFVVkrUEdOemtSTDZoMm1LQ3BTaGFjM3RmZU5P?=
 =?utf-8?B?aFJOMkdyVklpUG5zalVYaFFNMHBkaE9vUFJYeDRGTlZ3Q3Q0NVdmT0kvaEZk?=
 =?utf-8?B?ME9yZHJvOFBrcGhSblJNRXNDRWh3ZVRaY3BheGFMeGhDdlVtUzlTQzcxemtS?=
 =?utf-8?B?ZVlXMjhFNXIzV1VVb3g4cXg4WTFVbEsyNFVjaHJhZmhHaGdwaVUwMjBJQVpw?=
 =?utf-8?B?UUpCQjZ0Y1RpdlQwd2lya0d1N08wc01CM1FTbFNLRTF6Sm1KL3p3djR4UVNa?=
 =?utf-8?B?YlNlTEFPekdGVCtQMHpUbWkwZkF3RGFCV1MwR0R1dUZkVGlJTWxQVzRUeExs?=
 =?utf-8?B?WXVieGVTbnM0aGEyL1BzbXk2bndVODEwNS9ZcGphSVc3blFOeVlGTFFGNDkr?=
 =?utf-8?B?QnZJWUo4clFnZUdCK1lqRE00UUl5Yjhub3hjT0R5REFkUUdyVVFWQjV4Q1I0?=
 =?utf-8?B?SHBtbDVCandwdlJEQnh3eFMxSGVjZGNYckxtSVRvRVY3SGtTTCtQMnQ3NC9l?=
 =?utf-8?B?a1ZMekpUR3laSmVoNG11RGR5R3c0ajI2Ui9mdHh0SEgxV1gvN0IxclpFK29E?=
 =?utf-8?B?TUd0bmc4VjR0MVZBV25tVVN1TFRYMEV1UHBkeUxUWjJKNFhoWHBCOGJaUFkx?=
 =?utf-8?B?OWZnQTFMdXdGbWF6VG1OMWpHbEJwN0NmWCtSbTl3d3NMSlZoNklUVWlqdkRx?=
 =?utf-8?Q?LcCKTsLC5JfCCBJ4NX5Crwc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102e9400-2c41-453d-93d9-08dd0e2dfa42
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 15:21:19.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2nnbTV0zUn7AwbyX9GPhIuctHI2U9h9gmJj3u2POIHgmMZbx9SW/MczXUVkHQm6hsraG9NFGscgRndXwjZ3OHo8AwQLm4Ahy+iCAiK2Rao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7735

On 11/26/2024 5:19 PM, Marc Kleine-Budde wrote:
> On 26.11.2024 16:18:41, Marc Kleine-Budde wrote:
>> On 26.11.2024 17:15:10, Ciprian Marian Costea wrote:
>>>>>>>> +        interrupt-names:
>>>>>>>> +          items:
>>>>>>>> +            - const: mb_0-7
>>>>
>>>> I was wondering if it makes sense to have an interrupt name not
>>>> mentioning the exact mailbox numbers, so that the same interrupt name
>>>> can be used for a different IP core, too. On the coldfire SoC the 1st
>>>> IRQ handles mailboxes 0...15.
>>>>
>>>
>>> I am ok with proposing a more generic name for mailboxes in order to
>>> increase reusability among FlexCAN enabled SoCs.
>>> Further specific mailbox numbers could be mentioned in the actual
>>> S32G2/S32G3 dtsi flexcan node.
>>>
>>> One proposal could be:
>>> - mb-1: First Range of Mailboxes
>>> - mb-2: Second Range of Mailboxes
>>>
>>> Let me know if you agree to update as proposed in V3.
>>
>> Looks good to me!
> 
> Or maybe start with "0", that makes it a bit easier to construct the
> names of the IRQ-names in a for loop.
> 
> regards,
> Marc
> 

That makes sense. Thanks for the suggestion.

Best Regards,
Ciprian

