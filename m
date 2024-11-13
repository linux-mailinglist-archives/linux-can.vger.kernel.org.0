Return-Path: <linux-can+bounces-2011-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516E9C68BF
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2024 06:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41FA2848A2
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2024 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5C11779BD;
	Wed, 13 Nov 2024 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2TVd91Ph"
X-Original-To: linux-can@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD04176AAD;
	Wed, 13 Nov 2024 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731475858; cv=fail; b=EftqgBehcyAphkCpHfkVS4IwPvYWJD4WdfbpivwsNlAFqAAcQTx+YsJaea7TpM2ZniH6DwuvLhnvOjF98i5hOwr8CePyTcDoPexFLLmXPLvlYX7bdx5U2nUstOD7c6dVFwUAJ5RWeFXj8a5zz6/BYomLZQ49Ibb4xU2yFInTB3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731475858; c=relaxed/simple;
	bh=K3U5+Gy6gKB2OTTOjmVy0FvmTHHfVuRSOQUvNiQCjdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pq5Ah4fEs2LGFeWTNPBTdB8J2PzVw/jRqU6jcXAmvr86fvb/HwV+8OmX/jGDNqh98aA7qrnlAm6iPkDm7DaoQG+wwbRsj778tz+mr2dN1jbEcbY9R2EfN4OeFErqLAjFN9UwBQnN00cpLvZYUtJMwX9P1gD9GH9A0+iFHEw8Z4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2TVd91Ph; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpNHcjVoVHgGA13i6qriWqDBiWtqq/B8bz8GJfDWXfd8SXUkPA1lYckrgehVQYjcxMc2Lu9tYeMLwJyqbgHHZMokb0M5SmoQm49WrbAAxk03IsEk/osqsINdNZ7rYWaZVDsSCYshZD0EKVk4c0gsozgK2S8z1sUx3O7OQYZF3m3n60IoyWCw0uX9c/TfbH8kNjENYYDajjG0oGauOswTa6c1VoGBSnrSfgwdI/Turb1QcnEg54XG2yhUl0G328RnE+LlcHmbpTj0nTkjRyNsCdZ6+pge9wweTJ88xX+vykgDYsx7/4XSrSQfb1HcTydXQlwErsvvkQJhXaL5keIXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3U5+Gy6gKB2OTTOjmVy0FvmTHHfVuRSOQUvNiQCjdg=;
 b=UtsEhRU42CtXqqxVtuFvV4VYoUCX082l/GbeJJbvYbZUBRdYdeiZHnz+uosV+lWt+60u4StbusjO7juHkGgS0ktbbPT4rAxsk6W7vMFjIEBX/UaXdnJxcdkU+vKQhVWS2qYH+7bDlE//AOPVSUecUrWP2xD0o8SP1m4UfB3YgiCLOP5lsH4BiSAqB4BGUttRNoBu/J/j+W/HyMZ58KmCiVLgPsBhNP29t06xtu0xCa5eHT954yQ1BxA3H4v0XW4mQL2ip1Mi8sIQuBpUFWXeldKBkej534Xqh7UN6wABBvZ6kWB43Be11Zft6vmOqWDji3pwTROIyAkr+1yJ2QVQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3U5+Gy6gKB2OTTOjmVy0FvmTHHfVuRSOQUvNiQCjdg=;
 b=2TVd91PhitLMyFA1ofLqDLTdN60kjA77rYbOlKlavcgqB40z7ftyn2ems+eV0q0GplitVGZA2XB5g1LJz1436iPNac5k8vBHvbUzoVq2LlGojNxoAgxY3ZFMKTz+I2hIn1OKV0+Kup06D097ZQ/K7voqbv9y3KMk+z9pr5fmywvd/7WVmfhvfaUrxEmy2IzU9dIQCb2sTte6KHOsyfRvv49IrlFHpnGPJj0Hcegv7amvND1VF4h2+6DzagT+b68ESaa+R8hWdWFm4nR54p+yB9Q6bBGhOOvYWi43eYWEwYHoU6RYA1lykm8/76cTZJKTKcrf3O0eA21MkpxDzkfg5Q==
Received: from DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 05:30:54 +0000
Received: from DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710]) by DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 05:30:53 +0000
From: <Charan.Pedumuru@microchip.com>
To: <krzk@kernel.org>
CC: <mkl@pengutronix.de>, <mailhol.vincent@wanadoo.fr>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: net: can: atmel: Convert to json schema
Thread-Topic: [PATCH v2] dt-bindings: net: can: atmel: Convert to json schema
Thread-Index: AQHbFVIi6ohrjpRmJ0q4L/FYI7DBTLJ0s46AgEA8N4A=
Date: Wed, 13 Nov 2024 05:30:53 +0000
Message-ID: <cd3a9342-3863-4a81-9b09-db7b8da1d561@microchip.com>
References: <20241003-can-v2-1-85701d3296dd@microchip.com>
 <xykmnsibdts7u73yu7b2vn3w55wx7puqo2nwhsji57th7lemym@f4l3ccxpevo4>
