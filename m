Return-Path: <linux-can+bounces-5115-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B44CFBC7410
	for <lists+linux-can@lfdr.de>; Thu, 09 Oct 2025 04:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61DAE4F0FE2
	for <lists+linux-can@lfdr.de>; Thu,  9 Oct 2025 02:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FAC1DE4FB;
	Thu,  9 Oct 2025 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JA0qXrl/"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4941DE4E0
	for <linux-can@vger.kernel.org>; Thu,  9 Oct 2025 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978603; cv=fail; b=RkDMVmrk59Z/o0dNdQk/5G3eIoRApTgU4XIG3WZ6R0d2HlA7BL+fQeUMMBBc6kb+y9q8EPLgsWSHnLlsvRnQthgoe5DQ0wHqB1+m/qfgWhv89dbrsU64gyxaPz6V9vabetXGL3WQrPQUkDCOvz2JHmJ1Crqf5eNH0panaEMKW0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978603; c=relaxed/simple;
	bh=bnTrhgKrYWefIYUIl9JJGWLbearximTdEOpoAFPYhyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZndiXvyGO1ic/LF40Sedbe0kx3m3GYxrO1JOwZatu76khRHBETVoTv9ai0HxXgEfs0GESMZ8GnXZ44lmSclsp62e9nIsi+UL6xOJLI3R+07tJtvDI9jWHGafr0t2awSni0bhcGbdGDW4SNkFmgP2KqAW+EwFJFYU+RACCs9DL/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JA0qXrl/; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHN8l8EUDUogEmxHutxyy61zhS9YzAst5c+CJ+kPJHUjuJpErCowCpPAXgZJhdJ9MbifB0vmiXjybKm6Sj2INFjXYo6RyL9DnD+QBelq/xrORGtsMcuUVys5eEyxzU+XyHKO35CuSVG3teliyeAWIwq6hnq2NvKh+PBuvtN1zVdAJ4pktfMRCqKH0EdQ+Q56qUFDHLejh/FDhWO8Vfqz/4/FS2lrNEyt2jv/M5Xiem0FDi/qfGxv0nNPFkj8LTbbCjMVsBtxeDlKVgyoBj96leqnNbLCSw7RYn4vsKDQtfD2utTrXmWPUBrTg2gbOOe8yeBX0GB+bcZJtVIlEjtf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnTrhgKrYWefIYUIl9JJGWLbearximTdEOpoAFPYhyo=;
 b=kHjmG3jnttip2xLvsneb8MeLj3QaDSQNGDlh6iImcFheH7fBYOKTMY2HUeE1GfMhEullzXe5ZlyayRUHDMbiEWky/dAbcd2KvEZzNtfAG7/p3QaZfl484kkJDQqvfLClzIBxzXD7mui5W2h+XnzeCskpyONDgRS+ILXDcy10uwbQ72Eu7PS3n5hfkWUciH6GZsX/eJB+zrdvXp5edfJXq1KAJnMhsv9AkfCKRemmWrO/QaLOQLqCjgiScfvsPalSwh+kp2uuMtN7yRSt8t/tpy8RGCldcvq5sTRPpIf7L+KpXqOEi/EpHqpNrWnbW+K4j5EqjKoW51v/RlOSNHc2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnTrhgKrYWefIYUIl9JJGWLbearximTdEOpoAFPYhyo=;
 b=JA0qXrl/UY0Ro0w5APlmZyxWIk1vnn9IoVDdYUrx5WlqpJAd0ToNcTaH4OTg4ViU6AWA1UPXrur3gISC1y9YJpbqoe2YZ1+Ptn2pmHJ/i+OboFQDQoCKbyvsNkmazQSonY+EpwQi3/aQYXrJmC5CCE/Z9fA9807Rob687PZiF0fC+bLTFnSn3VaV8/MtWBh3mySaPvwCInqNXwkiXDpRIdfTcbc4kGPT2cqiv7DnHOt4eEM/qlH8rFo5EyU+PjonIPhg9W4DvK/TY1FF3Ov2hBXfXfS8V/IenGah0vwVudFMB3Tms8bTn5h85M2bsDgtsFJ/E3YN9MKfFm/TGjHJ+A==
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by GV4PR04MB11972.eurprd04.prod.outlook.com (2603:10a6:150:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 02:56:33 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::43b2:647b:5320:225a]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::43b2:647b:5320:225a%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 02:56:33 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>
CC: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: RE: m_can and old email address
Thread-Topic: m_can and old email address
Thread-Index: AQHcOCZFdf8IVHdpKUapo8EPQWo+WLS5H99w
Date: Thu, 9 Oct 2025 02:56:33 +0000
Message-ID:
 <DU0PR04MB92993B102E3EDF8BC9223A1C80EEA@DU0PR04MB9299.eurprd04.prod.outlook.com>
