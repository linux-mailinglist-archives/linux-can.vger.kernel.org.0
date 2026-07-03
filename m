Return-Path: <linux-can+bounces-7993-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8X8sH2njR2prhAAAu9opvQ
	(envelope-from <linux-can+bounces-7993-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 18:29:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE47043DA
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 18:29:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=B87NpZju;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7993-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7993-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38084300E304
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B0C2BF3F4;
	Fri,  3 Jul 2026 16:29:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C33305E10;
	Fri,  3 Jul 2026 16:29:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096157; cv=fail; b=PM5fQAdGcPypJf7kcB4JnnV1B9xDVpweVYQpIFq9hFA+bk838mgwfDcmaBp/QI5HFgq9VWXN6mp76QCC1RkWXM+Vj/QMHO5uhZPIjIMs9qg5XwMeajpFniNsH3uBrZuh/x05OpMspsNKxmrZZPqsphJxtevE1jPCBP/0kv24KxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096157; c=relaxed/simple;
	bh=JgBRcUIvXEp9SCOM+NH9vr1ODUwImIhZ6NYlpoOuD+Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/FjzJr65tVyCDXBSnMN9ILYT5UgIGLTuMIqbC/PgMS9LShZXH+0//Cux92ZduzPuLhCdxYAJtpAXcpYOFgv2HEmT9gctCbkdm2Csls0aEcWeElw0qWQoqc3lMVRr7Qx5wPQBiYo0wRqV4Cir2i8P3mJY+9ZhCjTUXmDi/pMrXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B87NpZju; arc=fail smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783096153; x=1814632153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JgBRcUIvXEp9SCOM+NH9vr1ODUwImIhZ6NYlpoOuD+Q=;
  b=B87NpZju8D7xR84NTgHtfe8/QkVSDtxZrS27EORqaN+uUcYBAhmtwYaz
   srK4Csgq4oM/bdnvlMF3Oq1A15iAShEJnEBYyL/i6+UBNXe3IGRTGA2rA
   X9Bhl/aILPZN8fU/yjsDaCO+RFSUbyo252iy0B9+9po9bkmn2RSGulR/V
   NfD5td9Rw2HsndKt05WX/L7WE4ulJ+UzBrCVW7Gyj9LPNgqj4r23SnTXe
   3aq9DyTsjM02j6e5sNbPcLshYYxmd6UrpVn0eeJo4ig6uqSJg10xnWU4X
   x4LLWB4rYW+kZTRMjadBCn7da05A3Te9fYp4Ueh2ek4pdGZdtNkKhmpAp
   A==;
X-CSE-ConnectionGUID: 90+8nhelQ2GhHJx6F60/zw==
X-CSE-MsgGUID: DT39epoHT8CnBmre4lsY3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="87676623"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="87676623"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 09:29:12 -0700
X-CSE-ConnectionGUID: LaeIAGF9TT+/B5RTMIkVBA==
X-CSE-MsgGUID: bGXdeRidRuumMz8jYO0hXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="249793963"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 09:29:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 09:29:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 09:29:11 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 09:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VziYPHBvmEZYGd58sCGvfIEDI5S5gmUkhyhNB5+cz7W8cSyUQOQcORKUXPlAh4lLEJdIqt/ySzu8JVfwMDUOnDT0mzOLutseUHDY5N5z26JsobWvsoYEUCqr2m4cifFtCAi5sGTCIYNKt1+hHAXaR+6rXGxDFjIExHuwE/pj2RCnLPTFS1ESUNoUIeN8+hv+DwLL5a3ZmcfE0xA3xv4MLZfRxP3I0leBfBuVm+l0JZ0hfuJI7UbIHfy9ehWbaD3YIe+3ZYmX/vBXrf3uj/42Ky/tIuL8ADjlkNpd84byApdAjWmGQrt/Oey36mve892M9vJDlnCGnRwVk+sqMSv5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlVszaH/niY13fCpSxfKWyq9m3akMg1mKwMOsY5VtKA=;
 b=O9URFjmk8w0wpMuOdc1G1TP53r61hx0pi/3lEcwQdU73MrXMu3mFyJKKw9fM+QhSBz2O/AB7skB+Aj4MqnwPjRV+GaB4gEdUHDb14DqWfGQjfosSukly06UT3yr+NmwS5n2XmpHGSzdGaQACCZqLb+HOQuqxYQkP83KKMG4p9fgomC7ZBPb3bCvbBacUzLYfRtTdZhdPzq5nT0Hnx0GVRyCB6ywGqadX5w9hfRcfb2APh1ApUL+3a6+5vgDXe8ez/QFGcgHeWlC7lRF4JAogG9AzjVBWTslJCkrFuX5nVmk6e//5pcb5zjvQh4Dal9vekD73zzJ3ZODvy+2b4dTzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB6821.namprd11.prod.outlook.com (2603:10b6:806:29d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 16:29:09 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 16:29:09 +0000
Message-ID: <e7523ca5-427f-486d-89fb-d97c199709f3@intel.com>
Date: Fri, 3 Jul 2026 19:29:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel()
 on ColdFire
To: Greg Ungerer <gerg@linux-m68k.org>, <linux-m68k@lists.linux-m68k.org>
CC: <linux-kernel@vger.kernel.org>, <arnd@kernel.org>, <wei.fang@nxp.com>,
	<frank.li@nxp.com>, <shenwei.wang@nxp.com>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <nico@fluxnic.net>, <adureghello@baylibre.com>,
	<ulfh@kernel.org>, <linux-mmc@vger.kernel.org>, <linux-can@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <olteanv@gmail.com>
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
 <20260609142139.1563360-5-gerg@linux-m68k.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260609142139.1563360-5-gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0241.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::24) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 114684c2-0597-438d-3f4d-08ded9203514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: svnFszEye4s4NmjTYz1A6kaXyyxlL6VMv6aEcKzOp/ozLc5D+sjKfc5wbb0e1XVSCt9z8sVzt0xtcEAJJoMHYyxe6dcHEWh6Ck+6cSLMbCSwHiRrhktDpvXlG+AtV4TlPqQ05QHnj1PZDnt4FODK116dAcvCIsiq3kr3qa9sW+AB9s8JiexRLQ50rjqhHoMz27hgFTqJ4usI1kinwiN1oqSgC5cOWubNlON8Vu1QFp13Ib1yl+ENJYWtb6UEZ1r/4KXACxEWrHi5Qu/CU+y5/R80tC6zPfd0l34dTZcR/HcZW7MaOYkxYRZJ4j77W4Gml7EfYIBju7jOYb8I5bjsrsp4OdSed1VNVpopemRLZR+VoX4cLZdcdQv8ZU28PxozAn01Iu1DPaEDsW6hvUYTu5e/i+/GC3vuKGVCmeUfR+qTKR+zGy1YqHPla9nPzU0yMuDlMIxKLdLRLIVqNVX/P5zib1+W56hgRqSTIt7FRZ5a5gdVH2YVubvsOWfRK+APWsMovYt5oohkVZTwsy7qxY0ctWBVoFSikNIlMwsU2H1F4l8qW7AF+n8XSzzrlUbHfbVpoCNNg5Vw+X5nsikygXZro1ekfuBiG0ZB1y+B2lNb82vr6fvJ9CY9De47N7agyKeueKuR5fMwkLNlJsR91IUmPM44mtVdJoThbEFsdqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmZFNHVpQWVnL3h0Q2FGRis4QkdwVnpMOEEwa2NYQnBRWE5raWN1Yk9JdWNR?=
 =?utf-8?B?Z29nU1ByZlZ1WUtzbWh4V1FiU091NmdnRnROL1JLMDdReWtYb3I1b3hzZFZk?=
 =?utf-8?B?WEFkV0NjYkFHaWRWOVZ0c3hJeFlZNmx0Z1JPR2taQXB4Qkc1WFZBWThDV0RP?=
 =?utf-8?B?VmtJWmlnVkovb1pvMUtGT1h3RC9BZXZXejZYM0NTSmJiVmRwbzF3OEM3bXov?=
 =?utf-8?B?eHFxZmRzT2hESHhkd0dpSnJEQnppLzRtdFM2dGNISE9jMlBSNCtObHBvRm1S?=
 =?utf-8?B?TVF5ZytUaWs0dGRhbEh1c2RoOTdpblFEb2h0VzdYZmJGZkRyL21GZXRRUzRa?=
 =?utf-8?B?K0l5ZHdRV3NFY2tzdVl1OWNoUEZPMU5WOFhVY1NOL29NWmdSbjJOSHdpQ0ZR?=
 =?utf-8?B?NkNyQ21DOVE0enRtOXNrNEx0Q1MrRzJVRC9WSlVyY25KVXQvZXp1REM2N1dK?=
 =?utf-8?B?RXR0ek1GWnl2YytSRlJBUTFoU1JmR3hPb0RsTlRlWlRsQ3RQMTAyZVdCNDh5?=
 =?utf-8?B?UWtPbXF2M2pmeUhKNnVsUDZRR0MwMGY1VENUTnpLUWRSQWZ2ekg1THRSUURl?=
 =?utf-8?B?RTI0OGNqNk5UempJOFNZamNCd2FieGNVWkt6THREc201ai9UdCtHdHd6ajdy?=
 =?utf-8?B?SnZ1OUN1QWJWSUhwRlpUMWo3RlBYbkdOQmwwRmtpOGp1TktmeXhVRGRuNEZi?=
 =?utf-8?B?UXRoc1pSRFlibGZoUXgzR3NrMm5xdzRaUU5tOE5QUVV4MkFEME5QSHpMOWQr?=
 =?utf-8?B?aThJOHV4UTcvUG5JT25pVy9Eam1aczJqNHhJSGk2L1dHNXVWRGhLZUpydWU4?=
 =?utf-8?B?TXBZSGd4L3l4ZW1GaitNejNBa1Q1Z2tWTTB0aTdCbEtkZHUyRkczbDZXYzhq?=
 =?utf-8?B?RVZkT1lNSERYWTlsOWY4dFhJbi9ocjROaFB2bURScDFoUm5XanVQSFkyaDZp?=
 =?utf-8?B?RXljZHRWUVF2eGhBN1hheGp0ak4wWFZYSnFJcUp0NUZqT1QxTTJSZHkrR3Qz?=
 =?utf-8?B?bC8rMnMyV0d6VmJjeFIwNGw3Z3o0WnU2TTA2ZGtpV243K2Y1MTg1U1VJUk94?=
 =?utf-8?B?bHBvME9GRjFqK0NUVXJoZ3dzdG1USkhmU0VVY3JTZUJHQXpHb1VTMGZRSUwr?=
 =?utf-8?B?cXhIeUQrZUpBTE1YMEtDVkdoc2p4M201OUh3bG5MSHFlaGEwQUFXUE52eDJs?=
 =?utf-8?B?dDVCZzY3Qy9BdGtZLzAvMDdYMjViMys4ejRkekNkWVZuS1ZBT0RkWFBVVENj?=
 =?utf-8?B?cCtwRlY5M3ByY2tEK2hRN0w4V1VMZmRzWE9zeVZPZytoNXhrcEZhK2J4QlNM?=
 =?utf-8?B?NHZmRzRKS1h5dUR5blhjQmZmelpuTEoyNmhMclVIWWwrcGZZRUhKVFNrY0Mz?=
 =?utf-8?B?dkx5ZXR3RWlKVzd6QmpQUHFROUFwTjBCb1A3V1l5N0tFdC9EZDhoNkN2YUJa?=
 =?utf-8?B?VXVrc0RtU09LZ2N1T1VHSFkzeG11SlVuazlyU1k0V0lhQXdhSEduSUQ0eGY0?=
 =?utf-8?B?U0NITlJFVnBxMXdOc1RhL0J5cy80UnQrelIvZ3N1VjVHN0t3alJTZW10djFa?=
 =?utf-8?B?TGk1YlFkaG40eDdubEFjWGVLeENSNjRQR2JlTDNvc1hDckc2VGZ0cmp5blVO?=
 =?utf-8?B?T0FHMG45VG5yVGZmTFJXTFJSdHFiWVpkb2J1QVJrcVNWWjNHN0NGQzJRYlE4?=
 =?utf-8?B?NURYSmJvd01TQ042TTJyaStoMnZqR0kvTFkvSTRwQUpEVHBBdis3N2k2YlQ0?=
 =?utf-8?B?ODl5TGZVYlRzZUt3cS85Slh0U05jeDNzV29yRzlPcmtMZU9kUlEzaGp5b0Fz?=
 =?utf-8?B?NkdJd0ZJaWo3Y09CSHJvR25MOTl1N2VJdVNUazYxS3dsTUU1eFUzczF5WU94?=
 =?utf-8?B?TjJxanVuekpwNTVMOVdzZDluMUc2Y012QUI0RC96dDFMMHNFRE93UzMvS0dH?=
 =?utf-8?B?T3NDSlNvL2hhbm5xZmZkVnFHZUVwSlEyYjc0Sk82aEZoVzZmZmMwQVRzaFZm?=
 =?utf-8?B?RFc0dEZyZzVxcnVmNjhuWnBZa0dLMnBBaGsxcHY1ZG5BR05JTFVacW43L2VT?=
 =?utf-8?B?bVRQOHRJZFovL1BacVFUallKTE5RbS90UDBodjBIUWl5QjlodHFFb2R6ZGd1?=
 =?utf-8?B?azM1WjJ2cnhOQjAvY09EaWpwRUlqVU1YYVF1amxYdkZBR0NoTHp1M0dJeUpq?=
 =?utf-8?B?TFdjMi9SUHlSeFo4cjdXcEZVM3kyc1BHWDROV2FwajZvTVlFaVdRYko0ZzAx?=
 =?utf-8?B?d3o0RWpEWUp1aU9pQnUxVGRQNkRRNi9NbERtcWFpaXkveXlISjhNbzN3K2xG?=
 =?utf-8?B?UStLWkV2N3NTSXh1NzFDQWkwd2IxVC9CNHNWc002TENRUm9mQkxTT2htWkZm?=
 =?utf-8?Q?3ETN/pVUTMpgljFk=3D?=
