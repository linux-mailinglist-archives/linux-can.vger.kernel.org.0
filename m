Return-Path: <linux-can+bounces-2238-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63109DA335
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 08:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7580B16536D
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 07:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DC1547E3;
	Wed, 27 Nov 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nEMLlwNe"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2070.outbound.protection.outlook.com [40.107.103.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC415381A;
	Wed, 27 Nov 2024 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693056; cv=fail; b=MtjxzZuBCqpJ1wFoQxHW0gxyHkQQjM3saPvLrUqVxInp83VL54upj2DMitJZZUhAXc86TPvjvZH13Jjg9TeMesUhIeyZgrM/4UPQYb1x6E1kHTgbxg/U36fF4fRdKIFOk/Lh6+PRwbsIUD/PyLTRQrnX7EKoUX8JpdYptWZ/7vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693056; c=relaxed/simple;
	bh=NlNSigWv2wDPUu2aWizVZ8+Y6dRfvMH9fOlavi1STmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NJLvmeY92ogBsa0yaHV/zT25ZGss8BtSGAH4r3rFyb2YBCEEh9ba8DvGrVEDwXic7R8kqZFKP86f/l4rztucrHXzsb1AxMEdqGFAzlMxnVuB/2yFUczUCjrhwiYko+2664I9LYrlqZDV9gdRoeEsmABBLWdILrTuFZz80Ydvvrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nEMLlwNe; arc=fail smtp.client-ip=40.107.103.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8BlR39FGmQ6mikHTV1KCYxyMI3YvuFAbRxmRpluqABTap91Icab7IxrKW6nudlA1pnXzC2RnhfhUZ5j4NLAkTOxRdLy49Zy6M6UWs1eDMzPkKS6aSCUGf4+a/KZetzcIPZVuEolkbA0dbLm5jRXXXSMfcpJ7TA3yh4tYeoD2xklOE7H1lnkvF/JdkeQj1n9fBpMpK3OfKg67JX93w+/w73LILAOilKaNCjQ6c7SU0Hst26CgSCfMTOBs9HnP7k2nPOvkhc7Z12MN83Vyg+K18lksuLadqj7NF6TY9S6j4NJM3t3ECYNFPBIwVmfwW4lCtG0k8D2zZyK0QEfyAUGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSEVMuwf03DRrQzrZDga7ci3EuLRIEq1b7d0kNTasPs=;
 b=g6Sx4hmctaT7Ob8KcKsokgzlewPEEFprLGvCT8N6a6lZvRWrj55H/t3T2govjCBvQip5GhBpFAl9d5+eoMjUBumRrcc+bYLJeTNi5K98tGR1ydioGQg+LytwN4y+jxaJqclKpREFBfThdqlNQYYPX5+R0Lj4/vA6JCRr1lEhQ0kpYqWUzMvLoFXv45QIKltiQ6oRGZUjGERPzCmHJ5wW6zFJscP5TURbIvtwRCN/ZnWszmdgNrzBJop6vzgbsEw61dQiV7joH3GRW6MNOmq56rtVtb2KVVwcKxwezJIaAXtSun+kXHHcQw5xI05bYDfsaNgnP0M4UciSdhWnhmkV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSEVMuwf03DRrQzrZDga7ci3EuLRIEq1b7d0kNTasPs=;
 b=nEMLlwNevcQXmD2df+PwftN1+rt3Fd3QGJ7WuxS4KsoISPp9gjuF5sOIlJpNldtWyG4HyEnjf7Cdxu8ZmMUbYX4e3bYx+peEI7X2c/LaRePEimx4PpaRwIPsilLTCCDLrW+hf2dsqws+8V0CIRbAA6IeNFArbdw7WuKbTDfPL3UQyXPlI+OIE3qXAILMOxKyirsD7gpSH9Z50RMqRnL/ILSKZhlxLsVRJ3GIwJiwZzRlfQikzUpLKhUwWsWB6YVoLUVxV/A8wW+QjbQOz1YtlaagO/YJuZMbouqtkZrKXN8je452Bd0O7yL+sqeSmxtO+hSkYkR/rqJUwNNPP+XlJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB8PR04MB6969.eurprd04.prod.outlook.com (2603:10a6:10:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 07:37:29 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 07:37:29 +0000
Message-ID: <a74f2389-ad24-47df-ab2c-6d736266750c@oss.nxp.com>
Date: Wed, 27 Nov 2024 09:37:24 +0200
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
 <e8d11c7f-0bf5-44cd-bb2d-a7e454905e53@oss.nxp.com>
 <20241127-hidden-termite-of-fruition-46bcbe-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241127-hidden-termite-of-fruition-46bcbe-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::35) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB8PR04MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3b074c-cbf8-47fc-4acb-08dd0eb658db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmVTMlF2ZHVoMFErbTBGOVloUVMwYURqSE5Rc2tZOXJnZ0tYUWNUNmYyRjVp?=
 =?utf-8?B?VHcydVVqa003dldrT3ZhdmNoR25tK0l6MnlFNWwwOXlsZkdwL3ExOGE3czRr?=
 =?utf-8?B?UW94Q0JaSy9BOGY1S2Q2aEJYWCtqNGtGRlU1R0FWUXBKYUdrVDZrRytBVkpi?=
 =?utf-8?B?aHc0VEVIc21UeFdra0FOUVl0WTlVc0EvN3VTcTdxM3ovdWsyeXJIazBjREpR?=
 =?utf-8?B?ZjNsUGp4OGxnanRSYVI5VVhzNVR1WHdSRWpSTkZJZENHNDR0dXFZWFRqemxD?=
 =?utf-8?B?OTh0WnBBdnA2cmZDV3Nkb1RqbThrc3BQckZ0TTJ2Q1JldytQTzIwMzY1S1Bz?=
 =?utf-8?B?cGRyQVlZcy9JVzdnUzdTRHF0bHpxTTk0b2FLM2FwZTdWa25KanNHRmwxNGRs?=
 =?utf-8?B?R3VPeHVOL2Z0R01DWkxnSzN1ZlBLVXJWbUNycUtma29TcEdNaytMT3dHbXJH?=
 =?utf-8?B?c21EWDVmZlE0VmR4dHI2L2lza2dWUlJyaTBMMlpxRFMyQktIZmFVMzIwSCtO?=
 =?utf-8?B?M0lhZ1orN0N5UTZpTExIWTVlQ256WjdNUVpwSzdjOFFJSDRJWUh0Qlo5Zkc2?=
 =?utf-8?B?R3ZtdU9jUDBNYWdrcXVCTStISTl6RWpkS1kxNm1ZL1lvcUF3Qyt1VmRtdTI1?=
 =?utf-8?B?WFYrNDF0K21LWmpYUGhhMVVQOGtzT1ZyK3ltM3R2V3hjZGxlRE52bnkxNFhq?=
 =?utf-8?B?cHF2WDBjMitwWWZHWkE5bndzTTZld014akxGcGFFRjN1NTF2QktwbWc2Vndi?=
 =?utf-8?B?cFlFYUcvZytVZ2ZiaktQS2N6NGVSekhsSGRXZ09zazJtNXRYamhLOHBqcmx1?=
 =?utf-8?B?cFU4SHdGR3VkSlBnRXNXWTlXdi9VVjhTUzA0Rm1xUlg1Z2pkSUw2bjQ2OUhv?=
 =?utf-8?B?YVd3a0ZQZGdoamRHZkNBQjZZTnl0b3d4NEk2d0ltR1VlYldYK1RUbkdkN01Y?=
 =?utf-8?B?cUNJejc0dmpMRWpNNFp3YU93QURwaTcrMVN6YjE2NjE2SGJzRDl2b1YvM3Jl?=
 =?utf-8?B?dEpYMXZyZjJ5U2pXQ0QrWkJuaTFqZHRxM1FOcWJkbFdGTnBoZGpYQ0l2MlFa?=
 =?utf-8?B?a08xNEI1a0ZkZFR3ZWQxbnBQbUtRUk5IY0wxc25VNFgrY1NjWm9TeUdTQTVR?=
 =?utf-8?B?WG53SW1MMVNCWkJvUURiMjR3SE52V1hMc2pEQjlCcW1lcm9nQ2hCWmFhK0Q5?=
 =?utf-8?B?N04yZGx3K05ZZG85M08vbmMxWWpyQlV3RlphNDkwYklFR2ZjWlpNVDhOaVox?=
 =?utf-8?B?V25BWDVTT25PSnJxS0QxS01hbWJ1aVBKckNlemwvWVZlckdscGpqdGQwQmVC?=
 =?utf-8?B?MU9lTVUrcXVKSFVMN1dlbityVUtkU2ZkWUpudkZIUEhTY01Id2d5Yk1VUFpy?=
 =?utf-8?B?aHE1MnFWT3ZsQ2hyMUlJQ1ZrOFlqSDY2SVFQRTByWGtpVXgvc2czZXVNdHRa?=
 =?utf-8?B?SlNhUHdiKzVwdkV1MkRYb0w4REp2Yi9xNzhnVTBBUmpjTVM4SERGWGNMTjI2?=
 =?utf-8?B?ZCtScTZhWWZHdTJYazhqZ3A5YmpVdkVJcjdRVEMzS0wwUUxXQWwySXhGSXEz?=
 =?utf-8?B?d1kzeDU0NGNOaENrMEJrbnpiUGlVSUoxZjgwb2duZ1BCNndINDZUNUNlRHRV?=
 =?utf-8?B?K3NHdndld0xYV0hXK05FdXJFd0NpdGVyMnlJSGgyWG8xeXVmT0FubFd6Yndx?=
 =?utf-8?B?RFpPeHVkdGE1TEUyVXorVjJFQ2pkaDRrbGxWQzFLc05JM3owaklZUmhUSU1L?=
 =?utf-8?B?eFdBVzRiS3BHaDBXbWVvSWFzSGc0OWgwWE0zbW80R2Rlam1UZG1Jc3JGKzhm?=
 =?utf-8?B?UFJ0KytqaXV3R2dDeUNIUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ZxQ0hwSFZ5aWxaamlNQlBmUHg2OWVpbmJNVTVqZXI2K2I2MHJjdXM4L0pD?=
 =?utf-8?B?d2N5aDNyekU3SXM0UllEUDZiazRVUk5SdHZwUEdOMURRN2dFYnN0dUZ2VkRq?=
 =?utf-8?B?SDlGL1o0ekltaUZIeEtHVnl2ajF2T250a0NrOWRTMk1zOXBtRDhMYU1uUEg3?=
 =?utf-8?B?dnhiaS9jTWdTRTNRSmUxVUYrYmNiQjRqYjZNVGlWWXM5TDVVMThSR3NRSG9h?=
 =?utf-8?B?aHdUKzBUN1h4ZWVoeDBzK1RDWThBNllramhyMHJDUlIzdjlZMURaQlhpekVU?=
 =?utf-8?B?bUQ0MHhqMHI5bERlaXZOZHViMjFnNU43THBtMzNoNDhFODUxVjVIWjZzRW8w?=
 =?utf-8?B?K3MyTVZvc28rQzB5R0tNQmNGN3o5Q010VVBlVzJ0V1lVTkhOdzh5UlZ0ajZD?=
 =?utf-8?B?S3R4M3BaWVlFNGlMYVFzNTAvQ21ENG9jVUhhS2JJSjVwUzMrSlVlUXFvZ3Rz?=
 =?utf-8?B?MC82dlFyOFYrdFpGbVl2V2QyMUZSTUlLRWNCdmRieUl5czFrTHUzRm5TM1Bz?=
 =?utf-8?B?SXVXYTk4bU9kMU04aDk0L1RpOWlxTWhzekZpWnlMN1V2SjRaSzZ0VnNBMTY4?=
 =?utf-8?B?ZG1TN0ZjSXdxZlhSTlBhSmhiZ3BOVVN1NnVBV3JvWnowL1lEaWdGUXBlMFlu?=
 =?utf-8?B?N0RGMVg2RDhDZWVra1NVQXNldS9JczVDUG9jV08zWGdVR0pHTlpibitOczZK?=
 =?utf-8?B?ckZaQXZlLzBac3gzRHdkK0lwVSs2YXNJRS9nMHE0SjBidnhOaTZ0QlI0UUN5?=
 =?utf-8?B?bHB0V2tvaGxrR0lDVUl2d3N3ZlE4cnpTMHh0V2FTaDArbHFhajZrcFlvNHRL?=
 =?utf-8?B?bWNRYUxBbm5tdy8rY1JTNk9IZHhBeWExUmF2ZHN3UmIrT2VaMThjZUxWSkdm?=
 =?utf-8?B?RzVPbTNKWEJsdXNJNWFkNmltaXNIazQ4NEZ3ZDY4aW1RellWaDZyV2dQRWQv?=
 =?utf-8?B?ZnNocjRIRVpZZEFZMG9kdWdHT3FvTFJ1VVRtYUpIZEhxRTZFZlNNUkh3eW1K?=
 =?utf-8?B?dlpGN0NQRW9aRFluZXlLK0VwVWs3bklKeGxETWNMOURVRm1IejVHbU90ZDl2?=
 =?utf-8?B?TzJHeEp1YjU0am55YWloY1pWQXRTMCt4N3NuajZnNFl0NDFhQ0VGVTE5eVU3?=
 =?utf-8?B?Y2c3L0NnL2I4dXJ5Q3FiTS9hQzJvb0hFMkhVNGIvU0ZzNGJTVXBmUnNwRUJo?=
 =?utf-8?B?aEJzSmRyNDcySnRGdmtoalYrUDBQQXZzeVQ2ZklXUEl4YzZRYmRSLzEvd1Za?=
 =?utf-8?B?L3MvVkVKazlCaDZuZ3hmdUc0U1B0V1l2bG1KcjlZSzJ4Q29jcFFhZlBEdlly?=
 =?utf-8?B?MUs5ajA0dlplZnlOc05VNGZ1cGg4Z0JyU3pUczdaZm9heVdJQlltMlQvdjE2?=
 =?utf-8?B?UnZXWDZuTW0wTXN4TUxNTzJaTTdtZ2wzMlV4QlRqSXdpajZocmo2WUpDa2ZJ?=
 =?utf-8?B?clZnVlQ1WTQxdmJJaEdDam02YlNNKzlYZ1F2V2JHcTlrZjZrQWx3TkpLQmJO?=
 =?utf-8?B?TCs3V0NSSFptdzFxamRqOWptZmQyYzNqMmVuZW9qVDVod0YyeE9oeElMTEpD?=
 =?utf-8?B?SFZtS1h6eGIyOFZweWNVL2RnallpMm5XbG1saXY4RVRaM2JBcS90OXRIT3B5?=
 =?utf-8?B?cW9oTnZYb1lBT2lFZHNkQk95OXRTeWdWSWF0c0xkRUlwa25MeTRwZ3F5M3lo?=
 =?utf-8?B?TUo3ZW01VHlRRGcyKzN4L2tqY0FxVVczRi9nZTV0Q3lSdTZQQU5LdHUvYTdK?=
 =?utf-8?B?Z1dFOUtmV2pZWUh4VWwrUG5ZOTJwM2UwYWtjTlF2Rnk4QVNvM1dkTGl2MXZI?=
 =?utf-8?B?V0NWeXpxTkFJekZTUWphV3Vmb0xzZlVkdFNOc3M5YTBncEhWV1VhYjYvTHNy?=
 =?utf-8?B?K2tKRmFYV3hoNS9ldExRNEFVd2MvdHlJSjgrMnFaZ2ZPQWtSUy9DcmlmMlFw?=
 =?utf-8?B?eHRpNUhrR1pabG9vMFBmbTZ0QzZxQy9oVUp3dXJWY2xKSHBta20wN1R2RUYx?=
 =?utf-8?B?cEhsNDY3bXhjZERlMElpc2NBcCtHb1NKSlZYQTdDdHd2cVdVTnhTZnZFcWpk?=
 =?utf-8?B?ekU1NThhUE5raHZLTUtLR3VjQlR6eXBVNm9xTDBJOEhRVndxelNXS0JGVDJI?=
 =?utf-8?B?dkFwMzY2MVRnMHdPYjVkVnkyMDJOeS9NTWRmeUIyZitPWlIvNFZmUDAzSnRh?=
 =?utf-8?Q?KYWriBG3BMkcXwM5ecHFfI4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3b074c-cbf8-47fc-4acb-08dd0eb658db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 07:37:29.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLY7MHbzfT2iBFfR8da/EOHVqp7nYABdB0EiAliY2sVgVMJCBEgtDiojNZo0q2z6KQwQUoKvs1ZgxAXMW4Aj2hd6w7uqVH6VcscHd6ODcJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6969