References: <20251008-invaluable-amigurumi-deer-76c105-mkl@pengutronix.de>
In-Reply-To: <20251008-invaluable-amigurumi-deer-76c105-mkl@pengutronix.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|GV4PR04MB11972:EE_
x-ms-office365-filtering-correlation-id: 2bf6f9a4-a3cb-49ec-191c-08de06df7489
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?em1xWmdDc0x5SWFGUFREUjFyNVdlY0sreGUrblczWVFvM2ovcVdpSHJzeG9r?=
 =?utf-8?B?MEVSeERBb04vQWJYdmVMNkdzdm1vLzlmNlk4Y281cElnZGt1ZlJrdEZ3aElj?=
 =?utf-8?B?anFLdGZYUlc3K2d6dnJTQnp0cHU5SDFsQ01vU3JFU1I4Q09CK3FtTTZVM255?=
 =?utf-8?B?cDNjSkN2VkVFUXRKbEF6Z0IwU1BqY0ltVUcrTjM1L1JCcHgzeEtmYlRsNEZ4?=
 =?utf-8?B?SXY4VGRzUTQvOG9uQ3pWY2ordkhHUWVkU1IrQU9zMkY0L3krUFd4ZmJpK1kx?=
 =?utf-8?B?bEJ1dHhobmFEWUI1cXVzNjZ2ekZQOTk0aVRBUUNEaVZ5d28rZldwdHYza1Ji?=
 =?utf-8?B?a25zU2ErMVNUYlVjcnV2bW5DQmg0TjFxaEljRnE0Rjh1N3l5b0JiNXVoaFE5?=
 =?utf-8?B?MDFPOEs2TENuUlB1bzNSZGRlRTFoWi9VWDA3ck54MFRPVjZwVUt6WWkwM2Ez?=
 =?utf-8?B?dUFSQTRCRmpDVzRZNVU1UVFUTXNDcmRhOXo3UnBnZVNwTVNjbzM2ZEZEVEFm?=
 =?utf-8?B?SHNuN2c3MXY1UXFvSWJUMjlVVmNtZWpydFd0TVNLZnY2TytoTEI3UzRxdFlr?=
 =?utf-8?B?QlhrYUpGRHhRRm9YUFFZcXdHLy9hVzBaV1ltcmROd2ZZcU9yOW9WdzZ2SXVn?=
 =?utf-8?B?RUFtcWFLSVk5c0IwRDRWN01ta3ZuNFhtRC9UdmJBNkgvcWNPa093Z0pjT2c4?=
 =?utf-8?B?NDdXZno5Zm1NOEhkK2ZQVVMzVnA0aWNYR0tPVXh3ZFQ1VGR3c29nRW5QVUxD?=
 =?utf-8?B?aERWRjBqanY4RkljVGpSVUJLRHlKbTJpWU9Ca3pvTVNxM0djbU9ZRUY1Wmdw?=
 =?utf-8?B?R0IycUlrTlpLU1VXdVczMHdPWDFIUXJOWXJYdWxXdVNqZXljT0hGODZET0pC?=
 =?utf-8?B?YTE2d1lrYWl5a3Q1Mm0zNDJMQkhEaFl0VHgvVHVaeGs0M2h4NVkvYVJDN2dx?=
 =?utf-8?B?Sm95Q2RwekQwYmRKTjJUeFI1MUtJSGQrVk01bkxTeUwzNHUyOUZkM1hVd3Z4?=
 =?utf-8?B?M0lKcUhSQS95UVZ1aGljdEtESG94K3BYeWo0aWNBbVlFejFWQkN5b1VNbjNw?=
 =?utf-8?B?RDcza2JxdzRnU2l2NnZtR0tBcjU4WDV2bTlCa2U2VnllR1Fjd0h1b1lDU29P?=
 =?utf-8?B?d2xnVUJaM0ROdnk4dHU4SkdXekUza1FsUkU1MGRDaDdvQUV0d0Q3Mi9VcWJ2?=
 =?utf-8?B?dnVjVngrSktCOUZkOUlGVHlCYjNoeVhsVHU0ckovQU5zU3Zzbytha0o0aDBN?=
 =?utf-8?B?SitVaWZBZWw4c0VyZVFmY1k5am1jWlVmV0VaWmZnUXE5R253bzZEWmRJS0Ux?=
 =?utf-8?B?UzROL1lGUW5XT0k4c05DanNPWHROa3d1cU90dGhaRlVXSUZNUnc5Qm1jOG8w?=
 =?utf-8?B?alVWbzJOMlpnMXlpSXRoUGpKdjFGWVJTMXhRVjBTQ0QwWVo4TktJYjJ3MEFE?=
 =?utf-8?B?WkZNY0QxUUJZMm5zWG1JZ3hVK21DbTRKbk1hVlJKcVh6QXZDRmNVM2JOTXlN?=
 =?utf-8?B?U0NWcWs1Y0ExQm5MT25IeEpmS1c2aE1uZVVBcDRCQnVLQmFRYXNpc2JuR3RO?=
 =?utf-8?B?bjNkOFg3anRueGpxWEsybExDVXprU2szMHdOWFdBNXp3dm8rdkRDdjQwZXpa?=
 =?utf-8?B?ZUJrbmZtSUFMYlpzTGkxWGRKZmZxNHJ5SVBpMEJIYTVHZjBxYzhXMThXZDNG?=
 =?utf-8?B?UjNSaGJIZFZwOUg3M0tUbVlKVGRwWkpxd1hKK0dVdXdFckUyaHpyVjRNU1Qr?=
 =?utf-8?B?OS9xZmZNZjM5MU5QTmpQZzR6ODBhRk1kbWdQNUE1V2MrL3psSXJiMU1KRnpN?=
 =?utf-8?B?R1M3TzZEMXJEVi9VaXlKZHBMVzZKSjRPQWRTdGxzREoyRDFicUFZRnF6NHlV?=
 =?utf-8?B?VFVwN2FOUWY2M01CcjJqNXRoVGpEVm84Y1FJWU5pdGdvZnVpT05xWUxWOUpP?=
 =?utf-8?B?c0xRLzRGNE5DbitldGp2NTFxRnJTdGJINURsWk5NT1FpdUhmaUlpUHFRcC81?=
 =?utf-8?B?UVgwZzY2T0VDK2lhSzk0MUlxMVlRMUZ5a21XWHNQNERtZ2lXakdkKzRvVkhF?=
 =?utf-8?Q?dcH07l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkQ2RFNobUlLSGhJaXlJKzgvY3RWU0ZDWkVneVBJVnFhYVRuSHUwYkVYNkVl?=
 =?utf-8?B?d2dqWTdETHR2ZGFrOXZ0L0NudkxGSEFRZWx3NUxaTGtISElBWGl5UUtFMWta?=
 =?utf-8?B?K05XWFMyU0s4dTQzU1NLZDR2VmpxbXFlVGFCcllGSExDL05ZNnpUeFdsMjY2?=
 =?utf-8?B?VlhWdThSQjB5WWQ2SENvUVJRQ2hLNTRZanUyNlRtc3lyWGVabkhCQmNvQXpG?=
 =?utf-8?B?djhadk5iclNxSTBrZ0ZLdEtKQkVvbGI0N3pFVkp6OTM2QTRlOFRUa2FiQUxH?=
 =?utf-8?B?dHRnK1hRTjFOMjUrS0RNb1FWTWN6amJ4QzNjTDUybjcwUkFmRFZTdUJhTkFH?=
 =?utf-8?B?dytiYSthTjZLYnlIMEV1T0dtVnJGSkFVd2hzbFNBSWhsKzFMQ2lKT0NRUFh5?=
 =?utf-8?B?QXRDZWQ3U0VYazJxejQ4SHJzUTlicm1NbnVUV2lVRWdxTFA4M0RaVmhqV0NR?=
 =?utf-8?B?cmJSejJRZW9DV0NDalgzNWE5RmprcE0wZWVmanh0djc2VWNaM0FTRjIwVHRO?=
 =?utf-8?B?YzVjSkU3ODJaN3lOMnNNUldzWDZXcER1ekV1R1JpSkp4Qk5DYVBHMEovVU1x?=
 =?utf-8?B?ODF1WEU1b2wzbjVJRDZteVdOWFNGN2FDT2FlWm9iZWNVWVZ0cmJ3blZLbWw4?=
 =?utf-8?B?THJ5OUlnODNHUysyckhWTkZQZzZJWVI0RWZXejhGYW5jZVdZL2hDcWNjZzBk?=
 =?utf-8?B?SEIrZW9UcXlUWGFzZVp4RW9oU2xUSmRzVTFmMWhsK0svOUU5S2wxNUlqQndY?=
 =?utf-8?B?YmhFdUJ5Tk02Z3oyOGoyZjd5blBEUjNiZTRtdGpja2pTeGpsM0x1Z2JKaCsw?=
 =?utf-8?B?K1YwTkhZUUtPa1NkL0RUUWY3aEZCcVdjSkdKVEx2aG1yWk5xdDhYRjNXTHBH?=
 =?utf-8?B?Q01CRm1jWXF5QzRFRU5rSHJEZG1mRE9PUW9DRHREQTY5czgzcWhIUnpucWFN?=
 =?utf-8?B?U1NBWkRyZEc0QzBrMCs2anlkdGZFeVZONDJKMnV0OWpJczhDRjBrSXJIam93?=
 =?utf-8?B?cS9ycjBpSnM0aFlyaGdoZ2Q5R2hCOHRGZTQ4RFFPZFJDaW5HY3dacHNKT3pw?=
 =?utf-8?B?VW5OMkZYbUFqbXFVekVROC9SYk1MdWlOZW5DckhqK1NUeVpzZ3JnLzh6Y1hY?=
 =?utf-8?B?L09JZEpob2tHQWIzL29NcytiZ2gxV3owamxjTmdWY3dIcnRVNXZmamRpYW1h?=
 =?utf-8?B?WmwvR3pleUh5alJFdDg2blJsM29mcUF1cUVrc1FJZzdHNFNBTjYxYjFHY2ZW?=
 =?utf-8?B?N2hHY0pocjVhSWUxK2JRRndaYjR5MlRLbDV5ay9BV0k2TFd1QjlOZXhyWTVL?=
 =?utf-8?B?QithZzdWMSs1Q2MxYTBRckxXeGw3R0xkU3FhdEovelhNSXp4dXBsNXpZMEYw?=
 =?utf-8?B?SWtSWWFtZzlGbVBHQ01vMXBtSmg4OVhabnp0SHFSSUxKVW9PTHN1N0taRklC?=
 =?utf-8?B?UjdPY1RvR0RWQ01WT2pEUXVhUk10ckFZT1BOeTNxYURKZDhYM0o3ZTBWYXdQ?=
 =?utf-8?B?QUxNZlVNQi9NRVlFTjhVSi9wMExWUnlYbHZrdHpZTmVPV0FxVlVDUjZVR2Fv?=
 =?utf-8?B?dG1wa2laNU9GeGF3bjBzMi9MK2tSYVJBQlNDV1RmVTdYKzZ0MWZoTjZ3TnRL?=
 =?utf-8?B?RklGZ2FVUWhXU1lLRmFWZ0F3WFM0dWVhYUxNYjI0a09lUUY3cDJqZDJhQ2gw?=
 =?utf-8?B?dTFRdjEyK25Udlg5WFZkeVhVbDdIQ2o2OVd4MTlqYklvOUNxaTNUa29xY1M2?=
 =?utf-8?B?T1dIbUQvTllPLzhXSzVjcmdPLytadS9HVlBDdXZ4VlJGT1lSSDNVSW9jSUF4?=
 =?utf-8?B?UVYwSVpPandGcFNYY1pDcXFOVEtrdmc1NEk0TUFycVd0cC9SUmV1NU8rZGF3?=
 =?utf-8?B?M2E3dXJrSU1iL0Z5OHNSZlJWRmhiSzRVdlFocnJHM0R0eW11QjNkREJrVm10?=
 =?utf-8?B?RHNFTFhVUlFPWGRpcDdnTW5zdHNZYVRWMDMyNnJBOTM0UFh1aldnR0V6Z1NZ?=
 =?utf-8?B?VGoyTlJjQjBHZ1c3Wm9HNzhDVHNHSFY0bEQ2Q1pieDE5cHd0NjVzT3dvbEZ5?=
 =?utf-8?B?andZbG4zM2pmNHVEYitpc241Q0JLaG5VZ2tqalJMMWVvNkNTVUx3N1pLYXBx?=
 =?utf-8?Q?gDi67yKHbtS2BrZ37IcaL+3IM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf6f9a4-a3cb-49ec-191c-08de06df7489
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 02:56:33.5126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNPh8XYB4FS4aut1dw47mseyVVOUGiSsM9SQthrb19GZgCNDOqcmjNIRbueAaFXKnzIkdSa9Fq8Ry3ixC6Sg+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11972

PiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAy
MDI15bm0MTDmnIg45pelIDE1OjM1DQo+IA0KPiBIZWxsbyBEb25nIEFpc2hlbmcsDQo+IA0KPiBz
b21lb25lIHdpdGggdGhlIG5hbWUgRG9uZyBBaXNoZW5nLCBidXQgYSBkaWZmZXJlbnQgZW1haWwg
YWRkcmVzcyBpcyBsaXN0ZWQgaW4NCj4gdGhlIG1fY2FuIGRyaXZlcjoNCj4gDQo+IHwgZHJpdmVy
cy9uZXQvY2FuL21fY2FuL21fY2FuLmM6NDovLyAgICAgIERvbmcgQWlzaGVuZw0KPiA8YjI5Mzk2
QGZyZWVzY2FsZS5jb20+DQo+IHwgZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmM6MjU1OTpN
T0RVTEVfQVVUSE9SKCJEb25nIEFpc2hlbmcNCj4gPGIyOTM5NkBmcmVlc2NhbGUuY29tPiIpOw0K
PiB8IGRyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbl9wbGF0Zm9ybS5jOjQ6Ly8gICAgICBEb25n
IEFpc2hlbmcNCj4gPGIyOTM5NkBmcmVlc2NhbGUuY29tPg0KPiB8IGRyaXZlcnMvbmV0L2Nhbi9t
X2Nhbi9tX2Nhbl9wbGF0Zm9ybS5jOjIzOTpNT0RVTEVfQVVUSE9SKCJEb25nDQo+IEFpc2hlbmcN
Cj4gfCA8YjI5Mzk2QGZyZWVzY2FsZS5jb20+Iik7DQo+IA0KPiBJcyB0aGlzIHlvdSBvbGQgZW1h
aWwgb3IgaXMgdGhpcyBhIGRpZmZlcmVudCBwZXJzb24/DQo+IA0KDQpZZXMsIGl0J3MgbXkgb2xk
IGVtYWlsLg0KDQo+IGI0J3MgLS1hdXRvLXRvLWNjIGZlYXR1cmUgcmVndWxhcmx5IHBpY2tzIHVw
IHRoYXQgYWRkcmVzcyBhbmQgbWFpbHMgd2lsbCBib3VuY2UuDQo+IEkgd291bGQgbGlrZSB0byB1
cGRhdGUgb3IgcmVtb3ZlIHRoaXMgYWRkcmVzcyB0byBnZXQgcmlkIG9mIHRoZSBib3VuY2VzLg0K
PiANCg0KRnJlZSBmcmVlIHRvIGRvIGl0Lg0KVGhhbmtzDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==

