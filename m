Return-Path: <linux-can+bounces-2286-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E5E9DE93D
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 16:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B185F282492
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB913C9C7;
	Fri, 29 Nov 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O+NpLIVd"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5B5A4D5;
	Fri, 29 Nov 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732893661; cv=fail; b=fvfnUIyhn/7e2LqQHJ8dhS262ikOPWZ4BsdeCbEhqUq2k5UQQ26bFXLFgZmI1NiNxU6zzmdjZwL1GVvUmYrxukbs6WP0eotRUjl5/2QFONR20g8YzhBuJqBEN8BjqEtyUpzp14df0vilerKZlJMeqYmhQotv3+X5VIAsNCOkjLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732893661; c=relaxed/simple;
	bh=GbBRxm4KnDEG4JE+0uhyzXaq0o4NcIhyj94nDnfoqCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M/GMDPrrWjZMIhJ1BKN1pCMA3WBCzGhz4TQNxClZfdc0niP1hpoBVQaYCiMtSkqxR0592q6Ni/fsf31b8J0X6JF+DkqLtJfO3Ik77U63VcGCj2UwCbpdwQCzMc6Jm3B1lLW03ZISvUg5jTnvFpP7ImWxGJ6ysZ3PaAgxyvTEqoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O+NpLIVd; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFedZU1BhzvL2Cv7xk5LsqdT9tCv6eFdo0Y5VjJEznCoYhiwlT2uXwUycF/dXKVbPbXgLQMCCTTW70rlSVs1vVMkisrxJyle2hSSftukHH7b4l4s0J4g+mVKIAOT53W7aVYQPF87xtI8dIzrDbwJOurpi17JrIlwqEuuGGhViUYm5aRhhNtIMQ8CKdS0Lt9bgacuRlXca5YCmMEKBWCBH6tN5CLJWlhFwFdDa+FFgMnu2XqYYf7BJyRH2BfL1CZodRv9ySeJqpcgh/Qve4lMq7ghA+uE2oBtdCqYRpeyEItrAOM7tQV1AkURl3ZDxwjUDPhgxVMj1GWsWIutOKYyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piGrOQlo2LHk2kF3Tl0WRYmo5DpLtV5NLqCoeLqiQrg=;
 b=P2zOuRmOaR+hWDqt61wXQ5CNlyj+pGTUScC7mbQX14RJ6Wtw+n89D+jTHPdiBlzJA36ATyLWljZ7rw6OOEL/oXvjv+7ySqG7LzoLe+ghtNgZVadWGDQ4ZE1LdCaQlLx3p0u96enHDmTdaNSlleQi3jLl7OOeCxSChwyl63c+aALxpS2vuC3iIsywcnYgU2gJm/RfGHE9rXGk6ADkpFiilqRqJoYn4z4d2ctteNTL4oVB/k1v1eyPrQJahdtnrsZ8iGkj13B7W54dimyHveEihrJJ7p6rI6icUac9MkbnlFdDfE4l+C41PY1BgK4tCJBjQ3UG1KvO51FDri0ckbtscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piGrOQlo2LHk2kF3Tl0WRYmo5DpLtV5NLqCoeLqiQrg=;
 b=O+NpLIVdRNYgd711BHQfhp3hCI+VnogDBQ1ut/UBIIhdXmVk8zxhsvQ6DNBDaowHiEIXYeq4zuKlCrSoS92HSbHjhRkg/gHEKgT8aYGN5NpOwpLTUQYwevlx9l0ENIYMgn/wR2ulbQ0DZV7k1MaCO58Cf/heeIS46dVbJAz8E2fnkw6QNsrJpokIHiKeevOJoHzIWPB/nJfCUhmKnWPO5pCllMk7qcv/Gq7nTXFpxHDm2OUV4ulguPwIMFXVRt/rgmb5Iw4q+HZhJrTww4oEyNbXfrWVh0EcnUPMhHNMximj4f7Ws7DbJjYA0pBrFeq0NDs0I7UQt3cIVj6eDkge0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB9175.eurprd04.prod.outlook.com (2603:10a6:20b:44a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 15:20:54 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 15:20:54 +0000
Message-ID: <72258a57-6c65-4885-af00-0f18f27239e8@oss.nxp.com>
Date: Fri, 29 Nov 2024 17:20:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
 <20241129142535.1171249-2-ciprianmarian.costea@oss.nxp.com>
 <20241129-ancient-sloth-of-bloom-077ab2-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241129-ancient-sloth-of-bloom-077ab2-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::32) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a2b8f5-b26b-4583-d983-08dd10896a6f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW53RXVKVFpwUzJLSnl1OVo5QVBtQUYvNjJJb0VWeEFWQS8wSUFOczc3UVVW?=
 =?utf-8?B?bGFKMmw1TytnQmljZmg3TnhKQ3JzQ2RkbmRMemJzcEkxWXpPRGVpUEdyTzhh?=
 =?utf-8?B?cDhNNlpPYjJuZWEwQksvZUJTNmVhUFhMdU01aHVHeDVaWVpUMnFpbCtMN3R4?=
 =?utf-8?B?c1I4RkgwbWJlVnFoSzZlTEw4SjI1TmphbFZOWGtWaVlZckFOd3JsVVhjSTBm?=
 =?utf-8?B?OE0zcHlwMDRpSEJtaGh2NVRvSmJLbkQrRTBKRzFGazlkY1MrV01ZNHBtU2Jy?=
 =?utf-8?B?bCtEa0lmWU5qWi84dFJ0NDRFa2pFTm9kWTJLSFg2Vit0MjhNTzZCSGppZ0NF?=
 =?utf-8?B?T0RmNDZsYVZaQ29iQ0o1TGp3bmFoN3I1aWM5cm5iN2Uxa3N3WHhmYnFrVk5v?=
 =?utf-8?B?MlF1MXdmUEVXaFZFZkVQWlo5ZGpuT3lyZHNZSTdRZENaYXNOd1Iza1VyNFp4?=
 =?utf-8?B?czl6V3AzNUduSDd3Ulo3S24zenBWQnJKbUk1ME9jTFU2Ym9VS1RaZnlSejdo?=
 =?utf-8?B?emt3d1YydkFVa0JpUXFKeEJ6aUFTN3I0bFBpODJXamhmb05IVnI1MDhiTVp3?=
 =?utf-8?B?K2V3c0NzOW9GeDdhVmhJa3RqdzNjd1U5Z2hXUTZSU2hGRW1UeDFVbWhXUnVW?=
 =?utf-8?B?czMrZTBnaHdyNWFEWjE3SlZrTTlxNjExZDM1U25aOXc2SGgzYytUQWREYktV?=
 =?utf-8?B?alltRHQwVlA4M2dQQSswMmV5Uk1hbnBEMDl2QXd4S2dQTkluL2ZNK3hMODR1?=
 =?utf-8?B?T0pHTUI0NGJwaHltazc3ZnA4YmtlLzdlQlIrN2VVM3NRcXkweGF1MVVoYUhr?=
 =?utf-8?B?UE5QTlJjZHJpQkhONCtKWThnQmpUOUpTR0ZEdUdPcTFNV0pvektQSGc4MW9R?=
 =?utf-8?B?WFFNZ0p5OFJrVFNUU0dKbW5LMmNreklyakxUdjl1QStKeCt2VHVZaEE3cjBt?=
 =?utf-8?B?ejZtSHBGdVB0WGs3WVZjZVhrQklZYmRIY0kzSkRWVmFYUUFyM0VpUWJDYjF1?=
 =?utf-8?B?WEJnT2J2TEZ3SzREd2d6VFFHbnBWZU4xR0Z1bXRGczNRS004K0VvTXlmVWZx?=
 =?utf-8?B?K1lobktsREMwRnJkamRlaUp4cVZnRXNrMkkxcGU2QnV3WGxqZ3JsWEE2Q1FW?=
 =?utf-8?B?OWVjNFNicFA1YVMwOXlHWHlITkR1eXltd0I2ZERocHlZU1JXblg3Vlc3TG05?=
 =?utf-8?B?anZqK21saXJWY0xTQ1U5QjdNU3NnTFJZSTJqUTFsdG9rUXV2cWZQeE5FT05U?=
 =?utf-8?B?cDk0bCsycDQwVmN4eVUydTdDZFJkSlZGSWthbkp3YXludzJoNUsxMUI4cUli?=
 =?utf-8?B?T0kxaDhTc0ZPSyttcjNVQXFWZnFmZVlqTVpCRS9uVlpFMlhtSkhJM2NnTkhM?=
 =?utf-8?B?Ty9OMlZiSUZnaGY4RVhDbjFDUTI1TFhlQ1p1N29SY0hZdFBrUXJ4amsyaHI4?=
 =?utf-8?B?THpyMnlFcktkV2hOdlB2RjlKSExDcVNYNXBUSHZaV1lQZ2RISEcrQXU1eTFy?=
 =?utf-8?B?Ymhhb2s2ZkFWNkl6RU8wdnllaW5rTkVGd3NiNDUxanZTTUpMTFdJTFVUcXlE?=
 =?utf-8?B?QkFtNGozSkw5WGdRVmZnVXlZRC91cnBVRm1lbytWQVpDbSsyR3BvNktXNG5U?=
 =?utf-8?B?Z2pDOGFkQmVSOWhMcytmYW1iVGRvR2hlUUpvWlc2c0lOR2E1TE1oa3UrYktX?=
 =?utf-8?B?TUVRaVRQUVNoYzVsdjI2ZTh3Z3c5bmZYaFRqNjBwazNkNnZDam80aDBNZjFG?=
 =?utf-8?B?S0pjOU1DclZwRzN3MXJTampsOU5Ic1Nndi91TWdUQVZFdUpTS1NBM1VyNVQx?=
 =?utf-8?B?U2tQVlkxZE1iaktxbkZKUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWV2MkU4ek9FUStnTnNXa2VnVzF3bTVTSytFMFgvelYrWEZ0SnJta282UlJN?=
 =?utf-8?B?WXZEQ01mRWRhQy9HL3Y3VTFIUEhCa083ZFZjSlpsWWQ1dHgrSUovdDFFUUw1?=
 =?utf-8?B?Tml5VXdXM01CckdiZDJUZ0dlV2VEUGJFWWh3YzNSUTdvMWhpQ3ZUT3ptT3VI?=
 =?utf-8?B?bXN1N1NYNTd4OG5kZTJMbjJvUE8rdnlHc3pHWjZjOFAzK3ZXdGsvTVloOUJN?=
 =?utf-8?B?MytxMXhWME1iRWNxb29tTnZPR0pSM1phZFNUeHVGTkNnY3RiVDdwbHRBRWxQ?=
 =?utf-8?B?S05kM0U1QnVuUHNSSG1wUUwzVzIyNjZpaEpNbTRkbXdyQjJobjJhWkJkTG5H?=
 =?utf-8?B?NDhVeklUMldkbkEyd3BZeWNqTWNwdmFHWldkcFEyK2xEbzhOdzVadmJKV0lH?=
 =?utf-8?B?MjdjV0ZncE93alNvejg2WW4vay9jdFlUMFRQcGhUM0pVWDhMQi9FSXRWN0xQ?=
 =?utf-8?B?Wkxja25PUGRGT25QbnJPRGdmVC84WjQ4cGZPSEg4WG5IanNJRVlic09GUGsx?=
 =?utf-8?B?VjdyM3BKMXFCL2tKSmsrd1hCY0xYRmt2TTZjS0d3dmZqZDZ4THdQaDMyeVlJ?=
 =?utf-8?B?dVNDU0w4RXY0M1JxemJ0V2JIRkI3djUyQWxoaVpUekU4NU5XWXhZWnhiSlJn?=
 =?utf-8?B?K1lCbHpqR203azlUMWJPUjBCMnBFWkxrWWNUZy9IUEl6bHlZOVU1cDFMOVN4?=
 =?utf-8?B?ZG5wT2pUb3B4NkRUNG1UOXB6eGRBaEVFYzhoeFEwRnJESnFxNVZ5cXh4TnZZ?=
 =?utf-8?B?S0twQmg3T3lpKzVuejJWRVNzd1ZSU1JvSTJYcURjVHN4YzdPUHVnMFd1WDdV?=
 =?utf-8?B?T0RUdlR3MmkyUkJwaUgwN3B5ZEg1bnp5YVM5ZWlsV2s4ZldJaENselRaMGY5?=
 =?utf-8?B?dzd0MUJqTlhrUXZoSzZCMVZ0MFJkUlZDaHZhekdnRTRGbDFEOGNmbVQrVVlp?=
 =?utf-8?B?cnErV05CRnpET28welJqQ1VnQkw2eTlJeFlWeGdDSGw3SFcrUElqOUFZY1lk?=
 =?utf-8?B?aUFaaUF2TG1kcmhHVzdZV1EvM1FhWkVicmFYNmZza01OVHYweWxLY3NTK1hT?=
 =?utf-8?B?YWJnVVd4Q3RnQy9kWnlhRklTOWlHWjJoRnVzaWpkT0ZGM051VUpWcDZLdkE1?=
 =?utf-8?B?NjNZS0puZ05iZzFsYytGcE4rY2VXUnFaME1DQUNLS2w4cEZJdDFIbE1WMFUw?=
 =?utf-8?B?K3hLM3lRaUUxbDhnMEV6amNVOEtOVm9hbkh5ZkY1em1nWWt6SmhVenI1cjZ2?=
 =?utf-8?B?TEVXakRFekVyS3NMeDdoaVhPM1VidGdQaUtPTEhkNzRLTUNobmVLRzh6Wno3?=
 =?utf-8?B?cGZQRjlxUWFVVU9kaDZZb3h3cXd1d1QvZXBNNkZxZ044MmEyUUhTTm55Ykxi?=
 =?utf-8?B?YTIwSk9Sb2V3YkpQVEZvQ2Y4bjRQWitSR2NmMytQM1pISndxNnI4VjVVZGJH?=
 =?utf-8?B?ZXprREVaOThvTkpSVXhjNVQzMmxGM0UyS0FWUlI1Q1p4V2gwditKRnpRZ0Vq?=
 =?utf-8?B?dWN3L3diaElCWVowVGhuRDlXeWMzYU44OWdvNUhleFZOUmxjTnNuNEdNR2pT?=
 =?utf-8?B?VVFpMmtnM2IrT09xYjByc2IrTWZPRUdxVWJkbVVlQVI4dGc3OFMzMk4vblhC?=
 =?utf-8?B?MXF6ZDdNc0VCMktXTnFFT1BQWlJlMjRpSlQ2Z3RPV1R2UmJidTN4cGhBc0to?=
 =?utf-8?B?NzV6SHNkQ2dmeHp1am9UVFFySG1ud3NmTnJVdDRMV2lKWG5jM3kvM0Y0a25n?=
 =?utf-8?B?N2VITU9Jd2h2b1owamgrZ3BWNEhtcy9tTThnaWpTYkpqV2lSTjZiNllJZGxa?=
 =?utf-8?B?MzR6ZVI4ZDRLako4L1J4eU9ROGZPQU1ZcEZyR1psdEVpRUVrcTNrcWtydDEx?=
 =?utf-8?B?YWFEbmZORjJieVhLQ25PQjl1OWxqZ2NNNHZkT2F4ZDFEWDFqY2ZZSWZDWHU2?=
 =?utf-8?B?UjdHanoxY0F5aXNFYzltbHNkaXlURWg4TThWbFZ6WjZiLzQwcWVmQ0RldHlo?=
 =?utf-8?B?V1FlS0Y1VVZpRFN3V2hvdEJpdGlsRnNOVElhRWQ0UzR0cjNuVER5T3ZUcXg3?=
 =?utf-8?B?bFNhSGlSUDJjTlAyMnlRcUhieWFTNC9xUWZDbUVva2FxT1E3bnNnVUxFMVZn?=
 =?utf-8?B?L3lkTVV4eCtpT0xLTDFOdGZNallnS0h1OUZSMjdFMXNYRFpwV3ZjaFdEbzhl?=
 =?utf-8?Q?07KjSIyMK9jw9jw9ZRlTWKc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a2b8f5-b26b-4583-d983-08dd10896a6f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 15:20:54.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwfMvxANAu33yz0DPtijKyKJXJeYuAg8WDikLSVi7/UEu7kINgP9Y2L+AU+q3HTiy+a2Hzm0OQUXHUELrgsln8yMsRTz1CJAIxuJK2fD618=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9175