On 11/27/2024 9:23 AM, Marc Kleine-Budde wrote:
> On 26.11.2024 17:21:14, Ciprian Marian Costea wrote:
>> On 11/26/2024 5:19 PM, Marc Kleine-Budde wrote:
>>> On 26.11.2024 16:18:41, Marc Kleine-Budde wrote:
>>>> On 26.11.2024 17:15:10, Ciprian Marian Costea wrote:
>>>>>>>>>> +        interrupt-names:
>>>>>>>>>> +          items:
>>>>>>>>>> +            - const: mb_0-7
>>>>>>
>>>>>> I was wondering if it makes sense to have an interrupt name not
>>>>>> mentioning the exact mailbox numbers, so that the same interrupt name
>>>>>> can be used for a different IP core, too. On the coldfire SoC the 1st
>>>>>> IRQ handles mailboxes 0...15.
>>>>>>
>>>>>
>>>>> I am ok with proposing a more generic name for mailboxes in order to
>>>>> increase reusability among FlexCAN enabled SoCs.
>>>>> Further specific mailbox numbers could be mentioned in the actual
>>>>> S32G2/S32G3 dtsi flexcan node.
>>>>>
>>>>> One proposal could be:
>>>>> - mb-1: First Range of Mailboxes
>>>>> - mb-2: Second Range of Mailboxes
>>>>>
>>>>> Let me know if you agree to update as proposed in V3.
>>>>
>>>> Looks good to me!
>>>
>>> Or maybe start with "0", that makes it a bit easier to construct the
>>> names of the IRQ-names in a for loop.
>>>
>>> regards,
>>> Marc
>>>
>>
>> That makes sense. Thanks for the suggestion.
> 
> I think we're almost there. Now you can change patch 1 to
> platform_get_irq_byname(..., "mb-1");.
> 
> regards,
> Marc
> 

Yes, I will also include this change in V3. Thanks for your suggestion.

Best Regards,
Ciprian

> P.S.: Actual support for the mailboxes 64..127 or the extended FIFO can
> be added in a later patch.
> 


