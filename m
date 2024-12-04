Return-Path: <linux-can+bounces-2322-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2800E9E3527
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C7EB32699
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804F1F75A1;
	Wed,  4 Dec 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W1y3dDai"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2E1F7070;
	Wed,  4 Dec 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298576; cv=fail; b=Oc31Cza6JgLWGmh6bbGPv5J+BsgBGM4EErfSR7bZJg/touoKoWqyW4Dqs20K37mJv1YR5DqAumwj47jzwg+WyURlpOS7++77kCaGUao6AcHfv6qb4Eq6m0eQbnrharXRztcFM4rn16b1BGqA/AXv39ioe7msMxo1IwcJc55NEy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298576; c=relaxed/simple;
	bh=z7sgzUHJzovVRjZcaYrA+17RJo1kqu7VsOOZWWx1Ykc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n14mKMakIBayme5cH5cBYW6rK+ipCXH3491/J7sNrttgAqjVdYeaZUdihgkMtmrCPFe9y5uMbLOzEBpHwF/DgifvPlcRr/g6hZtxFhBiGPCfYJqnfxd1NDJdni8qQyB26Zs4MDs4BCCYG47wrHJWgtQXxf1/K+3WRpAdVX+BhOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W1y3dDai; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jox82fmJI7F03/3mMk5Io75FUPGweCBUU0xct2fNOMQyduRjQD5djsFI/Q6vLQSO9pbAkYGd+HeCJ8jr3v8WHYEUP7h0rI9CLRJac5BhyH+D5l2H2XFa6YF/oMsQrbGvhvCw1MbQc4NM5CBkbWfXot0kSq8wET3jf8hUu2H/fNs8dkcnnn0xqGygfgpl63oDZOhdp9viprVTMKsSnkX6r9J9gs0/fsnMdozQoHFTW40q93jK3D11Da8Mw3MywN9RpyVqtb2OPO6yn0pZHMajtv4ZkzWSnpKhpMURUZSq20tea1o8AVsb99iPx+ZqaIIkD/Ttkdd8nEN+AP8KzubHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifRbbYsxVD/S/XeUi1nthARbnHnUTln9zsV7Ng5LIrM=;
 b=ZkN/xoxSTUbB0hxYm7negwS6wSMQdj4t9GLlTpKMWEUQxLvrhn3tvpDlo/sAHPFORhcjH060TX06hpG5QUInXygTh6/NKmVSxsossl6LRc8XrjHhg3PMNxmB3Qcsb1wwcHfxuiX1+IieX3aHuPKF38FRjlakSpH7QYVUBoMR6dUne368BwkqEBQhnxNYWH6zAkAZhq08aBofYaDcUSczfXzvNOjocHOD51XmXQxgMq/7pZvZSMhULLBJ2j7wMwEZGRSX2FDdL5IE19klPaO6ttHX02gk0GNnm+jXJGf+Ak2OI8Emq1VkSVXncQNBDRTX338Nx6tO0ziGULhdtBLmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifRbbYsxVD/S/XeUi1nthARbnHnUTln9zsV7Ng5LIrM=;
 b=W1y3dDaiLl7OdsqVmGDtYTTtbGq/1PoMyYcivY/vurQ5jZUbK03Bspsia0dWE+TRehLIhToG0QFFI3+47C+jA5aOsTCdjrZQ+40cNnTYD+/R96iWHezcjDPgABy1lBQitRooMaqburPBMtUM/txJaaX4D9zC7x0uGIP6Yvz9Ym3elauMGwRQaI/2Vutd/LsrtMTK8QU2Gsqf5iEnxlS3GYKQNoVChsH1O+QayvqC3XQmQnXM/W+pQmrY4PE+8NT9moDM2WzC0cTj4byGyFyRp7wDVv609+5odM/yT6HhxMZb5vqZTckIqifNAoBhoVPASYPu+jy6RNef1XgiewwmMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB10769.eurprd04.prod.outlook.com (2603:10a6:102:488::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 07:49:25 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 07:49:25 +0000
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
Subject: [PATCH v4 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Date: Wed,  4 Dec 2024 09:49:15 +0200
Message-ID: <20241204074916.880466-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 71b6ed5c-30d9-4e60-1b70-08dd14382c79
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2FyTFhscTIwczNjZXlZRDJXdjBCSDFXdGJmWGN0REdHWTJ2bGtXaTA3QVkv?=
 =?utf-8?B?YzdIWVdSNjRaYUdXZms4ZkJSODdYWW5MS3dNenhCcXo5TjBQSCt1bkVodHM2?=
 =?utf-8?B?WWQ1Z0ZPMUpZVGg0ZDZBU0haVDlIL1AvaHZBRVBTQkdrYUdyY2NDaGg1Mzc4?=
 =?utf-8?B?OUlSdEZ2QjdzUFFVK1VHc3RvcVF1alJObzRWZXpqOUpZa1V6WTcxaGNaNDBK?=
 =?utf-8?B?SmlkZzhSUngzamJNNk9NY1dzNWdheU9xakNLMUpUZkwvZ3o0RHZVdEtGNHpR?=
 =?utf-8?B?bkhpL0JwbGpuMmI2aTkvdG1NZklxbDNrOCt3NmM3bFFvL3BQQzlUdUJYTnJI?=
 =?utf-8?B?VS9NaXV4Z3Jic1JabU9nVk1EUkltcUExS1FpSG9LTlpaRmVJdE0xRXhCL2px?=
 =?utf-8?B?R3V0NU8zVTNHZGxMYmVZYjlpQzBtb1VLdU9PeXhNb2w4blhRSTVONXVCbkpD?=
 =?utf-8?B?WlhCWFVTVkZSMjlkbTRVZWtMR21sRnNtYkF3clBWMnAya2dWZkJmVTNaUlRX?=
 =?utf-8?B?bzNaRzc5QS9kVTQ0N0tsbU1GcjVEdjlsM3RLQ2IxOFR1a0J0cjUyaWg5Zmhy?=
 =?utf-8?B?ejQ0Y2Q2bGgvdTBmRVZNSFBEbDVuL0pyeGZoSjRPbSt6T0p0L2l0cGFvUm9E?=
 =?utf-8?B?NUphbUhmN3QzTEsrMFhKM2xKN2MxS0JnSWdvRy9qWm94UFZobDBLQXdlK1V0?=
 =?utf-8?B?Sm80YS9leENSTDIybWhVWVBqQ1RXSE5Wc0s4bWdZblpKN0hSY3VFTXMzSW5F?=
 =?utf-8?B?OURGWEcrZHQ3YzRXeUMrTVBtMmxSME5BSmNMVUN1UW9nR29rNGJncTFZVEdW?=
 =?utf-8?B?MThFNVNqZ3dFeXc5UjF1bnNwNm1xeksyTVpvS1Mya1NUanhGcUpzcjVkSHlm?=
 =?utf-8?B?T2hwUSttNko3OUZDVnFoZ3JUcGt3dTFKbFc1WHV1c2xkcTMzdDRPTjdIdmxm?=
 =?utf-8?B?eXpZNE9IN2d1ek1XaC90YTVMRmhNMXZPYVVZRjVmTUptRDFQQ1FBR3VMRno4?=
 =?utf-8?B?WXg5QjFobXV5R3plS1ZSZ1hGOUw2WFdBbzdVUmhyUmhVbFVrdUt0YUNSdmhE?=
 =?utf-8?B?R3RQbk13dU4xcmN0M3c1aU5IVSsyOFMwNDlKQWJwckx1bjgwalBZQkRmREU1?=
 =?utf-8?B?eUJqbFhUcGtFQnpDT3BQcHBBT0NYL2NoRTBMenNOTXZFaHBlcmRqQ0RxTTRj?=
 =?utf-8?B?NVJxMDA2OEJ1Z2tPa1krVk9DZDU5MEswOVlEclloTHJPRm9mc3RsUDBDcmdF?=
 =?utf-8?B?SWVQRFB6OHRaSlhTcWhhK3ZGaC9UZzh5STVVRzJQYmZIeHFZMWNTV2xpQ1NJ?=
 =?utf-8?B?TmEzSWtkOStTUFdFYVJqajVUeHkrdXZLYzNKUFk1K2RvTWpsNm9mSjF6b3p2?=
 =?utf-8?B?czZydHFMUVJOa2NXRVdONms3SWRKaDVSQ0xnTlNRWGh0b1NleVRqdWlyODdJ?=
 =?utf-8?B?V3p6RWdwNUhIcDJKZit4cHhMSWpsMjZFbzdHWE5Jdk5sUzBLOTFyUWdqa2U0?=
 =?utf-8?B?VFRpS2RrRThxM3pqQzVjK0g5LzVCRHprb3U3MHg4RzhMdzhZWEhiU0tORnBw?=
 =?utf-8?B?QjQ4S1V3SFR3UTAyNUtBK1c0VlYvaVhnRXhDNGcwN1R0SXU2WXBOSUMwSHB0?=
 =?utf-8?B?ZXovNjVBNzllTjIrNm9jVEt5VWowOHJKYklWejFEWGkydzdISDNTWjhVeVVk?=
 =?utf-8?B?ekNiNjdnMlYyemhVd3gwSFpYRFhUbUdHS2dQRk9nRkl6YnRrN1ltNmNtdTBi?=
 =?utf-8?B?Nnh5S0t4K2krZXB5VDI3eGhsOTNYcytRYkVLTzRIRlBWS1crSG4xWGx2NDJO?=
 =?utf-8?B?OWN0c2pxWk0zMndsakFBUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blJ0K3FmbGZlZGpWOU1sTWpjeXVrRm1ONnpBaHZKZys4TDZDcEoyVnp5VG52?=
 =?utf-8?B?SjRFKzlCVU43NlhHeStzc1lTRTRRK0ZRNWJqT3FtVk9sZVIxV01HK1NjTjk0?=
 =?utf-8?B?NllIbGV3MGZjRVV3c251UjB3OERzNDRrTnR3Y0JZSzdJeUJtQVB6SnBEbEZr?=
 =?utf-8?B?Qk9xOHA3TnREcDZ1VlYzK0txSksxMEkwT1VYYysra1NWczdBTnNNSmF6NG9w?=
 =?utf-8?B?YXRRQm4xVC8xWUtwbkNWRng0eWlyS2hmTFI3dHVibno4MGRnSm0zdzZJa3da?=
 =?utf-8?B?SXFpVFBYRDVENFNjdmJiVnpSNytmM25Dbkx3VWF0SlpjZ1B3aU1LVXA5aW1O?=
 =?utf-8?B?NmlmM2ZINTdxNUk3dVlSN3FpY3JQMit1UWJ4bkdiejhqVXlFSWZ4eXB1Nktp?=
 =?utf-8?B?Qjl0UWhYVGx2NXhXMUJNWjFibDZseU5pYXpzSXc0czlqeDBnalpJQnorK1JY?=
 =?utf-8?B?MzZXb3M3OFE5Zm0wMXZSSDZNaFlqMVhuL0ZrU0ZWbk8xZkNmWjhtWkloYVhh?=
 =?utf-8?B?enhKL0o5clJvRWJtenp6TFJ0RUpxVmZuSFlCMjlLbGcwczBCandqMjEwazFJ?=
 =?utf-8?B?TVRjeG5sT0NUckFCWThMd3ljcFRWSU9nUGZjQWRrT3BjWkFDWThlU2JBVUU0?=
 =?utf-8?B?TUs5U1Z3bkRVRmFHdzJuTW1CWExBckl5VlEvZk5ldUNyWFh2b3E4UlN4b0VT?=
 =?utf-8?B?TisvbGRZa2E4RUZ6dDB5MXk5UU9rTGthRndNb3huSnNpZldMOEduNE9vTVpT?=
 =?utf-8?B?SHlPUHpleHM1cllUTFZMMmtjVnFzakJOVzlGZlp4Nnoydml1d2hFSlNtbDJq?=
 =?utf-8?B?ZlpoZTF2dVREMzg3N3BFU1UwV2hGRlJ4MEhLUHd6NkdKUEZQVno5QkFoaW5R?=
 =?utf-8?B?MS9qVm1la3FrQW5yTnVHb1lHS1dTRzBMVmpSSlRVdElCMW1Oako0UDk2ZWR3?=
 =?utf-8?B?ZHpxd3JjdHhCV0ZHWmNDYmhGTU5lanFOb1lrb05Wa3RwS0dOYXNHZTJYVXRY?=
 =?utf-8?B?YUM4eEs5bThTNUNRNFdKdTI3aGwvaFpnMmd2OW14ekxRb0FrM0M4b0trMTA0?=
 =?utf-8?B?VkMrdW9PVE9tZDVKNzVhVjJLRFA3UDlDLzM3Njc5a2dXa29LSEIvbFBjakN3?=
 =?utf-8?B?MFhmSHFPQWlyelJ5SWFsS0Z1cUoreldzSmRLRk5zTmVqNEtlbk1aaGhRUHRW?=
 =?utf-8?B?cEliQUx4RUpVMlZwbGs4VVQ1N3pQVGl6UkVaUHJpeC95MU5rcU9OS29DQWNw?=
 =?utf-8?B?Q2JIakZIbnd6VExSNEhmbmhORmdiK2NoOTRDRGZBK1V0Y09GclhxOENDU1dw?=
 =?utf-8?B?T3BDNUF1dkhMSklXcUVCdHM5L0E0THRSVUFMNG01RGFEVjJXRDFYTUlTQ1J0?=
 =?utf-8?B?OWVPdEZScXpPSzhuaTdFU2VwUHI3ZkIwTW51TmYxbnlpZkZyT2QyeVBUemFR?=
 =?utf-8?B?cFYzdDE5UnZHMmpOZ2k5TlpuankvK003TmZxVkhtUXhxREFrWlhOY1hZU2NX?=
 =?utf-8?B?Q1dKeC9MdUZTN3VoTnJlUkdvQVJQV1R3NE9BVTFNUFljbXZjMGJnSjFOQ25T?=
 =?utf-8?B?SThmQWtSQS9VVmFwNTU0d3MrZHhoMmJhQThkUHV3cTRFZGRpN3hja2Y4N2VT?=
 =?utf-8?B?czF4K0xUR2RtL0ZUVHhjSzhBQ0VEWHh5a2dScTBZcVFkc0sxN0NjWWFRbE1M?=
 =?utf-8?B?MEY4N1hpSmY3M0lWOUh0djZxUWhraWlpNUNLRWJPWlk3SjBWV1JIbmRNcHp3?=
 =?utf-8?B?UERSQzVJSzJVNlVxZ0toanJELzN4UnFLWHRjNldDSXhoNlh2UjRBejJ4b3A5?=
 =?utf-8?B?UG9RVXppalFoTkZ6U1I0ZDdTOXNNQ1cvTUhocy9Eb1FtOXZqZWlUTHAweXlD?=
 =?utf-8?B?WlgwTmpKRUhFL2dyRk5aWWZNZWd3azM0eUhkODBxNnozMzJ3WU9hOTNJVytC?=
 =?utf-8?B?MHBtS212MytUSmMxUHNTaUlJS3VuVHdDcDArV2d5bElUZWd3YnM5dG1PWDJu?=
 =?utf-8?B?TDAyWHk1Zk04KzV4Y2pyQ3RVOXptVk9teHptT3ZyUTZmR1gzb0dUZkM1TW9t?=
 =?utf-8?B?THZocTFzMDdnRE9rNlh5c2tZNjU0emVaVjRMZ0JQUzJUQ0FSZG1ZS2plbyta?=
 =?utf-8?B?WkU0T2pEekIyTms4UEhQeko3WlNKaW95NXVXQjMzM3Rqa0s0N3E5Vzg0RUhp?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b6ed5c-30d9-4e60-1b70-08dd14382c79
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:49:25.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKS6x5FgqJy1+YNMf08NF51oqBJhCybBoWtudXYZUhZc+jy/rM18LgWuldh2qvdoJcd96e2Mair9KShlqd/qum/NQzlYSnjmOmeyHTwpnWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10769

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device type data for S32G2/S32G3 SoC.

FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
management is different.

On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, Mailboxes 0-7 and Mailboxes 8-127 respectively.
In order to handle this FlexCAN hardware particularity, first reuse the
'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq handling
support. Secondly, use the newly introduced
'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk which handles the case where two
separate mailbox ranges are controlled by independent hardware interrupt
lines.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 3ae54305bf33..282297c55502 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -386,6 +386,16 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2055,6 +2065,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.45.2


