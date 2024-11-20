Return-Path: <linux-can+bounces-2130-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F08E9D36C6
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 10:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCFC1F257B6
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D91A2547;
	Wed, 20 Nov 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jM/s1lMD"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2941A01C5;
	Wed, 20 Nov 2024 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094185; cv=fail; b=VhQQKckNRiPf75bME526Vssf22p7BhveGf065hLrfk4ZrMU79X396oH5u16WnvSHzg6Bl/Qs0O40WB6bka4R5cKB0WjlzgLZrSBiOAyN5H86DxFnTjhPjL0Pa2xqQonuTPSi4l9UVYgn0LWtR689aWQEkDbSsXMlGNxgr6Wgljs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094185; c=relaxed/simple;
	bh=im9TnKAezdoP0uwgDU/torAggDfwU6svEPffbY+vlFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMT3ORbCG/MKNRhH8tb9XEvEV/oZp1OnOh5c7Ypj5BUyKS4F7Y4OWK6IbuPFI6QYfU8p7qa2hGFSKn+vU9liifZ/YKCM9zgJGaaFEX9iAThoQVu2ik0eYXiKJEe/VDGlQxepYtRSLGQz4zZhFrndkV0KcIvUA/2nPzBfco9lxv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jM/s1lMD; arc=fail smtp.client-ip=40.107.247.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMrcsYtAE/HBPUMByDVx0XSL6CKhCK5ja8JOYWaP7mr2w+kY1GYPQ4oH38J+BSHxbSh+9yKA70XRqiZREF/B5aHR2lAE6CgR0LdWYJxqDk8/eWunbZwa8aLK1Mqpn8IE5O/QHEWMlQ5g3LtncgjBG2RoNLePJ6qx+cT4+pyX/OiqbNSppyqKoEDcYUYfb9U7x7u4FyQ+VHQKfFaLvR9UyD/DL+oMOsTu9t7cVwzRtchLPrjeCc2cPOyvyusID0I2Zd1GFpBvxnBMicCYJhhzu0Rc/Sd4ueXT2jMGxPU7hdZoymGSJwPUzcJrNTB10VXHiTkrPMXZ9xHlVjApA4dthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG1t3AQLBLSYBNRoRCOFfPozM7MXxxnPpFCz4hkZ83U=;
 b=NL6ZisGAJ+7KcmqbSy7Oa6TG9+25j3gv731dAOeV8p/Hg6f8MdzeYxi0nVc8Ulqn6az/xISivorxAwngA07x0kcZ5yvZLQA60CaPbQuJIOcdVsUq3uEPnWBnEjYOEfnC27mb/Mjapls8WYwD6bu+p1dSNCsAH6pyd6dRf+bWFAc43YWQkYRKh02fqsePmQdyKMknQ9aGZgP3oWT5FIiUcTzUhj5rgnVW0iCJH+DFhF7nwjL5UqeGYALWJ3glcGURkGG982dlwbjuoXklPtzceFWdhp6x3r+ZwgEcqYBeWjpa49AxpUd2No7yvy+mUZa9q0e027PLEXbac5KmfGGJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG1t3AQLBLSYBNRoRCOFfPozM7MXxxnPpFCz4hkZ83U=;
 b=jM/s1lMDvSQoGQYgCdbOQSI4hbZWDQIW/cCJVRV6aWVe8cyPxGEuwb9SGVAGFioXm+dvbtdY0yP0nq4UElMm1qYWTYWTC263bQfMYosvxRlqtSDGmbN3MOD7s4UGqP80rsF66zpeZk4Bop7lV/AJOtoh6pk6hHFvKhgf9kUndvkCYwsjpL2w1CW2ghP0TM55KMTKQhD7NioKJ16jPvS4ht1sHzObBZPq4cdLj9iD13m3QzR0u7UA1BYhpNMS251KQTUmllY7+wfDFeH2NQ5mh61tOXZUGxYPDOvnsdmD7OOHgFRoQx/z3yTUCkl/7kQ/bZqRlbw4QkjL+GfWtK47cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9556.eurprd04.prod.outlook.com (2603:10a6:10:304::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 09:16:15 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 09:16:15 +0000
Message-ID: <c5bfa14b-ee2b-4d33-92b4-1bfdb0c843d6@oss.nxp.com>
Date: Wed, 20 Nov 2024 11:16:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: flexcan: add NXP S32G2/S32G3 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 NXP Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-3-ciprianmarian.costea@oss.nxp.com>
 <20241120-cheerful-aloof-marmoset-362573-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241120-cheerful-aloof-marmoset-362573-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6848f5-4f82-4b08-2a0a-08dd0943fc0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTNURkdTaElmQjJ5eStReGRRRlRrVkFLbGhISktVYWVvMlFldmlrS3l2aXdU?=
 =?utf-8?B?c3RvWWxsdm1iKzNtL2VtRkNUZVdxc1VOZEl1UzhDRlVqRnd3VWRlU3k0Q003?=
 =?utf-8?B?Vm1rU05WZkpqdFdBa2VuSWlvcXkrUm5yTENZR1ZyYUIwN2FGUy84dFd5aG0y?=
 =?utf-8?B?V2FGYk54WldmS2lkdkpDdzZhdE1zTnJWSHh3U0tvUC8zSGxzRzlselJnMS9t?=
 =?utf-8?B?SC9LUnpGN3dMM0VpTTQweFJWSHpsT0VDYVoydUxCYTBVNk9xRHhuQ2Q3Qmky?=
 =?utf-8?B?dnI0clRMMUFwODhTNVJqTndGV25aTk9EMDNNSU5jYUVISnV6L3YxRUxNTjBo?=
 =?utf-8?B?ZVI2Zi96NTUxS3lIalV0MTl1NGpOUHFvUTE2Y29XY1BBUGlheGRuL0d5WnZS?=
 =?utf-8?B?K05Wend2MnZTbzVzVXFDMlRkbjdXSVFETFhGMDNCZU5Eek9JS0J3UW5BL01G?=
 =?utf-8?B?Nzlnc3ptQm5ycFNQTno5dmMvdDJuZ0M3MnVDV1Z0L2xhdFJSalNzT1dNV3Av?=
 =?utf-8?B?eGMwME5ESTM1NitYZ1BtVExtQk5PY05ITWNkeTFBNFZTT2dHbEQ2a05EbnBM?=
 =?utf-8?B?S2VMQjBiMVgrYU52ZUtTd2RwdzFpLzBRZ1A1dnZGN25TYVN5MFFFV2s1Y2JQ?=
 =?utf-8?B?YnErSjFBMDQ3U2RXQUhwUWlwS0tLVWpySHh2a3NGdkkvRjdHOFRRVURRUGZl?=
 =?utf-8?B?T0cwdExHZFdGd1JsMWxJQkhFWW9ySS95Qy9GSllBUlpVelNHOUZwTjNaM2tV?=
 =?utf-8?B?OXFMbWxDWldRQ2tSOGFtTG9TVjZWenZBWlZmTmxRRGpyRmRSVjZ2Rlh0OER5?=
 =?utf-8?B?dHNvWnA1ZUFWbHhVNlhrWlIwY2hDcUpMQnhqQ1QwVlh6RnZHeDZGcnZrMWxD?=
 =?utf-8?B?MTJUb1dpcEYyRElzcUVadkZ2Zm4zMTBPYjhMcEh6OTB0VzBwSGdmM2xOTHlT?=
 =?utf-8?B?b1BFMlRCbURLK1RSWWJwbmpxa3AwU2VteDhMWWM0ZE05M2dxTzQwa3lpcFB0?=
 =?utf-8?B?WlJ1SnlkbWhwY1JXNnhzRmE4cEpDRzd2RFozRWhpYXhiWGhPQ3pkOXJtQTZO?=
 =?utf-8?B?djFtd0hoU1d0OVlJUTNpRFhvU2tmUjFQMXE2TlRxckxCNlAzRWkydFFKWUd5?=
 =?utf-8?B?MTZkSmVyYU5SYUN2Q1ZLZUh6VGNFbXpMWUlMbjA4bzRPZjhGOENJMG12QktI?=
 =?utf-8?B?cVRKTFNsNWtTOW5CdjhMM0hCWWRmWGNUdHU3MDRrdzVtWHlMR1JGNzU0R0w1?=
 =?utf-8?B?ZlkzaURRT0cwS244azBZbzNLWGtaak83QkthR0UrTGw5YXBGaE8zQ1JMdGN5?=
 =?utf-8?B?WkVyVnFERGR4TW90KzVMQ294Sm1GNmc3MWoxVTBCaFhHc1FrYVFDY2dwRjZh?=
 =?utf-8?B?Uy85aWFaWlVXSDVLQ29DZEpQalU3L3hoMWVPODVsT2JsSDRXTlBaT0JuMUN1?=
 =?utf-8?B?R3VNUERPamg2a0F6YUZWZnRzcHR3cFI4RDEyV1JROHh0eXBGeDRIZURlRmsr?=
 =?utf-8?B?dUtFTnp1NmNCcjA0YlVsQ3JiTGhaN1hSZWZSdW5INnFSZUd6TGVIS2R2Sjkv?=
 =?utf-8?B?Wjk0QndEcEpBQXZrdExld0ZVNXErQ0VXSVYwd0xYT3c3b0QyL2wvT2xXVm9w?=
 =?utf-8?B?ZUJvVkJSMS9GS1BsMjhUTFY0cXRISXNxOTBoRmdINWpSRnEyV0JkUElsd0Ni?=
 =?utf-8?B?ais0WS9aMkNyOEZrTjZac2Z3MVl2dXZyVXUxMUFJMitiZmhQelpScTBvKzQ5?=
 =?utf-8?Q?FqpxicBbTxAFq8vlIXEHgFZGbrigAMzSu2dZUei?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3pzWGljaHprNDV2WXR4RlpsNHR1bEY5VHpxdnRBQ3Fkd3dkdnp0Z1ZTc2lH?=
 =?utf-8?B?bUlVYUxpY2hEemVZQ0lQMU5XcURhWGZObmYwWDZQT3pjVTlTRDFacWIxZlJQ?=
 =?utf-8?B?eGZXNm1qVE9CSjRlaWhteExWZDFpcTYzMmtkaFg2RUYxN3h6cDRjbkFseVlO?=
 =?utf-8?B?QWh1Nkk2aXBaenpxRlovWXYwdWlReWlrVGduKzVVVEVFeDBOc0JVVnpWRlFx?=
 =?utf-8?B?RXR6ejZsUDdGOGxDSlVUV2hCYjZxa3lpTnhHMVRCemtxeXVYaEgxZWszN0t2?=
 =?utf-8?B?eDRLNTVSMnFwWnA4NlFpV1VraEIvTVlNQ3BVSy9oWkIva1FnMFpTN2Jhb0Ns?=
 =?utf-8?B?S1R4S056V2tHdWNsNFJCclBaRGFQSFAwSzR4WVFVY1JGazUrclBOczhUQU9O?=
 =?utf-8?B?S3ZyUm1hSTk1S29KVVRpNmJsOXNTenhRampIVmpuUENsRmE4Vnk3UmpPN0Zp?=
 =?utf-8?B?M3ZEMDB5R0gzTDRGNFpYZ0hGeTdITW1TQjFCa2RHTGpxdm9XNVd4dDNFSGxM?=
 =?utf-8?B?SWU3UnlkNG5QL3lUc3U1d1VMdHRveGd4WUg0WC9nVE0zVWRIdFJFTytZKzdV?=
 =?utf-8?B?RDBkQ3puNUtiOWFDSEpTQzA0SlVFaC9ZaXpSOHp5NGwzMTdUaEhZVTc0enRx?=
 =?utf-8?B?SUVvdEVpU00xc2ptbDNVelRoUnJZRmlrRVZxamJLNVhkNi9BUGJvRkYxN0x0?=
 =?utf-8?B?U256bHpyZWNQWnBaZ1duWnNFSG5JaDRtUlZEWW1ZemJqRHZ2OVVVOFFpUDRa?=
 =?utf-8?B?YVU4TVJXeFk5dm81REtBckNaNzdsbmgyUDZKajZXNDd2VFJmTiswdzVVSGQ1?=
 =?utf-8?B?aHUvNlp6RENaMW9mRXgxZmdsTzVTMlVDWDUwNlZ3SWJSMFJxRm5qNVpaaVdY?=
 =?utf-8?B?UXZyeDZnR0lVZ2kyd0svK1FGTHB1NklBRnhjTnpXZFdTWTZ1alJSZkZ2U2o1?=
 =?utf-8?B?Si8rV3phUTlRaFQzVTBINDZWMERWTUcrdUZncVpXSC9OcEl4STRMTUh2K1Vn?=
 =?utf-8?B?L1NwNmZLRmRURmljU0kxU1lNek1aQ2xwcHNrK2xBWHFEa1RndXI0d0QwVDZq?=
 =?utf-8?B?TFJZU2RBM1Bsay8zUXM0dlZrNktCMzY4RjZCdEI2ZWl0UjJpMTFTMGM2OFRE?=
 =?utf-8?B?WXlrcUg0VUJlMzVtdFRMOVg1TUg3QTQ3SHNsZWRqcXdvMUZ6cGVNZm9IcklS?=
 =?utf-8?B?S1oxaHJETVJ5aTM0QUE1NW9SakVLZXlMZE8rSDJ0KzdoeFRnKzJuTmFQbGds?=
 =?utf-8?B?eHhjSURDRk1hRTVSRGNQWlBTOHBGbVFRM01VWjhqM285a0I2NE5HeERqdFJO?=
 =?utf-8?B?RmhtdjV2cTErK0RoYVp5VUxsVzJyUFA2eTNJWEJFRE9DWWMyMnVNanVkRXB0?=
 =?utf-8?B?dUczZ2NhRzg2bWVjYjQ3UDlkSUc2Q0xFMmcxRU1aZjJJeGIyL3RDTGh6RmtS?=
 =?utf-8?B?UnBURlR6N3pmcW5BQkdjNC9CVy9TSGt2ZkdSY2pPdTBNWTk0UVU3QjJmYS9r?=
 =?utf-8?B?bXI5dVlwVE14T1JwZ0FLdnkzUm9qbGZacHN3QUhaUmhsWHZvOFRRcWtWblBC?=
 =?utf-8?B?UjN6b3VHY1RQVmhtT3dLbG9Sb2kvS21JbnJvL0tHT01pa0ZIVUZvQm5lTWJj?=
 =?utf-8?B?bWpiQVVQaFMraGt6S0w1ZmVHNEY3OERHdGdMVlAvTUlFTktvN01rRTVtY2t2?=
 =?utf-8?B?VWI5SXl6VnRJV1Jrdjh6N3VOcU9XVmVIM0UrVmhWSzJ2UkRXY3NnS1hpNmtU?=
 =?utf-8?B?bmM5UTh5UStOVSttNjE5WCs0MHkxcHZJQXNFUzh4YmxuMG96MGVhQVJtUUlw?=
 =?utf-8?B?b1o0eWRBQkdQazhXOEltazRyNmJCclFGVElQcURJSzFpUDREcXRKVVNqLzRo?=
 =?utf-8?B?Qm5EZkM1TUNkVWxJdVpBZllPU1p4dVRaOC9ONWNXVCtkTEVISlZJU0FtME5E?=
 =?utf-8?B?YWlOVVBSRkl1dzJkWEwwTk9kK2FMbnllMDFSeURXeWppOS9OczJYdWRRWlVy?=
 =?utf-8?B?Ujd2L205SThZM080RXBoRTNBS1NsM3VOSFg3OGdiRzdjQStUM1N5M2ZmcGhE?=
 =?utf-8?B?MGs5WXk2L3hKMm9oMm5USHBITHI1RnVBL0RhM2F2WHdDeHVLc044YnJSRGQ2?=
 =?utf-8?B?M3BpWjdGV1E1YkY2L0tzZndsMXFxSTVTWkhaRDNvYlVvb28xSEhsTk5jUXBO?=
 =?utf-8?Q?hkZP6ONRYXfhdnKP+WDnhag=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6848f5-4f82-4b08-2a0a-08dd0943fc0c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:16:15.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVlE5yWFWvbM1EgLhRiFgpgX+3q5jSU81cMaIO5hMIfkTQxwdgvgCQoEm0CrWpTAtPqMSQL9oM4MwmpT9jc7aHLS6hAcYKH95HSJC70fwZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9556

On 11/20/2024 11:01 AM, Marc Kleine-Budde wrote:
> On 19.11.2024 10:10:52, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add device type data for S32G2/S32G3 SoC.
>>
>> FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
>> management is different. This initial S32G2/S32G3 SoC FlexCAN support
>> paves the road to address such differences.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> If this flexcan integration has separate IRQ lines for Bus-Off and Error
> IRQs, please add the FLEXCAN_QUIRK_NR_IRQ_3 in this initial patch.
> 
> regards,
> Marc
> 

Indeed the FlexCAN integration on S32G has separate IRQ lines for 
Bus-Off and Error. I will add 'FLEXCAN_QUIRK_NR_IRQ_3' quirk into the 
initial S32G FlexCAN support commit as suggested, in V2.

Best Regards,
Ciprian

