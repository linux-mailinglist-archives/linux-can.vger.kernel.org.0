Return-Path: <linux-can+bounces-4964-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20520B9A071
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 15:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D65094E14CB
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6972FD1B5;
	Wed, 24 Sep 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="PSNBGpf1"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021086.outbound.protection.outlook.com [52.101.65.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261F143C69;
	Wed, 24 Sep 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720405; cv=fail; b=n66N8gEFF357Ie7dzsl+8ek7hktVd9cqlldTGIpPgrm3K+LSJAdmhRCRk0mMREPu+ZQ9ApRa0hyOfONkpcEBIZQkCjSIm2tmsRf+g0uJ4p1ewRRPOZDr+jhFqRs4/7FHCEOt/6tGCTqDPVx3prHAzBgZ8IGE5IDyauI0dHDeHgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720405; c=relaxed/simple;
	bh=t9t9o7EywoQ8p7xZOoFKUkM5AFl3VaUSWlh0DI7J4x4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZ/HiLey9UN2VwTrrjfRYzRO7C/TnlO2P5WhGD/3DNU5Eyf9hLkGsP0BDGdJnLEglJkYMCunzY9R5Tr10uUWbKxrXUu5RHPSNq7gu9hqH28OJfrQ3kMMK8LnFwHOL559zigwZ7s20lXHn/cwF7pJQd4haHr1zeB/1Uw8K1hAhek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=PSNBGpf1; arc=fail smtp.client-ip=52.101.65.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3Dh/YQg8awyDViygwbm5gYS4of+E2K+XvJy9NMzFUWwvJUdHF3HUJ6moaKs7QjG2bN64fRK+k+Lf4S9ghKDdsSk7CI70s7csmlZJU7KmrUQiWgl0OL7iCMxgdnpXsjWTGj+SsDDG38X6jFJ/4JEbCcFuECbQ8N5m7Emvh02bVsECc1CFzDELfunnw/bM0hDjswo66ya/9CsPirZbO2rJoTTCtrJxrFBAgdocOew4uJ7uLo2LuwJ4PuEKW3rR7qy7bPNLuXXUsCv6GNXcSyWEj2jfBVuEriX2He1M41kalacVooOZzayf2WHcG7Mbs2csEcVKZPZx0qzXmnUhe8Cog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9t9o7EywoQ8p7xZOoFKUkM5AFl3VaUSWlh0DI7J4x4=;
 b=s14rS95/qfHx7ZaDhs4Y5djN9Q267iIFTOMSIhwPukaphXNWELF1vyBULH20D8mbLKAyIW5qaSmLPOurPcPTJkaz7kp6qZxOElbMe9h7iyBOhsc2mztzqECAzsVqOZ8fSDsyA24uq7cLCeoCxvmgKmRekIoRwHsPVSEOg6eGKMGdr1f+LBVm0t8PAD5iYsbLuCYuSRVMCHz4N7NfrrFSMIK17Lv0Dw61mKw4JbUEWvIiKpmQ+bcRxDCdjaLtqzQnAF5InyVQYEZUYfr5T9SrSwyMBqTBvEdKo3NqNcVQ9wbfSeepV8Ntrnk4XSbFEyx+J1iCM93F23wJwrROckgavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9t9o7EywoQ8p7xZOoFKUkM5AFl3VaUSWlh0DI7J4x4=;
 b=PSNBGpf1v13SdI0ubNBLroAUHwyV8IDFoBOwLEBZV7YTW/q/4eSjK5qbQ40GcSwwyNMi+XlfRfBc6Zdzuk9g2twmBTVRWKKj9+IiiBMr1056acccbwMdwumArpye91gL6X12hCAJMrsVBzpzImOb34KurVzSRVTN1VdhcRolAag=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by AS8PR03MB7750.eurprd03.prod.outlook.com
 (2603:10a6:20b:405::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 13:26:39 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 13:26:39 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net 09/10] can: esd_usb: Fix handling of TX context
 objects
Thread-Topic: [PATCH net 09/10] can: esd_usb: Fix handling of TX context
 objects
Thread-Index: AQHcK6j+wOEqJnEKv0WpYW3A6XA2zbSf54aAgAJu3gA=
Date: Wed, 24 Sep 2025 13:26:39 +0000
Message-ID: <3e810a325d0652a3b709807d2fbd7f8007a9f733.camel@esd.eu>
References: <20250922100913.392916-1-mkl@pengutronix.de>
	 <20250922100913.392916-10-mkl@pengutronix.de>
	 <20250922171719.0f1bdb28@kernel.org>
In-Reply-To: <20250922171719.0f1bdb28@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|AS8PR03MB7750:EE_
x-ms-office365-filtering-correlation-id: 35992c1b-ec40-4878-1208-08ddfb6dfe38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RHZndkFZaHFMb2dVTjRhdENPRkZLN2ROaGxqMkFLS3NlL2ExaEhjUHUyUnc1?=
 =?utf-8?B?YStVY0JodFk0QzI3RCtUK0FvTzVvU3VBNHhyT081SFV0NEpsbXdwRkZLWlhL?=
 =?utf-8?B?Yk9jT0VpSjdSVkhZS2s2ZWVLZXErQ3Z0Q21CUVdqSzRwbU1vT3oxUlRFY0xo?=
 =?utf-8?B?SFNjTEFVNWxxdW1SUVdWMmovQWVXdVFsRTVPWm5WclhCeDNsSlliN3pGM1cv?=
 =?utf-8?B?SFhmdnd2TFVXSDlyVHIwWU1Sc01kaVJkWnRkTXF4eTdibktyNnRtTFI5YUcv?=
 =?utf-8?B?VzBXNlFGcmNmOHBqTUJoVXZVMGRFbGJZRURoUjJzUnRKOHV0U2RWalhFZ1l1?=
 =?utf-8?B?VlZLaEFBWHdIOTZiZjh2WWx3RndxSkFOKyt5bmNMZkd1c2VBcXZqRWNkVDdF?=
 =?utf-8?B?amhQT21QRm1BV2RIeDNhNWRINUZwR3V0cUhxWGREd29GajlxcE04RVhINitM?=
 =?utf-8?B?aW9meW5GaURGTG5iK2dXWURxdGY1VWRMZXFFY3JnamE5b1JhWFBLK3dYemlD?=
 =?utf-8?B?QlN1UWJjTFVsWnFMRXBNbVZ1K0dLb1VsemFrVWtURmFvalptS2l0RlpBR2hY?=
 =?utf-8?B?cm1KQ3Y2Z1pWdG94UTFrSzBoNEllM2krbjhDc1ZVMmNkTklldFlNZWkrQnBH?=
 =?utf-8?B?eVhVVm8xRkgrbndUZCs2UFlEWnJZcmhyc0hHbmNuV0tTREpIZnQyQTBMZUVP?=
 =?utf-8?B?Zk1MTUFERGxuZjRaYmltOGpBSWZFYlE3cUhudFFmQnU1bnl3UTZqWmVVRlh3?=
 =?utf-8?B?Ynp2UzY0SkVrbDB6elhuejcrU0xnb0xNZk40ZlR6M2J1bmlzdStaMCtoR0t1?=
 =?utf-8?B?M0pHbmNjVTRHYnNsdFlvaTArdlU1bzM0b1pra2drbmo1UTlNTnpJYUhWbFVn?=
 =?utf-8?B?OGdjWXpCN1VEditLUytObTNjR0sxQU9XY2w0ajBrQ3VKU0dJVDJRc291eHBx?=
 =?utf-8?B?RTFNakd3UURyai9JVnI2N2xlYUg4aXc1Skc5c1VyVk9jeXE0UjBoSUZMZ0tF?=
 =?utf-8?B?Yy9jL3R0RVp6dTY0SytPU2dNSjQ4R2ZnWmpXTWVQM0xLRUJYUk1VYzRjVDlX?=
 =?utf-8?B?WEt6T3doSGhJejYzK3hYMjZBcHp6K2FOTGpKbzBQZlE4SVlzNldvTVBXMUx5?=
 =?utf-8?B?eDc5ZUxqcnRWRHZ0MVlBK0N2bHA3clhJektCUWNIZE5teGdQQTV5b0w5bjVK?=
 =?utf-8?B?NzdPSUNKbnhZalNKQ0E1a3RqUXkxaE1TRFhtN2tPZS9RS1hwcWFHOURsZWV4?=
 =?utf-8?B?TjFwRXl4ZkpTRVpEK3ZDQTZvQ1FBdkh1UHM2SGV3akhua0lyT2Zsa2JWb3Ez?=
 =?utf-8?B?ZHZIaXhjU3l2bXppd21xUnllaG5OM3drZEozSW9VT3YxOW41UTlEcFBlZ0dC?=
 =?utf-8?B?b1ZIWDdWQmNwL1kySm40clkyWVVHS1EwSUlMd2Y3NDdkc2ZSZDNPckJ6a0VD?=
 =?utf-8?B?RDN1elRKNmZ5TFBINDdGMmJremhGYlpIajhKSXBYNkJVajZXRSt2V1FIejRP?=
 =?utf-8?B?TkFENFgrcmJGcy9OR3NNenVPbG9lL2xMYTlxUzJ2UGhtRzhBMFFKeWRodW84?=
 =?utf-8?B?T0RXS0QveDdBZzdXeVd4dGxyVlRtMk1NeHFjOVh2MVZTT3h2RHF1bkdmNGFs?=
 =?utf-8?B?L3UwejlIUEs5M1lpZmpYRGs2VlFRRWt3ZHB1cTFEMWFBaVZpbVFGbXNtckVX?=
 =?utf-8?B?cFFEZkl3VUdQektpcytLVFpNeHBnRlFUTk15a25tbkJlZlN2LzRDNW1oZHFN?=
 =?utf-8?B?elBVK09qV2VJaGlIMTkwMkFjV1k5Vlg0YVkzTm9HZkRzdXN3SEpOUmFZWnMw?=
 =?utf-8?B?K0dNbitJUXhrMFc3alFCTnNUL2k5OVF3NEZETWtKbEVjWDJDM0ZkV3dETzFO?=
 =?utf-8?B?S2RDbnd1a2F4N3I0WDFoeDBKQ3RPNWozLzJ2cEVhcUNWalQwNjR1b1Vya0pz?=
 =?utf-8?B?UE1XQmxiU2pyU3l0T2l1dHNOYXZvQWo1RG5OMjBOK2tKUjZySGIzTklxTVdG?=
 =?utf-8?B?T0ZhbVczZjdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QytGSjczaWJBNEVsUTJCRHRYNVFZanY4Y3EvaWloekN6Wk8xVnRHUnFkTER3?=
 =?utf-8?B?elNmcHhXOThrdzB4dHd1dGZEaUFpMXRhOGM0SWkxUWJIdzJZbXhzcEFQcVJQ?=
 =?utf-8?B?NlU5U3hmcEpidlBIdHJzN0xNemF4RTNiTThRZWFYVTViaVQ3bTB5cm8zTTJI?=
 =?utf-8?B?ZmRiMVBRTk1jQTd5SWhkSTQ3RnIyZGVBQ1ZnNUlGM0JmeHBDVEUwR0t3L0NW?=
 =?utf-8?B?WE9yZmE5ejVYNGZJUzBhYzF6czJwU09NK0kySW1jQy9HakZpY3hyYXZ0RmZu?=
 =?utf-8?B?dWFoTHlyYzlWalN3bXJ0dmtWc09XN0hqbFZGMHVVVHdaVE5kMDJBWWVmN0ZO?=
 =?utf-8?B?VDJYSnpITWEwTXpGeWZyWC9GTkM4dzlGTE5IYVEvSE1zOFFTelVuOXc1dzlM?=
 =?utf-8?B?Y1IyckFBU002Z0xhQXErc0YzN2JuNWZrdTQwSytjdEl4MXduNHJSOW9Oc2tw?=
 =?utf-8?B?ZW1YM3NFSTFmdUYwbzdwQ3hsMlhKUm03THAxSjR5TjMzbk5KblVYRE1lK1Vs?=
 =?utf-8?B?YysyY0Z6N2RjQWNZRngzSi9WK2Y1VVlSZFdGaHU1Z1NQc01LMXVDTWliTUJx?=
 =?utf-8?B?MTI2bjZvWm1IL2s4RlIxeGlOKzBCVi9iMUhOUEpuTlNaOTNSQktLcGZYaWRW?=
 =?utf-8?B?ejZmNHFrSHBuWEZNTC9IaEp1ZWp1MnE0U2taUlBKeTVSN2gxNFRNQy9tMitt?=
 =?utf-8?B?cG5lZGhUMTcvNjFNd3NCN1d3RnNDekRDVjJtTHA1QkdkQzRDcTk4VzY0T0tO?=
 =?utf-8?B?ZWZVVU1LMWZrb0VnR2xYdm9YK04zakRkQzJMTFRRazNoWUw4WHJyZmxLQURE?=
 =?utf-8?B?NlB6Y1dNS0ErMFNCQTZvNGNzc3NXSk94UjZFOXNGcU93Vlh5L01iNmV3N05r?=
 =?utf-8?B?NWEyUkdjNkZ5K3l1UnV3RUFUUTVMUHpUUGtVQmVXZHVxUjU1Z0NFOTUyMmU5?=
 =?utf-8?B?N0Fyc0dRVCtLcHlkcDhRZml5Y0hEMmFRK0lJWjhMTW9BcitzQXlFS1VoZVcx?=
 =?utf-8?B?cHdSbkEwK1FPUlJNN3VPcHQzYTVucld1YlIybkM0R2ZYbDF0RThwRXFrL0kz?=
 =?utf-8?B?MVYrS0xtU1FUTTNmUDJxUEVQdnBRMVREa0Zzenk2aW1JNVBKM0xla2FObitB?=
 =?utf-8?B?VGhwL1dFeVV6dVJmUW5nR2xleDR5Szc1aitMOUhsaUlTQnVJdzdFa3E5bDEr?=
 =?utf-8?B?NjZDcWRhSWk2NGYvZXRlRUo5Q01yOC82dm93VVRlUit5eHpicUhhWHlFYWxy?=
 =?utf-8?B?QlZpRS9DV3FEK1JXanY5YWt6NlhvSC9uV2l0YmJOYnQ3a1pkcnJRRloyM1BL?=
 =?utf-8?B?MnFiZ2U5ODNETDBqUU12Ykl3eThHdmJxREZ2YnBnUlNmZUE1VjVQdUViZDll?=
 =?utf-8?B?TU55UmpnZU5pNWI3M1QyM25NSStITE9VaEI5a0pZUERseHNyVHZKUEJ4bzBC?=
 =?utf-8?B?Ri9UUGxMVTJxcTduZldhdkNtYXdrUzJKOFNJVWxrdGxVclB6V0dBUjVWWjQ3?=
 =?utf-8?B?VU92WmNqeENSbE5TakZrbnlOOVFXQXRtU1pGOGdmQVpUR3N6bDNIdENrVXNK?=
 =?utf-8?B?QndTR3Bob2FHelhlc3dJY0NJUTN6dUtzNjZ4OEh4UWFhSjU5SzZFS05zc3VF?=
 =?utf-8?B?SCtxK0pZUFgvTzNrU3JtMFFyVkhmTnVlNFgyYkZ6TFpvbzEwQVRSK1RINEtD?=
 =?utf-8?B?aUxUNDhqUTZEa0NPN1BiNURmUlVIb2RrQlV0UWlkZXZkVVlHZE1vMTZBczFi?=
 =?utf-8?B?RUsrQ0cyVTA0MlJhLzlQb3p5YVdFZGQyUkQ5MW1xWXRzU0JVL3Qzd3JDQmMz?=
 =?utf-8?B?VHJLYWZ2MGQwWXkrbzVYcjJOWVdGQzlCdjFHVTV2dE82L1Z6N0pxOUh2QVdQ?=
 =?utf-8?B?bHNwK3UvWnhTNk52TEJyMW5xNFIyc1pCdGpJb2lSaVVORTZ3RW1KaW5WRkZh?=
 =?utf-8?B?UnB1bFlOMExJRmN4TWM5V3ZmbXhMQjhHNmZYNnV6dzFoc1krWVF0dTBmYWpX?=
 =?utf-8?B?QVlhdjRKV1cyOEd3eHhFWmtHbTN1ZnlrMHNSYkFnNGRKR2dVL2dJb000MHM4?=
 =?utf-8?B?OWJrQzhXR3IxeVNkemQwcjg2RlNNK1UvZUN2MlE5WUU5Q1VBdVJacjV5WGpN?=
 =?utf-8?B?aDUrVDlZcm0vUktPc2NUeDQ1Y0pKMS9PaHZzMTNQVjhWTXQrZUZWZDZId0E0?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B989A3EB7A89214B9957599288E41D70@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10517.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35992c1b-ec40-4878-1208-08ddfb6dfe38
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 13:26:39.1201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01UYk6XL+PkCD5/UdPwlSyiVwl6CON4KgyWT9ToZVNEg3DTQ7kwmg6hHChz1J9IopZKjKqGHc/SvFj1KQ3t+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7750

QW0gTW9udGFnLCBkZW0gMjIuMDkuMjAyNSB1bSAxNzoxNyAtMDcwMCBzY2hyaWViIEpha3ViIEtp
Y2luc2tpOg0KPiBPbiBNb24sIDIyIFNlcCAyMDI1IDEyOjA3OjM5ICswMjAwIE1hcmMgS2xlaW5l
LUJ1ZGRlIHdyb3RlOg0KPiA+IC0JCW5ldGRldl93YXJuKG5ldGRldiwgImNvdWxkbid0IGZpbmQg
ZnJlZSBjb250ZXh0XG4iKTsNCj4gPiArCQluZXRkZXZfd2FybihuZXRkZXYsICJObyBmcmVlIGNv
bnRleHQuIEpvYnM6ICVkXG4iLA0KPiA+ICsJCQkgICAgYXRvbWljX3JlYWQoJnByaXYtPmFjdGl2
ZV90eF9qb2JzKSk7DQo+IA0KPiBUaGlzIHNob3VsZCByZWFsbHkgYmUgcmF0ZSBsaW1pdGVkIG9y
IF9vbmNlIHdoaWxlIHdlIHRvdWNoIGl0Lg0KPiANCg0KQ2hhbmdpbmcgdGhpcyB0byBhIHJhdGUg
bGltaXRlZCB2ZXJzaW9uIHdvdWxkIGJlIGZpbmUgd2l0aCBtZS4gDQoNCkBNYXJjOg0KSG93IHRv
IHByb2NlZWQgZnVydGhlcj8gU2hvdWxkIEkgc2VuZCBhIFYzIG9mIHRoZSBvcmlnaW5hbCBwYXRj
aA0Kc2V0IG9yIHNob3VsZCBJIHNwbGl0IHRoZSBwYXRjaCBzZXQgaW4gdHdvIHBhdGNoIHNldHMg
bGlrZSB5b3UgZGlkPw0KDQpUaGUgY29kZSB3b3VsZCBsb29rIHRoZW4gbGlrZToNCg0KCWlmICgh
Y29udGV4dCkgew0KCQlpZiAobmV0X3JhdGVsaW1pdCgpKQ0KCQkJbmV0ZGV2X3dhcm4obmV0ZGV2
LCAiTm8gZnJlZSBjb250ZXh0LiBKb2JzOiAlZFxuIiwNCgkJCQkgICAgYXRvbWljX3JlYWQoJnBy
aXYtPmFjdGl2ZV90eF9qb2JzKSk7DQoJCW5ldGlmX3N0b3BfcXVldWUobmV0ZGV2KTsNCgkJcmV0
ID0gTkVUREVWX1RYX0JVU1k7DQoJCWdvdG8gcmVsZWFzZWJ1ZjsNCgl9DQoNCkJlc3QgcmVnYXJk
cywNCiAgICBTdGVmYW4NCg0K