In-Reply-To: <xykmnsibdts7u73yu7b2vn3w55wx7puqo2nwhsji57th7lemym@f4l3ccxpevo4>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7410:EE_|PH7PR11MB7515:EE_
x-ms-office365-filtering-correlation-id: 8c9d7544-be78-420b-a487-08dd03a457c9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7410.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajJtWTlmb3k4TG55V2laMmJhWVdPTjIvM3dLNWpaM0JRRzNYN25vRjVRQ0hn?=
 =?utf-8?B?aUhNR1NrcDI2VHMvMDZYOWdNclIyZFQzdnVjS2xVZVlZUWdwVGl1bDR4TlRX?=
 =?utf-8?B?VUZkMWpyQ1Y5Y3JvZm96TU1LZ2IzVTZYaHlRRlV2OUM0Nkw2d21BQzBjUHgz?=
 =?utf-8?B?dHRVTGVtam5GbCs4ZGF0Mm9uNjc0dFJqeDNXTU8vL2o1dm9sWFBCMVVVQWQ4?=
 =?utf-8?B?OGg5WmlXbGZWSFdMQ1JKb1JNOWpDY1dHN3ZzZllXUjFpenU2MWZKd0c4L0FO?=
 =?utf-8?B?OGZudDdxc3Nva3dub3BUT0wzWVN5R3pUQjl2RzNuTDY3Vm9valNtT29DOE1Q?=
 =?utf-8?B?eGJ5bW05OHk1czlTZXN1dEhKalhrelFJSjZpcld2WDA4THh5REdKa0VGQmVY?=
 =?utf-8?B?TlN2QVFjQVp4MzJVOGFmRCtsakpyaWF0NXdMdGw3Zlk4a294QnphbStxOUdx?=
 =?utf-8?B?d2NzcFBidFVDN2lvUG5iaU9wQ2pJMGFPMFVBaFMzR09GQTVMVWh6aDQ2eVE4?=
 =?utf-8?B?WGVEa2hodGJ1MDhjVXJVNVdMOGUydG55VmpCMUVxZkY1Wkg1cU5obTByelZQ?=
 =?utf-8?B?ek50SDVkQm85dDlpNW4wdWhLL09vYWpJQllFNlUwT054b09DRkJML3hoUk9S?=
 =?utf-8?B?MldxY251YjMxcmVZNXY5MDZEVE1CTmFSSTVpV2VSNnlhbnJvTFhKSTNLK21M?=
 =?utf-8?B?anJSWVhNSTF0UlYya1FHWDZHVHN5bGloSkRUN3JpeWRpbGVpMDB6VkJ3eWNF?=
 =?utf-8?B?Nm9aSVRQS0VPaWhsNUVXSVB0cFladjIxaHIwN1Q3WmNTS0hPY0h3bkI4eVdD?=
 =?utf-8?B?KzAzckpTd1cvNm9vakYzeW03VXlMdy95U2NObC9PRXp4aUtHZFlaYXFydDNr?=
 =?utf-8?B?UHlCbGFiS1B2cnlFeEVNNlFtQk54RDEvcVpUSlo4MW1lbnd1aWUzb01LOHAz?=
 =?utf-8?B?VEFZTmpOTVFZTzA0c084NmxTdjhneGpENmEyZFNLRXpUZGJWSW9ueDBqc0w1?=
 =?utf-8?B?SjFNR0hOYXF2NjJ4cURHdEdmeFJGK1lHL1FPYk1NNXQxUXFQNWxsQjVQd0p3?=
 =?utf-8?B?bUNSMVhwRWVVbVI5eDVDeHlPTHc0RVAyR0NTR3djc2JBaWlvcnkvY1hBNXUr?=
 =?utf-8?B?NlNQRjlicy9XeUtOQjk0MnNXcXloZ0VMalh3SFBZQXJnWGN5VjNwTDVGSFRh?=
 =?utf-8?B?T3lpb2NZWGxtQUFMMU8yWmJvWVdVTEhwZ3djRndXNE1IdXhWcHM0YnFLeVJn?=
 =?utf-8?B?dE8xTXMrYVJLWUpibVZBSmsvbUtSRU02emxxUDBDeDY1aTlJZUI2TVpFNFhK?=
 =?utf-8?B?MjZ5c0I2azhhWEd6OU5NVmFHSTFQSzdlYlY2bzAyWUVHcWhWVWUyMlF0aHpx?=
 =?utf-8?B?MDIzWElMUEd4Y3oxS1VJd29IRCsrdFF0UlpTZkxUR0Q1a1hiTjJzTmI0WFpl?=
 =?utf-8?B?cnRTMHZybFB3Yk9hMWZOVHJkWHNFYWUyNGJ5aUcyVkM5elEvbEc1alNKK3dM?=
 =?utf-8?B?NlJrcG1ncXRwM0ZDSUxneVA3aG0rVUZhMGlBNWpKaHdmd3lFYUs4SUZVM0lk?=
 =?utf-8?B?ekpVVHZBZ1l0aG1ZTDJ5ZEhpUmQ4VUF5UGpnUldxdWtkV3B1MU5tZDJzVzdY?=
 =?utf-8?B?dmI2bWFkV2NtSXNPZ3pjKzNPekRsWllzaUs4Kzg1NElueUx4WC84anJTTjg5?=
 =?utf-8?B?cGt5NmtXRThkMExGbllPNWZWcmdFV1BxdzNFODBVL1hyZW9qV1pJWnBISDRu?=
 =?utf-8?B?WUJweW55OUtPZlRCRWZhYUZWSVBXQVpqZGNDVjFpWUlwN3pTb0J1SjRZbmZ3?=
 =?utf-8?B?YWdrdHhGN28vRTlQZitHdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OERqSFVjQnVabll0amhWcTJUT1hWZUpTQ3dXd1BVYjJPOFVVY3FzYkc5UlJk?=
 =?utf-8?B?SnQ2d1pmN3pMVk9HNkYvbFV6MER2UlRNNisycnJMUWZYNm1SbTNZTDR3ckFp?=
 =?utf-8?B?b0pKaXArM2UzWXAxeE1EcVI1RmF6OWZmcThaZy9KYkJlSXRFM1gvcSs2R1I2?=
 =?utf-8?B?MURiUmNEVVcvYk5MY1VxcVBzM0dHd1BIZUZtMnE0UHJPbVpiMFhTVGlHRFAr?=
 =?utf-8?B?cFFmRUVRTldzbytteHdRVUhsTDViVnFwRXNnQlZKUkdyMDZrTGQxbEhiOW84?=
 =?utf-8?B?ekVPd3prNjJGU1QwcTlZb2dLakRQSmVmZWxISElBV29BZXZ5eXo3RXhUSHhv?=
 =?utf-8?B?TVJTN05XVnlDc0p1SUFITVhOSTNScnhPREU2dEJkUmRoc3lSTHR2cndTWlNU?=
 =?utf-8?B?Qkt4eHVBQzdnQVJwc2w2aytNT1EzWjliOU9PVkFXd09qd2UvMzgzZ3N6UkdG?=
 =?utf-8?B?VmIyc2k5L29JdHBsQzhuRThMYjVvZHJUVG5FL29WRmo3dWcxK2FJeDZKZSsr?=
 =?utf-8?B?ZzlOSFBBRmRFODJuN1RGaFNoUzVRSlRRVlRENm93MTlJVndIOEJYVmpvYjhO?=
 =?utf-8?B?dWlUUWRmYTR2azJETGhWZGo3SUhjbWprcjRjOFdZaThTQVEzdGRhY005TG9I?=
 =?utf-8?B?WWxoTjBBaWZ6MFNIaTg3a3I4ZHFLOUtvdWFsTm8zekRrVUJmZUVhQm1zUnN6?=
 =?utf-8?B?V2RZL0QyYjZlOHhGSkdNdUJOSkY2S21UVlNhYW4wU3ZEK1kwZERiOTgwRGFI?=
 =?utf-8?B?dU5WaXl2TWN0QUh0LzJYbnQ3RzdHaUR4RUFvam96NitFQ0toSmZTaU5mVXJw?=
 =?utf-8?B?bDRkVk1JMzMxdkFZd3RqeE1ZaGUrdzBTSlZIN3JqeHNkcUxpemdiUk5mMi94?=
 =?utf-8?B?SXlNWFhiV3ZUeHJxTkhqQkdqS0JBQmdQTjRRaFRxT1ZLb1Z3OEoyL2pra3Rq?=
 =?utf-8?B?Y2w1UGRBUmxwdHV5ZDRMNzJXMElmK20xZ3MrMmNlQmhmbXR0RDR6aENIejRR?=
 =?utf-8?B?ZW4yczA0VjN3UnJCRG8wdkYwMjV5U002eVExZWNmbmFWRkZ6SlRBUzg0Q2ov?=
 =?utf-8?B?UjdRSDgzbSs0UUErdEhoWHF2aWEvN2VPT2xYT29WTmpVckpub3U0dWhvcVlI?=
 =?utf-8?B?WGN5TTdrODFSeVlFTjAxdFduSUJhclpuNzhkUjJKMFVoUVdKTHhsK24ydlhs?=
 =?utf-8?B?NmRtVEtwYThDYmYrYlZrMHkzbTU1enJQUjJXcGxPM2c4TTJPb3NXaUhxdVNw?=
 =?utf-8?B?WFhkdmFBYWZCeGhuTGRRK0tLZXVaVFFJQ2lDc0dYWkQvTzEvQ29uWnZhUHpT?=
 =?utf-8?B?VlJucFQzUytUZUR1N3BhMXp1NUpjOXpIUGdyMXBmWXpIdk0zeHlwVkZkcld3?=
 =?utf-8?B?cGdEOUUyOEdNY0F2K0F2NE9wQ1Q5U3JBZzFXOUh3TnBXYjRqWnFhNW5jUzBY?=
 =?utf-8?B?dzRQTzNtS3o3REVSRnhhL29kaG9LSFBOQ0UrUVNLall4QU9HQ0U2MHM5dFl4?=
 =?utf-8?B?U2xTWGJFTTFZQ21DalY1bWFJckk1TlpFTUtIRUxkSUcxbVhYVWIrK2RCQkFG?=
 =?utf-8?B?cjA5VWtETmVsaFZCdzR3cksxT2dmSXBSYUJCSG9GVys5RXgvSS9vOXpaWHVa?=
 =?utf-8?B?Q2tPaHJRU2tydHhXMUFUamdiZEtIeG5jTVRNK2hBRVR4MlFoOUYwS3k5V29O?=
 =?utf-8?B?MUNiNTdyZGw4aVNVTHlvWnAxbTBvd1lDM0ZiZldJVmhTSWRKcjNlQmJIQzdq?=
 =?utf-8?B?S3prY0tPM3R4RWNOU2FWYmpLcG8wVEIvM0R2bGRKUWk0dndlNlBvaFlIeENO?=
 =?utf-8?B?L3BaVDduakZ3SVlrRFQ1aGhUeUd3U3UwOXdwZzVqNXJPeEUySTNhWnpsVXJZ?=
 =?utf-8?B?cVQ4YzRGMndISW9nK0x0WG1kaitrSkpUWlFJcDZmMkJkdGJvdEJsL2FwNllY?=
 =?utf-8?B?RkpMQjBRZzRWb1d6S0xjQVhHUDhtbW52eEdBVlF2eUJOMm0wU0U5Vyt1aVZK?=
 =?utf-8?B?VTFVTTR4L2kvY3JMSGRhTFBBZ2xSVVNRc2pZWEFsQmgrMk40dm9rNWtuVzF6?=
 =?utf-8?B?OGdvTE1laEJqYUZkVlBPZzJvTFF0RDQxS2UyNnRzOVRwblpYTHpaUGc0KzdP?=
 =?utf-8?B?RlJ3UjlQdWhNNzYyL292OWFERnRUaUFreVg5bnBFbUJ5TnFTRTR6aUI4Ymg4?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <487D6D95B4604144AD6FD74694916AC6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7410.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9d7544-be78-420b-a487-08dd03a457c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 05:30:53.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PKAjCcN6soPPo7qWm/nGcTxd720I7VZ4KWVBxmYyCOt35mnO+Fvv3+i0fNeHdncZ5W7om9lxk7+R9+cIsHCSOoYW4t5070dp+aEaBi4oXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515