X-Exchange-RoutingPolicyChecked: nBrq96n/oQdKJtjoqkKP6IFgKdTI1dEPP/aNflwNDSLUeaO1rvXYmJcJHRVmG4XNS8nnS7PETbFOt+a+fC8SCKcSVYqQ1t007yH29A0F83HUArU/1QBVyFoLJmxnVfvxpBj/IZScaJ69xB65mpPBWLqLOWQf7P0B6KKPlQe4lnDjHm/v6FFa5Y9V2xbGo99+5WFwUulwVOhHG8vqFIh+GfRI5CNpcd2JXZHiTOjsfWQdACh+r9pAK/MoHTmgh0DhKylb+8za7y1MQc714ruPo3trusjvJL8zO40qd2bXAh4F54Xhav5PQa1XZNtVR/pms5b9WnvMNf3jLw0zG0h2wg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 114684c2-0597-438d-3f4d-08ded9203514
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:29:08.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg9N0W/+dwQYRescr68D9T+FY3RerffQO01DI8Zip1pg1HXkMmGMNh0pEgyA6GSAP8jU4X2AUPHjx8NqxWRCVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6821
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7993-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[adrian.hunter@intel.com,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:gerg@linux-m68k.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99EE47043DA

On 09/06/2026 17:13, Greg Ungerer wrote:
> The implementation of the readX() and writeX() family of IO access
> functions is non-standard on ColdFire platforms. They check the supplied
> IO address and will return either big or little endian results based on
> that check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are wrong. This is now in the process of being
> cleaned up and fixed.
> 
> Change the use of the readX() and writeX() access functions in this driver
> to use the recently defined specific ColdFire internal SoC hardware IO
> access functions mcf_read8()/mcf_read16()/mcf_read32() and
> mcf_write8()/mcf_write16()/mcf_write32().
> 
> There is no functional change to the driver. Though it does have the
> effect of making the IO access slightly more efficient, since there is
> no longer a need to do the address check at every register access.
> 
> Acked-by: Angelo Dureghello <adureghello@baylibre.com>
> Tested-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2: moved from RFC to PATCH
> 
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 375fce5639d7..6853521e8b2c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *host,
>  	if (reg == SDHCI_HOST_CONTROL)
>  		val |= ESDHC_PROCTL_D3CD;
>  
> -	writel((readl(base) & ~mask) | val, base);
> +	mcf_write32((mcf_read32(base) & ~mask) | val, base);
>  }
>  
>  /*
> @@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>  	if (reg == SDHCI_HOST_CONTROL) {
>  		u32 host_ctrl = ESDHC_DEFAULT_HOST_CONTROL;
>  		u8 dma_bits = (val & SDHCI_CTRL_DMA_MASK) >> 3;
> -		u8 tmp = readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
> +		u8 tmp = mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + 1);
>  
>  		tmp &= ~0x03;
>  		tmp |= dma_bits;
> @@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>  		 */
>  		host_ctrl |= val;
>  		host_ctrl |= (dma_bits << 8);
> -		writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +		mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>  
>  		return;
>  	}
>  
> -	writel((readl(base) & mask) | (val << shift), base);
> +	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>  
>  static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
> @@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
>  		 * As for the fsl driver,
>  		 * we have to set the mode in a single write here.
>  		 */
> -		writel(val << 16 | mcf_data->aside,
> +		mcf_write32(val << 16 | mcf_data->aside,
>  		       host->ioaddr + SDHCI_TRANSFER_MODE);
>  		return;
>  	}
>  
> -	writel((readl(base) & mask) | (val << shift), base);
> +	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>  
>  static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int reg)
>  {
> -	writel(val, host->ioaddr + reg);
> +	mcf_write32(val, host->ioaddr + reg);
>  }
>  
>  static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  {
>  	if (reg == SDHCI_HOST_CONTROL) {
>  		u8 __iomem *base = host->ioaddr + (reg & ~3);
> -		u16 val = readw(base + 2);
> +		u16 val = mcf_read16(base + 2);
>  		u8 dma_bits = (val >> 5) & SDHCI_CTRL_DMA_MASK;
>  		u8 host_ctrl = val & 0xff;
>  
> @@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  		return host_ctrl;
>  	}
>  
> -	return readb(host->ioaddr + (reg ^ 0x3));
> +	return mcf_read8(host->ioaddr + (reg ^ 0x3));
>  }
>  
>  static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> @@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
>  	if (reg == SDHCI_HOST_VERSION)
>  		reg -= 2;
>  
> -	return readw(host->ioaddr + (reg ^ 0x2));
> +	return mcf_read16(host->ioaddr + (reg ^ 0x2));
>  }
>  
>  static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
>  {
>  	u32 val;
>  
> -	val = readl(host->ioaddr + reg);
> +	val = mcf_read32(host->ioaddr + reg);
>  
>  	/*
>  	 * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> @@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_host *host,
>  	 * fvco = fsys * outdvi1 + 1
>  	 * fshdc = fvco / outdiv3 + 1
>  	 */
> -	temp = readl(pll_dr);
> +	temp = mcf_read32(pll_dr);
>  	fsys = pltfm_host->clock;
>  	fvco = fsys * ((temp & 0x1f) + 1);
>  	fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);