On 11/29/2024 4:37 PM, Marc Kleine-Budde wrote:
> On 29.11.2024 16:25:33, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add S32G2/S32G3 SoCs compatible strings.
>>
>> A particularity for these SoCs is the presence of separate interrupts for
>> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>
>> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
>> same restriction for other SoCs.
>>
>> Also, as part of this commit, move the 'allOf' after the required
>> properties to make the documentation easier to read.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
>>   1 file changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
>> index 97dd1a7c5ed2..10b658e85ef2 100644
>> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
>> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
>> @@ -10,9 +10,6 @@ title:
>>   maintainers:
>>     - Marc Kleine-Budde <mkl@pengutronix.de>
>>   
>> -allOf:
>> -  - $ref: can-controller.yaml#
>> -
>>   properties:
>>     compatible:
>>       oneOf:
>> @@ -28,6 +25,7 @@ properties:
>>             - fsl,vf610-flexcan
>>             - fsl,ls1021ar2-flexcan
>>             - fsl,lx2160ar1-flexcan
>> +          - nxp,s32g2-flexcan
>>         - items:
>>             - enum:
>>                 - fsl,imx53-flexcan
>> @@ -43,12 +41,21 @@ properties:
>>             - enum:
>>                 - fsl,ls1028ar1-flexcan
>>             - const: fsl,lx2160ar1-flexcan
>> +      - items:
>> +          - enum:
>> +              - nxp,s32g3-flexcan
>> +          - const: nxp,s32g2-flexcan
>>   
>>     reg:
>>       maxItems: 1
>>   
>>     interrupts:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 4
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 4
>>   
>>     clocks:
>>       maxItems: 2
>> @@ -136,6 +143,37 @@ required:
>>     - reg
>>     - interrupts
>>   
>> +allOf:
>> +  - $ref: can-controller.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nxp,s32g2-flexcan
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          items:
>> +            - description: Message Buffer interrupt for mailboxes 0-7 and Enhanced RX FIFO
>> +            - description: Device state change
>> +            - description: Error detection
>> +            - description: Message Buffer interrupt for mailboxes 8-127
>> +        interrupt-names:
>> +          items:
>> +            - const: mb-0
>> +            - const: state
>> +            - const: berr
> 
> Nitpick:
> 
> - description: Error detection
> and
> - const: err
> 
> or
> 
> - description: Bus Error detection
> and
> - const: berr
> 
> regards,
> Marc
> 

Hello Marc,

Good point. I will change irq description to 'Bus Error detection' in V4.


Best Regards,
Ciprian

>> +            - const: mb-1
>> +      required:
>> +        - compatible
>> +        - reg
>> +        - interrupts
>> +        - interrupt-names
>> +    else:
>> +      properties:
>> +        interrupts:
>> +          maxItems: 1
>> +
>>   additionalProperties: false
>>   
>>   examples:
>> -- 
>> 2.45.2
>>
>>
> 


