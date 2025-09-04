Return-Path: <linux-can+bounces-4473-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D742B43605
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098E37C1A39
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A82D47E9;
	Thu,  4 Sep 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RyNJzheB"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB552D0C70;
	Thu,  4 Sep 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975084; cv=fail; b=r4AdtuTUhxAzCqAbeIDp+XQ26vdT0Y/Iopsb2kSakZNeU6mBqP5IpYr69TUxABEStdSrBI2AiRlt+sUhOgaNVLOJf066kDluqV0SRZ85iRmv2KH1x4uyZon6SpPxv+qbc+z3T50lFsSzy4dA9eZBnX/rAuFQmga9uqBCZisWuCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975084; c=relaxed/simple;
	bh=7EzhB0LnPGip71YTTGnvX9hHZzkv/sdm8MVGPlZrRHY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZNpPYuWo88A//2PU5ORYhOdnd3ixkED2aiP4CQFHgwLPI/PdNeabMocFT0glb9Zexg9KlYf6tIgitfNcvzIhaad3iAcGzUmeYtMANnwBYglk33TOBmI4iNEEAAfdR5YEoEYiVhdtdZ6DSgIFNtcch1j/IPjzEdwAhFBvJiUvcyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RyNJzheB; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox6wXOFprAcwH1BGhPqfrbATKHSP8iOAJMR8rT6hFM2mRlcrG0fvja+0LSvdAb9lQ8d3RBHDoBcOPP11P4r7tbk8SzO4//76T/Cz+TYF0c/OidetwnhS2F54lFXqqn5cd3Xe6dhxXzl69Kirrtw4TNiz3sYOg3Vz92CO1dNYEYUGOiWipMqe2JbGH9qgRvrdbpZqQ7wwZyDTY7bMiNBa0GNoIDwcgyDQBDOcRzHmV/+wfuLF+k51v/8e0f5xdsLX+G2EMdg89GhvyiJRJ24fBPiK13OE341XaWmbirDPi1VDOfLJP1923Wn8rKWR2UeT5VYeQOmkP/5yGC/DGnnlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gcfSIV7MALdS9CCv3HPcM2vbeSjmjYNNdAIysx2LAU=;
 b=Bvv+JrJEIB6ZTG6AgPdE/H5q2+AtTnKGjddH76kTN7cuExNadBn/HVQNQKz38GHj+nS9H14wGJosmD5wHXnh8OGgcbKRMIorl2Wxdts06u5dmaTWKw1e8knLCuc8ezwGNCbVCCn+HPaQEt0kIbp3Psx+2+BEu7nyAwSJZl3LW2dL+YHpuFor6/VQ357MpqIcv7jPoPfCPQMmv3QFdj3Zy3rMvxGiNt4kSo3SI4InttVKtih7sZR4dQ+XRs8gYMg45z6Wr6y+BDByfnZNLgJGH7hsDyqEQTjUyQhwJQ6a1+Y3D8Skw7nC6L6iYTAMX2D+gbxzKJNzn54s9QZikwWJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gcfSIV7MALdS9CCv3HPcM2vbeSjmjYNNdAIysx2LAU=;
 b=RyNJzheB35qfa3Z1oANGSvOAfYS381PHvncQZpNIhITr3mtOGcAmmfrlI9S9TD2lytbivavFQXN758zgllDROmqU6RNvEcwkbmEwMiA3+BqGn61mVAhSz8HCL8y9XLywWJkSq8bsF4frmxeFWF8DBLYNqdUSoqCbMoQEwRaC09DEbUB5q/U6XkETD3u9lPhDsPFfBRceFsCJ7JaSd4p3/SP36H31YwdnzddvxJcSzARNpyyhJSEJHz7W3J0O8NNwF9QmDaBpkyKrTVjPia31F1KcROMhMCZWV3/0i6E2HQEsQxFPUpRjs3+tWklzFUImCq1WG+GTIuu3/zfHETglWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:59 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:52 +0800
