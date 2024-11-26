Return-Path: <linux-can+bounces-2231-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E39D98D3
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C41627B2
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64F1D47BB;
	Tue, 26 Nov 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a4FB66W9"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF098193408;
	Tue, 26 Nov 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628906; cv=fail; b=r3bd/JMbwPrWDsdC3Zro8Aj+gUo8hMGRpuG04pqSxk4tEzVIPh4be8HMX8KiXw4WjCoaUlySo0HU4TAc1uT2zxXPOc5q/kJmZr1O5notsTSiocxVgifJfjG0eoOc6160FAsoiOsk1KGowJ4gTda/TnE/pXdJu9QezLT6VWXNhMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628906; c=relaxed/simple;
	bh=9zNeULgW43+/vqWBRiU82UQkhPr3j649oiKLby7Yz+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XzWlLqDRoZoKGIC+7hRq3RnczYIAYc2Z7VL1h6TTE+dR2sAOfNi/CoM+uhTb953zUntu0JP3yLWzE48NXG7jfEFLdD8wXF2DXbLY0JNfmlNYXPAQsAHwDgpg393OyuWEVDyo1uu5w1UoeX0XPe6ZwvXaZyKxTSdh264d/Eg2wVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a4FB66W9; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6rWhGzf2ogMoCqOF8OZ49oJItvLwqGkt90iN0TTOg1nu5LPwaeiQagXA3PjoBKcM/rJ0/yCirBg2yawdNgDbcE1QpJ29HqSyrmAg19fODJpPpNN93hs+EgH5jljApK5rKsB/rBQ4XRotVy4cxPMjwpt0cRMlaXVO61ni3TheEtgaeIKa/rCzbq4foHbRbto1CxMRiFuEjkxOVLoOXomZf7NxTLxH/4lf6r7tLKz0ABTpbw8xZF6NGKzjUukjvuuCLYGwAaNj0X1z4VQ9cUrdFxG82mc44SskTJMjypV2d7p/qruHy13BeEKC74c7cQjXv+wTkAV6Un7uYbcHR5oWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpQtzKkxEKj3hLCDUrYnY9QgM12z3/zHBRUZNdXKvp4=;
 b=kg8uXWDyYca4QqO0tMhBqWC2FOScapEQptlBZRgFr52Vg4BHJAqWhBIGJYPOqTwfwUJNqbZw5AnrqPAfH9BQFiX4vC2ySCawhy6N2aPP0g0CKJS770wmh6vxgVEly0gLN223V58sKTwkQ8tDA1RuU2x1j++D5kP+tIT1Je6jUQGGiETPTqGylqqwJY9owWej/zLS8rsPjjU8m+eSYoZxdY7fa+wy/6EYBhPumpuTZkFNuZZBR9uuCafa3TzBOMS5ZvX4FGgByJg8wZPj9+mnVdW9VlN6JgGvua09yfF3fBSJsY1PIZAdLLZRSsSYiHLtvn/jWcvQozVpDSKp0+g4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpQtzKkxEKj3hLCDUrYnY9QgM12z3/zHBRUZNdXKvp4=;
 b=a4FB66W9mDCcUzMGTLcg6J/Dzsgy440kWnb0IwozuZwcG2q1LsNmobApL0sOo8wPDOHuu7EONk8nlY4ItqconUZQnqetPBYVHbvztCtDSY38RQ2+yGASxXd3ERVamoCoc0afYIxhXUebHdfT5jz9WFE1gZsl1g7Hb5Xv8QFV76U0hjDiHgIGBFJNZUDcZnGtMlDKj10NBYlPqpaMOOjrhA5c1/YIF1SfFu7AcWdSFICOa4WMJ2meZvQ4zNtMcl7nJefR7mUhy/VjMPHrye+8n7xPxKuwEmbBEOkI8fNicH61tRTNocvDdjg5fn4EDR9aCSlgOEomvYc6wlp+gu4VOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA4PR04MB7983.eurprd04.prod.outlook.com (2603:10a6:102:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 13:48:20 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 13:48:19 +0000
Message-ID: <01a7de95-24e2-4c75-a818-bbc363e89844@oss.nxp.com>
Date: Tue, 26 Nov 2024 15:48:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Frank Li <Frank.Li@nxp.com>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
 <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
 <20241126-independent-crocodile-of-finesse-106009-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241126-independent-crocodile-of-finesse-106009-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA4PR04MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 7418fd30-a7aa-4972-a51b-08dd0e20fc77
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHdCak5OVjN5NFRhQkk2YmZ0RXBCY1ZlTUxJcENlRFhINy8xak5sdm82cFI2?=
 =?utf-8?B?eDM0VWQvL3RIM2YxclBrNE1EVWU2eDZvRHlONWUycjduYnkyU1JVYU9zeWdp?=
 =?utf-8?B?Z1NJOG9McWZLeUpTNklnUU1KaFZHRjVlR255NHhWQXlPRXloSmNyUjhQY3RK?=
 =?utf-8?B?SVhOMlB0UFErdGN1QXFTZkhseWxnOHAvcm9oM1JXTElmdFhqaG9ETWZpYmo1?=
 =?utf-8?B?SFIyTzRBNDAzUmZscXVTdDQxM0piOTVta29LMDViVzZuRjlXZFpsbzRtRk5x?=
 =?utf-8?B?VmlleVFYVjZMZHNJc3M3OC90YjZDcFAzNHd4SzZCVDJwcTExOVdSalpTNGsy?=
 =?utf-8?B?UkRIRnJMN01UZWtQaFcvR2pVNTVwSFRGNlkvWmdOall4ckovYTIwYWJlZTM4?=
 =?utf-8?B?c2tXQXh3eWUyNWxDdDd4NEtZaktpOHg4UG1JaTdtYzQ5OWgvRUU0NVpDT0s1?=
 =?utf-8?B?NUpMR0NSL1RYQ1pNampNU1U2eE92ZjFYUHVjNjJ4a2o3QlY3bzZkY3hmL2Zy?=
 =?utf-8?B?Ni85eS90RWk4aiszYlpsUnpkUGptVmpxeUdUVXRzSWEzdTFTRTBWVUphUzY2?=
 =?utf-8?B?NTMwWCswWWdBeGlUSnhmN1ZZREFGa2xaR1ZLb1ZsUkhRYWxRdUlaVitZbkxo?=
 =?utf-8?B?UWQrWEJUVVZRZkdJVkd2YWJSVk9rNjhOQkJzL0txeGh1VlFsM3VSSUg2WUV3?=
 =?utf-8?B?WVplMDh1VzJ1QnYxa2ZLcWdIb2pIOUc2RnB3M3RqRmNBcjVIQlRqSDhtWjlK?=
 =?utf-8?B?bFozUmNNV2Y2N295bHJzNjlXeTgySVNjT1QraHRnNzg4SVI4dmhzMURhdm84?=
 =?utf-8?B?MnlPRjhUdWZJamtxL200eVI1L0JrS1BGZE1FWVNWWFYzVWV2emhvQ1phbkpl?=
 =?utf-8?B?V04rdnlKNzJUQ1RVcE1OTVFCdXhqYzJBOFJTVTh1OTMyZlNsd21nYngrazI4?=
 =?utf-8?B?WGltbjI1K2RqZG9zSkhSZXQxa293c00rMVdWWEs3aUgzc2xKSGx5MzJkTmxJ?=
 =?utf-8?B?WVN2YVd5WWRYcGxMWFk0WGM4a1p3OHUrSS9QeUZVeDMyWUY3NmkyOUJYVFFh?=
 =?utf-8?B?WmtaeUJsZWxHd3NNOUZ3U24vMmM0TEZoUXpqdWRTS3Y3ZXQxT09FeDdzaTNw?=
 =?utf-8?B?VDdJUVpmY3VOMmhvNFZZaTVBT2NEZmFjTXAxZHdWNW9SelhNUWVSd0loVEFJ?=
 =?utf-8?B?cEZ2NmVFb3ZvUlVzNWU5WlhXQ2FIRVdFNUp0aktCYWRQZjRHMVl0MHBjUktT?=
 =?utf-8?B?dDVoSSt1K3dpMHdGYkh6N3FNNklmaTluZ1dGMjRQWENwUVRoelN0M05BSFYv?=
 =?utf-8?B?RjhLek1XclFBOTNzYlpWWndaMU1JZnJyMEJzMlBkUDBmWUVIZkh1R3d2Ukhn?=
 =?utf-8?B?ME5JMFpteVlibFVnbFJOWkQ4c0JFMFFsdW5HNzNBSFo0QlVwbmUxcXVUc0tW?=
 =?utf-8?B?REFnMEpXWExIbm4vSXJBdEhlZHdHWE9pQ0l3TkFLM05yYU04UTlQdzBEWGYy?=
 =?utf-8?B?TWpraXRNajhyNUh0SmlmalNCZktvVk1zanJyVDNsMFZNenNFR2hldDc4N0VJ?=
 =?utf-8?B?NUxvWkVwTy9wVWphNU1iL1BsU0FyU1VySDhxZDRuZ0M0OUFjejY3N0tza1o5?=
 =?utf-8?B?c1ozYm5iN0RWKy9mYTFZcG5SN3dPRzBkUXNZUTZBakVKNXBVanYyVHAwZXhl?=
 =?utf-8?B?endncFNyZHJWaTdjWjlNVWI1WnlSa2JNTHRKMWxCRkVXS3dJamcxNmhjRWFZ?=
 =?utf-8?B?TWxtZlhHTlA5VkwycGtBaTVBZTIxd3RRdzNaVkJFQmJxRENjeHlhN1k1R2ti?=
 =?utf-8?B?VjMzR2ZoakpuNEE5UHNsUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVFBOHNYdTZjNFdNbXNZZG45eHk3ekNUSTJTSFV0Q0JERUVlR1h5VWREbmJF?=
 =?utf-8?B?ZWpLVDZWTVJHZ1hzYkRhcVFvK0R5R0RGNDZqMSt4STdWRnhZV0pJYzZJMEFP?=
 =?utf-8?B?L0FoNm1PUUdpK0t0MmJBSzJVazlQbVFXMDFFdWQyeHkvV1dSOVRMUHNHMWs1?=
 =?utf-8?B?RXhyekx6eHdFTlNkZ0kwbHBPUC9ZNkRTVjVRQVNtSzZ4OXFNQnJPZi9ZMXRC?=
 =?utf-8?B?VUhIR0I3RGtrQUk5WWFKdFBFMzl2WGppa0k3YnlOdGNVQTVTd0R1bmdHOG13?=
 =?utf-8?B?VEtRT1FEYzhlR2pBUU5FU05pQlJ2Q0RBNk9hMTZvZFhYcko2WWlrcnloNjJK?=
 =?utf-8?B?andIUnhxNm1Da2gvc2t6akdmakg0WmhzNlRHQ3lCTmgzNDRJbnhndVREbUli?=
 =?utf-8?B?V0wvNng0emp0Nk84anBBTWVpQUhtVFQrOWVCc3FOSFRoMWhnU2JYS3gzVnFu?=
 =?utf-8?B?Q01tdy9qWmIyN2ttc1g4MG9IUEhmcVFaRkNIanI3c3VLRVVaUWtIRG5STVZh?=
 =?utf-8?B?UWtKOFZPVHhXRkxSc2hBaU9MM0FuSGR2NXRVMWUvZU9Qb1dhWERxemtzREdM?=
 =?utf-8?B?VlNLK2FUQWw2YW90TmlqQW9ZU2xOdXR0QnpWY3FWb2dpR0R6U0JTbXhPV1By?=
 =?utf-8?B?UTdXbWVhRmw2Z2htNi9UNkVWdnN2TlZWcEFraitEWnR4d0kwUUZXdnFUTlIx?=
 =?utf-8?B?YzdVeDN5VHMvZXVrYW03a1NLNTRrWVJ4SmI3WmdvRmVCWGZLdW42RTFmeXBr?=
 =?utf-8?B?STZLTGJyYmcxa1AyYjRSUTVtVFVRdGM1NjdFbGtITUg1cGQybUppaFhXTGo3?=
 =?utf-8?B?ZE55RVJJMnpsTXNBdTlucWJpUVFtUjN4amxzV2VlUUl0SXFDTzNnZEUvK1I0?=
 =?utf-8?B?MDZHNGNOSXo2TFA1TUdVU0xUVmtxK0NmQ1N0TzMrYWwwbWc4ZE9ZOUNFcytF?=
 =?utf-8?B?TXhVQUtXdUV5anF5VHRQSElrTUVUd01jZmxSSkNhdEsyVytaazFWcnpVWDJF?=
 =?utf-8?B?RTVBYmdxR21qNzYySFkyc3EwSitoaHg4ZU1wVjE3YW5DTWYvMEFnOHZ1NmFT?=
 =?utf-8?B?cmxCZ1kzOVZiSEVZd2VRa1RnRVhvVWVab3l2aFpvY3FGU3FKN3NvbmVlemRq?=
 =?utf-8?B?eDZJSWFLbm0vM1NUVk1PYUV4UHV1SHA4U1IxL2o5bTZXL2NSeHBKVzByOThE?=
 =?utf-8?B?L2VCMnBZbU4yTFExc2RFSHpwbmVRWkMreG9hZXJMQnlteHIzdTlsd0dWeGlZ?=
 =?utf-8?B?Q016d2dpZXZ1T0tYYnBOU3dnaVJFSmZEei8zdTRlWXBwZVhkVUVLVUJXR1Fh?=
 =?utf-8?B?SWFLNjZ4Z2p6c3VsV0V4K2hPZ2VTcDVDNS9nMSsxblc3QXRVMUloUDRlbmFE?=
 =?utf-8?B?V0x1QVd2NHNBRmorTmlocDQ1KzBFUm1HQVlqT2RXZmZNZjlFTm9ScjkvRVox?=
 =?utf-8?B?bFkrbGljYVhLYjEzalJPcG1zU29VSkRwOTVMd1dhNWlaTE5FQnRuWks0NjVY?=
 =?utf-8?B?VGd1MVg1WmpJeXlWL2ZaTEZBeWxOblZjM2cvTzFHYWQvcmM0d3pzMlg4cXo0?=
 =?utf-8?B?eUllNklDYjVUU1ljN2JGL0xuazk1bE5TK2QvbndmSVVRRVNOemI0bUw5OXgr?=
 =?utf-8?B?bTViU29OcGdLbi9DZW5JQnAyUkdHNjdDMUsxM0J2eGUxUmkrZ2VORHBIeVlV?=
 =?utf-8?B?QWJaMTAranQ4MElBWlpnQ0dEaXBJVFBPb0lTK1NwQ0NxVHFEWndiTnM1bXVL?=
 =?utf-8?B?UXpDcWsySUZ0UVpzbnpydWh6WHBpNTlORHVpV0dqR0VGbGxhNzhQanVpYi9G?=
 =?utf-8?B?YUIrOUd6U3R6V2Y5eVRTQ2pidVRqRHg0L2NIZ1dwNm9zc254N3h5cnBJSkpy?=
 =?utf-8?B?ME0reHBqVU40TmZYaGxlUFMyU2RQc29VMkFJVVhJUnZvbUFSLzMrdHQ2TzR6?=
 =?utf-8?B?OElYbEE5dlI5ejVqT2Y3alpaczVqTWVVcHNJRWorbmc4K1VzRU1xL3RaUzk4?=
 =?utf-8?B?b2liWU8vVU13UENmMHh1Uk1vUWtnZ2VCMkI1cUNlUEtoTngxRFNUTTlJK3ly?=
 =?utf-8?B?OWV4RjhnSHAvb0l2TUZxT295VzdXaU16cnZlY0F0UDJEZjRvVXZWMGNtWmlJ?=
 =?utf-8?B?akFyTzBNS2g3VDlLK0RIYlBkMGpNd0Qzbm9ZRFRNb01TZTRUYlBjazhiR29J?=
 =?utf-8?Q?t8HOSNi41Q+qhlj4etmd3bg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7418fd30-a7aa-4972-a51b-08dd0e20fc77
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 13:48:19.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0g4DfYwyam8+CwGRF2Fn3Rgr3SXtGZp1c0BP9z0AxarAWYv9k/aKstx8ibShpG2iAkcasQDJdnf8W3YEvisU55yp2ff3xFSZ1eblaonKD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7983

On 11/26/2024 12:59 PM, Marc Kleine-Budde wrote:
> On 26.11.2024 08:19:04, Krzysztof Kozlowski wrote:
>> On Mon, Nov 25, 2024 at 06:31:00PM +0200, Ciprian Costea wrote:
>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>
>>> Add S32G2/S32G3 SoCs compatible strings.
>>>
>>> A particularity for these SoCs is the presence of separate interrupts for
>>> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>>
>>> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
>>> same restriction for other SoCs.
>>>
>>> Also, as part of this commit, move the 'allOf' after the required
>>> properties to make the documentation easier to read.
>>>
>>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>
>> You made multiple changes afterwards, which invalidated the review. See
>> submitting-patches which explain what to do in such case.
>>
>>> ---
>>>   .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
>>>   1 file changed, 42 insertions(+), 4 deletions(-)
>>
>> ...
>>
>>>       maxItems: 2
>>> @@ -136,6 +143,37 @@ required:
>>>     - reg
>>>     - interrupts
>>>   
>>> +allOf:
>>> +  - $ref: can-controller.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: nxp,s32g2-flexcan
>>> +    then:
>>> +      properties:
>>> +        interrupts:
>>> +          items:
>>> +            - description:
>>> +                Message Buffer interrupt for mailboxes 0-7
>>
>> Keep it in one line.
> 
> According to the excel sheet the IRQ is also for the enhanced RX FIFO.
> 

Hello Marc,

Thank you for taking time in reviewing this patchset.

I will update description for the first irq as:
'Message Buffer interrupt for mailboxes 0-7 and Enhanced RX FIFO'

>>
>>> +            - description:
>>> +                Interrupt indicating that the CAN bus went to Buss Off state
>>
>> s/Interrupt indicating that//
>> Buss Off state status?
> 
> What about: "Device went into Bus Off state"
> 
> However from the excel sheet I read it as a device changes state, to Bus
> Off, finished Bus Off or transition from error counters from < 96 to >= 96.
> 
> So "Device state change" would be a more complete description?
> 

I agree "Device state change" would be a more suitable description. I 
will update accordingly in V3.

>>> +            - description:
>>> +                Interrupt indicating that errors were detected on the CAN bus
>>
>> Error detection?
>>
>>> +            - description:
>>> +                Message Buffer interrupt for mailboxes 8-127 (ored)
> 
> nitpick: all these different events for the other interrupts are ored,
> so IMHO you can omit the "(ored)".
> 

True. I will update.

>>> +        interrupt-names:
>>> +          items:
>>> +            - const: mb_0-7
>>
>> Choose one: either underscores or hyphens. Keep it consistent in your
>> bindings.
> 
>>> +            - const: state
>>> +            - const: berr
> 
> The order of IRQ names is not consistent with the description.
> 

Good point. Indeed the order which is in the S32G3 interrupt map excel 
is not consistent with the bindings.

The reason is that in the flexcan driver, reusing the 
'FLEXCAN_QUIRK_NR_IRQ_3' quirk forces the probing of irqs to be done in 
the following order:
mailbox (irq) -> state (irq_boff) -> berr (irq_err)

Hence in order to maintain ABI compatibility I am proposing the 
following order for irqs in case of S32G2/S32G3 SoCs:
mb-0-7 -> state -> berr -> mb-8-127

>>> +            - const: mb_8-127
>>
>> Choose one: either underscores or hyphens. Keep it consistent in your
>> bindings.
>>
>>> +      required:
>>> +        - compatible
>>> +        - reg
>>> +        - interrupts
>>> +        - interrupt-names
>>
>> What happened to "else:"? Why all other devices now have up to 4 interrupts?
> 
> Do you already have a dtsi snippet for the flexcan nodes? Please make
> sure that the interrupts are correctly mapped.
> 
> regards,
> Marc
> 

Yes, I am testing using the following dtsi snippet:

can0: can@401b4000 {
     compatible = "nxp,s32g3-flexcan",
                  "nxp,s32g2-flexcan";
     reg = <0x401b4000 0xa000>;
     interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
                  <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
                  <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
     interrupt-names = "mb-0-7", "state", "berr", "mb-8-127";
     clocks = <&clks 9>, <&clks 11>;
     clock-names = "ipg", "per";
};


And checking with:
$ make ARCH=arm64 CHECK_DTBS=y W=1 freescale/s32g274a-evb.dtb 
freescale/s32g274a-rdb2.dtb freescale/s32g399a-rdb3.dtb


Best Regards,
Ciprian