T24gMDMvMTAvMjQgMTQ6MDQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBUaHUsIE9jdCAwMywgMjAyNCBhdCAx
MDozNzowM0FNICswNTMwLCBDaGFyYW4gUGVkdW11cnUgd3JvdGU6DQo+PiBDb252ZXJ0IGF0bWVs
LWNhbiBkb2N1bWVudGF0aW9uIHRvIHlhbWwgZm9ybWF0DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
Q2hhcmFuIFBlZHVtdXJ1IDxjaGFyYW4ucGVkdW11cnVAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0K
Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+IC0gUmVuYW1lZCB0aGUgdGl0bGUgdG8gIk1pY3JvY2hpcCBB
VDkxIENBTiBjb250cm9sbGVyIg0KPj4gLSBSZW1vdmVkIHRoZSB1bm5lY2Vzc2FyeSBsYWJlbHMg
YW5kIGFkZCBjbG9jayBwcm9wZXJ0aWVzIHRvIGV4YW1wbGVzDQo+PiAtIFJlbW92ZWQgaWYgY29u
ZGl0aW9uIHN0YXRlbWVudHMgYW5kIG1hZGUgY2xvY2sgcHJvcGVydGllcyBhcyBkZWZhdWx0IHJl
cXVpcmVkIHByb3BlcnRpZXMNCj4+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8yMDI0MDkxMi1jYW4tdjEtMS1jNTY1MWIxODA5YmJAbWljcm9jaGlwLmNvbQ0KPj4gLS0t
DQo+PiAgIC4uLi9iaW5kaW5ncy9uZXQvY2FuL2F0bWVsLGF0OTFzYW05MjYzLWNhbi55YW1sICAg
IHwgNTggKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvY2FuL2F0bWVsLWNhbi50eHQgICAgICB8IDE1IC0tLS0tLQ0KPj4gICAyIGZpbGVzIGNo
YW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9hdG1lbCxhdDkx
c2FtOTI2My1jYW4ueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL2F0bWVsLGF0OTFzYW05MjYzLWNhbi55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5jODE4YzAxYTcxOGINCj4+IC0tLSAvZGV2L251bGwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2F0bWVsLGF0
OTFzYW05MjYzLWNhbi55YW1sDQo+PiBAQCAtMCwwICsxLDU4IEBADQo+PiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwg
MS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9uZXQv
Y2FuL2F0bWVsLGF0OTFzYW05MjYzLWNhbi55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNy
b2NoaXAgQVQ5MSBDQU4gQ29udHJvbGxlcg0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAg
LSBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+PiArDQo+PiAr
YWxsT2Y6DQo+PiArICAtICRyZWY6IGNhbi1jb250cm9sbGVyLnlhbWwjDQo+PiArDQo+PiArcHJv
cGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIG9uZU9mOg0KPj4gKyAgICAgIC0g
ZW51bToNCj4+ICsgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOTI2My1jYW4NCj4+ICsgICAgICAg
ICAgLSBhdG1lbCxhdDkxc2FtOXg1LWNhbg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAg
ICAgIC0gZW51bToNCj4+ICsgICAgICAgICAgICAgIC0gbWljcm9jaGlwLHNhbTl4NjAtY2FuDQo+
PiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05eDUtY2FuDQo+IFRoYXQgaXMgbm90
IHdoYXQgb2xkIGJpbmRpbmcgc2FpZC4NCg0KQXBvbG9naWVzIGZvciB0aGUgbGF0ZSByZXBseSwg
dGhlIGRyaXZlciBkb2Vzbid0IGhhdmUgY29tcGF0aWJsZSB3aXRoIA0KIm1pY3JvY2hpcCxzYW05
eDYwLWNhbiIsDQpzbyBJIG1hZGUgImF0bWVsLGF0OTFzYW05eDUtY2FuIiBhcyBmYWxsYmFjayBk
cml2ZXINCg0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4g
KyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNsb2NrczoN
Cj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNsb2NrLW5hbWVzOg0KPj4gKyAgICBp
dGVtczoNCj4+ICsgICAgICAtIGNvbnN0OiBjYW5fY2xrDQo+IFRoZXNlIGFyZSBuZXcuLi4NCg0K
VGhlc2Ugd2VyZSBhbHJlYWR5IGRlZmluZWQgaW4gdGhlIHByZXZpb3VzIHJldmlzaW9uLg0KDQo+
DQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+
PiArICAtIGludGVycnVwdHMNCj4+ICsgIC0gY2xvY2tzDQo+PiArICAtIGNsb2NrLW5hbWVzDQo+
IEhlcmUgdGhlIHNhbWUuIEVhY2ggY2hhbmdlIHRvIHRoZSBiaW5kaW5nIHNob3VsZCBiZSBleHBs
YWluZWQgKGFuc3dlcg0KPiB0byB0aGU6IHdoeSkgaW4gY29tbWl0IG1zZy4NCg0KU3VyZSwgSSB3
aWxsIGluY2x1ZGUgdGhlIHJlYXNvbiBmb3IgY2hhbmdlcyBpbiBjb21taXQgbWVzc2FnZSBmb3Ig
dGhlIA0KbmV4dCByZXZpc2lvbi4NCg0KPg0KPj4gKw0KPj4gK3VuZXZhbHVhdGVkUHJvcGVydGll
czogZmFsc2UNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4NCg0KDQotLSANCkJlc3Qg
UmVnYXJkcywNCkNoYXJhbi4NCg0K