Subject: [PATCH v5 9/9] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-9-23d8129b5e5d@nxp.com>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
In-Reply-To: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=1695;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7EzhB0LnPGip71YTTGnvX9hHZzkv/sdm8MVGPlZrRHY=;
 b=visKBKrIpqpLybcG3aNRPKRPWcGjilZu69naaowo9JK0PBwe014F1mIUpTkJJbwZv7jvTdWeW
 4hV0gZru8BxB6dgTwgkiLzKHCGpxk0paICBevAblawD1LdWWiB+it/1
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 454fdbe0-f00b-4d5f-2624-08ddeb8e5ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUpNVzFqQW5SYUpCNVNXY0NiYUZUVnNFcmczbjcrWnY0UjlGbkpuYkVXLzN0?=
 =?utf-8?B?ZnNYdFJwdU55aWcwNUg3RzJCMzlTeXZ0dWNqeHZ0bkVibUdJckVKYXdoSHV5?=
 =?utf-8?B?dWk2VFl2OXBkaG9BUDYrMC93REhvVi9OL1dNelNvRFhCanUvTytsTE9mUVlL?=
 =?utf-8?B?bzBzYVFSUytsdHV5V1JIc3NXaVNMN2hrRjBQcS96VDBUZWt1ck9vaDdEcWFj?=
 =?utf-8?B?QUNPUkZ3MzZTajZ4U0R2dk1vdjl4ZUtrWW44SnVoN1l2NGh2eHZRRFhVOFlP?=
 =?utf-8?B?WTRIamNqUDYwTjZES3o2Z0xQUlV5STVpVC90cEJzM0ZJb0xqRWF5UWpqNVk4?=
 =?utf-8?B?YjdFR043TlFIODVYelFZOUVvS1poek9TaHN0N2I5RlRaZFBUdmoyaWlPOENv?=
 =?utf-8?B?bk1QV0ZMcUxObVFNcnQ3KzdaUmZrVHhSeXRqZWZYTnJCME9wZXgzcDQxQlA2?=
 =?utf-8?B?S216c2xYRzg4amJuOEZQUzNmY2d0b1ZzOEpBSFQySDhVWFZFOTh2d3NFRnlp?=
 =?utf-8?B?RFA3dUtPU2ZsTU5qd2l6REJKWXphZHhJVExRYkxxQmgzZ0VZRFUrbGxpRGdZ?=
 =?utf-8?B?RGxmWWJTeURHNGhJaTVPZEluVjZJNmFlWFhjLzNLS0J0cjE3V1RqMzQ1K3Yx?=
 =?utf-8?B?RDA1SzdwRnNnS1NnVjc0dlFhNStWVUJib0JaWHZNUVBOZTVCVFlSZUV4eDBQ?=
 =?utf-8?B?bFVxL1NNazhjcDZPV2R3U3NqRkxWaHZ0dzRQN3FINitIS3p2bFJTWkJZL2R4?=
 =?utf-8?B?QjFzUXpYczA0dmpFa1kydmxLbVZHdXRIMTNUeHlWNDRldFpFYkJpNERtaWFR?=
 =?utf-8?B?akxlVWExbnJ1eXc4VHFVTVFQNk1wRlR1UGJMSmdSUm9uNk9CbmF2K3o1WkIw?=
 =?utf-8?B?Tjl5THN3eCtOSUk1VWtJeTc4bFA4cjByK1h6SnVVRVlRandOZmFLSUVaVmJV?=
 =?utf-8?B?S2lHU25LclRoOWpQSmVPemQ1WDN6ckVJUHRFMUxZT0RkN2lBR2xEZHFLbTZs?=
 =?utf-8?B?TDkvcWJJS0JOVlpXUUZlOGdycEFEVHpzQmRIaDIvU21ESVlsbytxQ0ZEelRM?=
 =?utf-8?B?VXpjUXdNV01BMC9jSVhTVGVoeDZLY2NPbDNicUlnUGIxR0dvTnlIeEJSZDlx?=
 =?utf-8?B?c29mRmNuRi96MDhqdmh0bUVVTGl6QjNTYWN3S1pkUHVoMHJ4NjlCY0c1UFlM?=
 =?utf-8?B?ZDB3bFFkK05FeHdhUlMrSldWenVpb1NIb090QkE1QlJxWnhZME0yY2RvNUJa?=
 =?utf-8?B?ZlBORWI4OThocXc2TzVua1lvbWtDb0ZDZ3ZiZ05Cd0pzTlNaSkxzMHZSY3VR?=
 =?utf-8?B?WVdSNzh3TVN1dnZwcGVUV0QyeVJEWkZqNHJRUXdPTVdpcVk0SXZZdTJCajNz?=
 =?utf-8?B?UXBFRjlqWER5T1NmODFNOG10QVl5VHJpR1E4RlJmSFBna3QvTnhpeHNNM2lQ?=
 =?utf-8?B?STVzbFlGRGp0Wm5ZVUo4WERTSTFkUTc3UDI2RURTNTMvOHA0SlhrMFUwejh1?=
 =?utf-8?B?WUZpWUUwRzZYbk9FNU9POHE0elhyZHZZOTN2amZoRWRsUE9HZ00yVEFnUkRw?=
 =?utf-8?B?cm8wc3d3cStKZk1JVENtOHhOWGhSaWM4ZlR6bFhLei81elNBb3NBekYzSG9Q?=
 =?utf-8?B?MUYzMGdLdG1sNHYzR25xbGRXN0lUeUlmU1hJSnBITXhVd2VUK3B5aUh3U0E5?=
 =?utf-8?B?aE1uUzZWdVREV0dxdFVKcjFEOTU0RjFPUUhZenNMMEs1SDJxbnR2eHJLQXlx?=
 =?utf-8?B?MXVpSjI0VXdORXYrVE9UMS96ZWxzS0V2ZStRY25IZjZhNDJ1RlczTDlEOU1Z?=
 =?utf-8?B?aytnRzk5NDRHdTYzRzBkMGRpeFpqRURmWlpMOXcrajd6N3p3a21PUnpNMnJQ?=
 =?utf-8?B?SkJsRHFVWG1wRmR0ejlwRkRwc21uUEY2MEVoR0pkUUw3bE5Ldm1EK3JjdEtl?=
 =?utf-8?B?dnhpQUI1b3YzY0lURlYxL2tFQldEb2FyY0xKa295cXNwUGJNMXg0VURjM0VV?=
 =?utf-8?Q?zp9UigXK5qBwy3Yyu2836QkuV1oU0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEtqdlFGZGhKVGd1KzR1RUtKREpYSm1jMlVtNE5HbFR2N0dlL2NlNFJqdDdD?=
 =?utf-8?B?YTAzYmt2U0p2WGs2NGFuUVFCRDhqeDZPN3lwWXpSVU93MWRISWlMS2M2RHNy?=
 =?utf-8?B?Wm12V2xKMkFqWjBJU1NvVHFmYXg4Qmw0NjcvM0crdkttNWFGY2xxVUYwV2VU?=
 =?utf-8?B?djM1QjBJM1dvZTJkeUl2d1JSdng2cXZKb3NZRmU4VWV6cHFZYTFzdEIxYUV5?=
 =?utf-8?B?UWxwY2k5b2JUaGl5V05tSmo1SSs3VDVvSEM2RytvRDRwQ3JKTitZZCtQOCt1?=
 =?utf-8?B?dkJySmJpWEZlaFJpRGZRdDRscWJXUjhBbmJneVZEbHhTMUY5UnpZNWViSTRL?=
 =?utf-8?B?ZDl4bHJoSlRhUGJycXNPNTlTNldqQTN2RUE5Vk9qM0c3TExwQUVFZTVaYVB0?=
 =?utf-8?B?Z0JsU3BPZHpTMEVXME9DOVdPN290NWlFNmFnMENkUHduamgyY09Xc1I4UGwv?=
 =?utf-8?B?aGJvVktlQndCRkIvY3lwZmpYbm1BdTVUVkp1RWE1VmR5Tk1tTERXWEhnMUo0?=
 =?utf-8?B?QUVYMlJzaE9QM0xSQzdzeHdaYXlYMmdkcUh3YjRXdmg2OGhlcWhNVlU1Q3gz?=
 =?utf-8?B?b0VKUnFzUlpOajcwcFIvVktwUzRJb3krV29zMjlldmJKU3IreS8yeWE2cFFI?=
 =?utf-8?B?KzFXYVQya0ZDdkdWKzcyWEFJVkhOUzloa01ONDdBTiszeUIrRVhvYUxXZnhp?=
 =?utf-8?B?cFE2UUFmN2JwcG1pVEdQb2FOTmx0Z0tJZ2RUc3k5VUZqVG5BVm54aUlITFhV?=
 =?utf-8?B?OE5ZOU00UUdXalVoeUJteUZJM3hpM0Z3SFY5UVJZNkhnVUUvclVqYXpIRzJO?=
 =?utf-8?B?QmxXUS9mRVh0ZXZyUGR5U2ljejJPK1N5cGh4R0d3UFJUaXdWcjU4K2E2ZS9y?=
 =?utf-8?B?aFZqcHZNRUxUOS96N1pZTDErUzlpSWVOVlVyclNiOGNpYVlCOUFCL1doclVT?=
 =?utf-8?B?UEx0NitMZm1KWUI5SDkwanJJQXpzR1NuUnU0MWJGMGIwZ3kvVzJaTXJsMTRF?=
 =?utf-8?B?MS9ta2doNkVRMTQxRUMxS2E0cmhsVlBxRkdtVVNuVnlVWmdJUzR2Znh2TUJk?=
 =?utf-8?B?NDArdmUwVHo2djJEVCtteStuSU1rTjV4b0k3akZNMURkRkcxWEZCa0pBek94?=
 =?utf-8?B?RS9nUlQxL3VkY01lSWFBRlRwVkZ0MnFPY1dQN3ZsSytVd29nejVkTkFKQURB?=
 =?utf-8?B?RzdLeUJEVlJ3SW1OdHY3TnV6NHYxVmh4MTgveXF1ZEFCV3YyYnJxM2pyS2Vy?=
 =?utf-8?B?R3Uyem1VTnpLT0lEcy9QL1JDUzhSdWgvRk1lOUVvUG1YS0IzbmlNRnVUeTVW?=
 =?utf-8?B?RFV2NmUvUURhc1BaK0t0M05BT0d1Y01xRVlMZWRZRVZaYkoxbG9DQzhjMXAr?=
 =?utf-8?B?eEhrazg3Qms3YkpqUmZkYmp0Uzc3YkdyWUhCc3VpWTA3L2U1ZFM0cEtJNTJG?=
 =?utf-8?B?SW9SdStJZWVkYXpmMWtORTNDVUVkUHBFV3FtMHF2eEJkLzYzYk5TUG9zRGJm?=
 =?utf-8?B?M3dITXVma3VuVnV4WFFoTkVCY2pVdWdNTVBHR0pGaklCRWJWNG80RW5lMkVo?=
 =?utf-8?B?Y0lJTDc4VHRHWENQcXF5YnBZU1N2THFJem44UmQxMUVTM0ZCaTdCdFlScFdk?=
 =?utf-8?B?YnJyTkhydmVEQmljUjJXc0RncEpSNjAvTzFWN1hEckZCeHBVYlVldGZ4K3hq?=
 =?utf-8?B?MVZpYkFqWWdJTm5uZTlUdGFUSTZMVEticEV3Y3hmUWxCV0swRzlheHQ2TWI0?=
 =?utf-8?B?b2oyLy8xT1NGMkJjOEhZclFJcjE1ZWhMN1l1RC9NY0p3dFhoYmFRVHlOdjBP?=
 =?utf-8?B?ZWR1anY2SkMyQnByaGY5VmNNT3ExUmFDRnM5MmVxc1A0VlEzNm96TnY5S1hh?=
 =?utf-8?B?YWg3M2RCa2JlSFgzeDgyUzYzWG92YWhrZlVObWUrYlZVRkhlMkNHMmhvTEUx?=
 =?utf-8?B?d1dmZ1IvSHJFTEk5N3FoazVjVEpDOEZ0N2l6VGlpOXhVR2I4eGFFMlgxT2h4?=
 =?utf-8?B?akRsRnc5WkcxOWJXc2krclVZWGwrT083TXhEK1pIMWhsbHByQVQ4RXZySjZk?=
 =?utf-8?B?UTE2cXhjL0RjVkY5U2tYOTh0b1JGN1JPdXNsWkY1Y2ZTTFBvcTBaRzVXT0VP?=
 =?utf-8?Q?/NVkBfBjrhmuYE8lHG0emDeDY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454fdbe0-f00b-4d5f-2624-08ddeb8e5ac1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:59.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so7S5/ap+YsAObbv3E/GsZYuD0o+a4oJRzhckW9A3L/7mDfBIL7nGwAy5pxjPOSX895GGy6JoLJTI+cPTzer2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

The TJA1057 used on i.MX93 EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index e24e12f04526c3a08c0bdc6134297fb010e6e926..19d63f7efdc51bb097c6e51bbe7bfaa533218ecc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -62,6 +62,13 @@ vdevbuffer: vdevbuffer@a4020000 {
 
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1057";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		silent-gpios = <&adp5585 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_vdd_12v: regulator-vdd-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_12V";
@@ -87,14 +94,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can2_standby: regulator-can2-standby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&adp5585 6 GPIO_ACTIVE_LOW>;
-	};
-
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -284,7 +283,7 @@ ethphy2: ethernet-phy@2 {
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_standby>;
+	phys = <&flexcan_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


