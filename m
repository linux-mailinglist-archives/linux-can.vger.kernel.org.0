Return-Path: <linux-can+bounces-5306-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03FC2AA2B
	for <lists+linux-can@lfdr.de>; Mon, 03 Nov 2025 09:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165E71883B2F
	for <lists+linux-can@lfdr.de>; Mon,  3 Nov 2025 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3AC28D8F1;
	Mon,  3 Nov 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="jTfjR2qy"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021130.outbound.protection.outlook.com [52.101.70.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251D27144E;
	Mon,  3 Nov 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159887; cv=fail; b=ljmTqlgQZaiRFwLpXYsgaMXWZFCaA8fsEWfHMc4o+5GCGAxYqpAsH13e0x6wJfLP0tttP8UqLdK4mIZET2X6HluqL9wemv4AD83K5Kw6b5N7+YVFxhmgEvL//TExGcuyNtu14Hqm/0gcFOs20QARsGVdyawUKO0R1vhdVrxupBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159887; c=relaxed/simple;
	bh=N0vhFeL2cMhLXWFd6FAQquNTgP0XSDFzTclzN6QFV3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=copyp1h3R0JLRf69zYxrfdDQ4Oj6Pw3ij3HnwtX+aq1TlSBDjkqHOuzzEUxX8RmOFk3p330ASbEmwnx/10B9Bv5XaOEqMIAXHx8bp26whFvS9IedKi1X7aZ7kSSEYvLnKEhR2khlVrSlQ4q4EE2Nt3HjeOogR0HOQz6+mAhwYgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=jTfjR2qy; arc=fail smtp.client-ip=52.101.70.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5A/IiY1SsmUTEcXuyTpfl5T/WsU4mX8eYoRl1yRDFIYHH0/FPvVrx4K/1NJCL11ZzazBvlsnt2lAyr0kk9+16RuqiHMbz67navO0uIS3EWOmYuYkI+mOMEG3YraUtd4VFxRATZbz/9p5oIlBrDZAYW/JHCebLMWRiVIShNQePSyUdIOHRgX61j//00mgu55PEuy/sUELag4Ll5zKthPEwffPsJZwvsJVD9+O/rkjxkklkZDSymL+cmBecUh+Y5GAzPEix8Ur4F7N2sQ9t/k9TJ+/8CMoYo6XMVkFpSL9j55Kmo04mYa2t/oWbMUasPIxtpa2UIgKV/yD9OL2rRsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8LydelnBO1B2MGzc19ZW6IfS3lgUjlQQGq79OkgGqU=;
 b=gz4YbhnABt1E8CmvAvzrC7bIRR/IfDd7H0OZbKWxj453ghB2ra6P/klIfG/jr4Hz5KC4+VNeNCArUki9vTrjZLHYyIid0j+Xeky4mZljdaSnBFHSTHKkf3MYBSjjGrAlQ6HhW5KuXkaB38VJFkM7zIUX4jRG2Wy3XC/XOnq6eEdr2GC8OWBdNfN81uVZRfmKLCLlfWukrmLJK0G3cEMmyvhseFJpRSX7Cw4O6FkBV4EiLYaaI5aby5hBIwCoF0w2OO8JbH7p8Ao7n+i6vsXVEqxpC0Yr7/unNJdsYSAQsS01gPFx23RPOpOpp0YqU9djO80ukFI7vlqG4waOd2tS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8LydelnBO1B2MGzc19ZW6IfS3lgUjlQQGq79OkgGqU=;
 b=jTfjR2qyvVcR4j+WbyvGlojJ91RJTFoxjGmdcv9tRzmEab6vbz25fQfVaWhSM9mf584gG14CYsNAnvfvasbT8hO9f1bkJslQDQpn9pC4ArALH3JbIJZgtnpmtlnJBROMzRM6L3yLcno3U8EgOBhJd6KEsqFF0O6YTlooxblgxUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2081.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 08:51:20 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 08:51:19 +0000
Message-ID: <c65fae56-cb75-4039-908d-25c41338b801@kvaser.com>
Date: Mon, 3 Nov 2025 09:51:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: kvaser_usb: leaf: Fix potential infinite loop in
 command parsers
To: Seungjin Bae <eeodqql09@gmail.com>
Cc: Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <CAAsoPpV7Kzap1Sn8QFtBbvwW-DJMTTcU_bBOUDYYC286Uaddtg@mail.gmail.com>
 <20251023162709.348240-1-eeodqql09@gmail.com>
 <1d960d0d-06ab-4f38-817f-b9a5e949d3c7@kvaser.com>
 <5d794063-9f4a-452e-b19a-6442b0ce5fd3@kvaser.com>
 <CAAsoPpWaj4iq7HN7DiGpEGTpCv34jNneC-5oLdtyou9qniU2Yw@mail.gmail.com>
Content-Language: en-US
From: Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <CAAsoPpWaj4iq7HN7DiGpEGTpCv34jNneC-5oLdtyou9qniU2Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CPCP307CA0009.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::16)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2081:EE_
X-MS-Office365-Filtering-Correlation-Id: f1278c7b-c95d-4063-cdea-08de1ab62845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ymxmc0pMRWRuZlV1Q1R5WTE1K291ZE5acWY5OERWU1BDcjJkTVViWmJwK2FM?=
 =?utf-8?B?bGZ2UUtRd2dkSnMwU0xWb3pYN2lMenl0Nm9sNm82MkhjWnAzN2psTk5TMFh4?=
 =?utf-8?B?aXY0MStzOVRXd3QyVFpzSi9BVWRNLzJwUmNaZHNYQUFjZXlFR1hJb0pjMjE5?=
 =?utf-8?B?ZGNHU1dISE5IMHRSTVUzWHFEVnplVmpjRS9jWDVFL0dDcEV1bCtzcnUxL2RY?=
 =?utf-8?B?VklHTWN5SVBGdDhrcEFicmd4TEExVmJ5TXJ4UzYvemRoUTN2b1htcFdDTG4y?=
 =?utf-8?B?Vnl5TmFyTjRqVHJkaUFPNkdPYk9xYVliU1ZraEVQbytKdkNObDlXQ2J5TTEv?=
 =?utf-8?B?eHdaSnA3OUtFR0RTaWxZV05lRXVRZExFazRxd3AvWC94WDNHZTVURUU5dE5o?=
 =?utf-8?B?ZXM1bWlUMGxicjN0VHhjaVZWRnkyU3FSeTUyaDZVWEp4aGw1OHJValNkVDVG?=
 =?utf-8?B?MHZuckN2QWRtVzBTd3JGK0RLOVprMmNMc1hTWmxYYjBVcE9xRGg4TnQrK3Jo?=
 =?utf-8?B?alBzRENtS202Vks1VW4zc0xQTURaUmlhdXNXalZaeFV6cVdsaGZZU2RMMUFU?=
 =?utf-8?B?THNyWUhWbzFiaUNXdEVkL2JwNnpnbjNKVVBMTUo2Y2N4L1JFSXhEUTA5YVFB?=
 =?utf-8?B?SDhGMW0vNlEzNnR2SmVOT2RtcS9yTndhMTVobkJocHJwT3hXSDh1UUQwdE92?=
 =?utf-8?B?bUZSaHV5aUM2cDN2U0Y5M0NTeGc2K0xWSDcwK1oraVpUSWY4TVNrRnduOUR1?=
 =?utf-8?B?aTc3WTBlTTNPb2cwVFJsNHNTNHVpZnVrZittRlZ1bUZWbng2OURBNGlSbzlu?=
 =?utf-8?B?UW91QVFwT0d2VkVBblNKai9uQTRnMThaemFSRENUWVZ2cCtkMk1qUlBYTnVt?=
 =?utf-8?B?eVQydjUrMDlTNkRiR3NBbWFlWGdBQlFhQWVWRkpkVGFPcWlUcVBQbURzZlRL?=
 =?utf-8?B?RDY5OTd4d1ZBQ0N4TUJOOGxJcEFaRUNndkFLVXRhekFGQnBjeklKaHRaNkdu?=
 =?utf-8?B?UklNaTg2YnZQdGpLOGROSk91MTY1K1Q0QmdWV2UvYnpIRTQySUw5ZXk0L0hD?=
 =?utf-8?B?Qy9rZjVZK3lXS0JNa0FGR0lYdTc0Vm16Q0FWc2tYN0ZNcnQxVWR3SVNwUHFZ?=
 =?utf-8?B?SXNMWjJPQy9uRVdwUUlOQ3QxTFpsT3dsR29oNi94MHVzd3EyZ2tkeGlxb2JP?=
 =?utf-8?B?ZFpSWWs2Y1NhQ3NoZEVCaEZ2SmlTR1VPbHpqR3YwOXlQc2I4MVh6b0Rtakw3?=
 =?utf-8?B?NXNTeUk4WThkMVF0OW5UUmZJOExHMTU1UWpRVVRBQ3JUTTY0b25WTnl5azd1?=
 =?utf-8?B?UW1tTi8vVWhiU2lzYnEvOHloMmRrak9ZcnNsY0ZwTXB1bEpUUG91K1JKUVRC?=
 =?utf-8?B?OHBiNFluYVNaOEJsYXRuSmdsWDUzekRJbFEzNzY3M3ZDOS94UEQ0MnBxUjF2?=
 =?utf-8?B?alY3YVlkaTdzcUdOajVPb2laQzBEdEMxOC9CeHdxUHZOYm1mL3RubmQxeU5i?=
 =?utf-8?B?SHNCTG9uWHoxTHZra2xjNzUzb0Q4MUJHNHZ6UFdGc2M4bVkzbHNBWnJrc2hI?=
 =?utf-8?B?NGNBcXN5a2ZWeDhjM0xSTkdQUmZ1N0dsYkNmS2NXUHlUZDNVMkg5Mjg3em1C?=
 =?utf-8?B?c3JmNVBPdUNucENRelh4WnBaMFYwUlcwWFVYQ0xEckJDYUhBT1F6NGZpSjFH?=
 =?utf-8?B?QVJDNGQ1bS8vV0FTbG4xbTlXQlBOclpac0hKc3RXVXNWSHJhUFlWQzJPaFAz?=
 =?utf-8?B?My9nYlBidmo3VE5lMVpHb3NrZlcrRXNpZVVCdmkwSTFqT0pJNTVleDhua3Q3?=
 =?utf-8?B?aVFoY3NQR1A4blVQeEx0Sm9nQ1dWY2VPcXcvWlpjWlR6SU5PbFBaTm1WNGdD?=
 =?utf-8?B?ZzRNdUN2Vkk4WmROT0F6WWpta2FhZlh2WVFNVDdXeGhuU3JDODZlSFNaWmNz?=
 =?utf-8?Q?zVhTqPlfbxP1gTR0Xb/OWiadxye7wQT+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGM3U0YzbjIwQ0svc2xlRlNTZW9WOWRIb01TNE0ydWdLNDNaYmNMY3JWbU9O?=
 =?utf-8?B?ZmZPUGpSV1c5Vi9ZbVVmS2tmYTRTdmZWdlQ1bDVJQTNxV050SEFDUThwZmVC?=
 =?utf-8?B?S1dDa1VTU1pyOVdTMzBwdnNacnQ3Q2lyV29ZQktnUlg5d0pjc3pMNXN6UGRy?=
 =?utf-8?B?ckdQc0xFRjZRWXM3R1JlTjkvY0ZiREM2YkdJYTZsRHNaL3N0K05pTUNkb3hn?=
 =?utf-8?B?WWp6NGM4R252YzF3Vm5mcGwvUThCQjNQa082d2hPaEkyRnZvQ3VWSXhzUFJX?=
 =?utf-8?B?bzAxUDBsOXI2VkxyNW5WcGgyZ3RReUNGM3NJUmRnazNud04wQnlXS3FZRFo0?=
 =?utf-8?B?MkxZaVUxM3FuYnpNNU1ESE1iMU8zcXo3TkZYbXdVelIrRE9NWThZS2dZSjNG?=
 =?utf-8?B?c3pCTjVYTUtxNDlEZy91dlZzMlloRm9HOUhUbzF4WmM2MDZvS2tyMGhJdTBL?=
 =?utf-8?B?RE9DdXNKclM2eHEzU2hnOWZHSXA0a1FwTS9Za0c3aDB2UW12MGJGWlhZTVg5?=
 =?utf-8?B?bmF0NUhwY0gwSWcwM0FEejU3SlZjSzlhaUxzYzliS1MxUDRsMkJkTDYwTjY3?=
 =?utf-8?B?RC9UeUpzL1JBdHdwaWd3REVDZ2dINXRTSkdNN3d3ZHY0aktpK1hrMmkxenQ2?=
 =?utf-8?B?RGxodjVWOUVETHBHdjBGR0RURnVLckdqc3ZhM2RxSFF2RE9jWXk3VVFWelFj?=
 =?utf-8?B?OENISEY5R0VjMDJ2cXVreHpPdzZjb0IrNXllbXdZc25oU3kwNkZBNnRzVW5R?=
 =?utf-8?B?VXc2eHU5Q0dOSUc3V0tXNEsyNGRobmRMeUllTEQ0cytYckRNeVlLay9vak1x?=
 =?utf-8?B?SnBFWlpaRTI1VlBmUW5tN1Z0MU5haXUvckQxSWRScC9zY3dzNk5sZlJBQ1Nx?=
 =?utf-8?B?a0JtUmxXT1FReERZZnM2eHpoNG1pdUhrTHNKeDRiQ3dpVlFsdDdGa25ERmhX?=
 =?utf-8?B?a0lHYzBLdGxVMkpRdkVKdjhWSUxXNmFqK3k5MU1tOFNkcTNqZ0NUaDI0QUcx?=
 =?utf-8?B?TWV1aVNBZEM1V2lXeU5PenFyeVh5L05SUEVjQzJmRlZZdEkvRlNtYXRIb2w1?=
 =?utf-8?B?RDNuTFEzYVVXWXRmMVVCREk3a1lac0xJUDRLbUFaeml2cngwOTBOcTQ1U2Ri?=
 =?utf-8?B?dkJjek5yWEYveE51RDErSVVLa3FSSWd5NmZWVGVmVzNKY2pwQVBYWnFiTVQ0?=
 =?utf-8?B?SFNiWStlSjBHREhIOXA0MlY0amRoQktMV2dXN2tuUjA1Sml4eWh0N3VPWUZB?=
 =?utf-8?B?dzhpWXNDRHRncnp4a1hvTVg1MmMybHlCcHJGTWNTYlRqenZpVktpZk1BOUM0?=
 =?utf-8?B?a29aeHNwN3RrKzZkR0Q0MTQxS2ZLZjZhc3lQdkF4U3FGSXBVRjhzeWk4aENX?=
 =?utf-8?B?dU1FOWFESDEzVHFYbGhxWTM5MWZZS3JBKzlJaU5ISytEdWh6Uk82V2U5VUJx?=
 =?utf-8?B?THdEQjZYM0NKSDJQY1NHVHVCbEM0VHgvMituamwyV0h4d0R2eXNYOFhoVmZG?=
 =?utf-8?B?N1IwVGt4OFNPR3FGNklMUlRWUU9wbE5zaEw1MnR5a3pqSG01dko1UGk1NEww?=
 =?utf-8?B?T0FoTkZMQy82cERKRGRNdUNZREF5NDlNdFB1dXFiU01HWTZZWXJnS2NiQXNw?=
 =?utf-8?B?aG5QUE1icFhycDUvWVc2SUZPWDFIL0NJRXVDYnhjQWdNM0RUZzlUcGQrWlVn?=
 =?utf-8?B?K1pRNkp6NXhNekVVQW9wTmROZVlYTEFMME9nbjVQK2tncFZPSVdZWklEek5H?=
 =?utf-8?B?cUtIc0dJdElFWkt5bmprQlUza0I1SjI3SG5BUU5DUkRhUzltVzl5dEEvR3VG?=
 =?utf-8?B?dmhUQ2hLenVad0FiUm0vL0IwMEFJOG01T0xPQ1dEQzF0QldPd0dnQkFncnJJ?=
 =?utf-8?B?WGVXbkYxaCtzQm1PdUF4Sk1ta3NwQjVjc3ZaVU13MExsTE1JbU5rbXVVbk5H?=
 =?utf-8?B?L09TWXRBVmtwenNKdTVFRmJjYTlKem9xOHdIallVQUhTQjlyZFJidmhBUUVU?=
 =?utf-8?B?U3gwQnBvbjhrQnJtNjl1YXRjRlZKK1lFQkVtVUQvNEtvellxMDgwMlBxazZw?=
 =?utf-8?B?QU9vNXpHWU4zZzFkemRWQjAvc1VET1dBUXBzbVRTVzRrN1JuaWh0OEM2M25N?=
 =?utf-8?B?N0tOUnI2ZHJnNW81L2hvOEh3UERHSk9zT09ZdGlGSkJzZzQ5ZXF2UXpwcVoz?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1278c7b-c95d-4063-cdea-08de1ab62845
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 08:51:19.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvWFUPs1RBEq9seYGi6BpJI7T7l1REbZVbH3WmoAKlJWdLbRsGQ1RiqbWqlOrIcB3ll+mWOEYZlB/mQmcMWm/abfSmDP04nK0p+UydFU7js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2081

On 10/29/25 20:06, Seungjin Bae wrote:
> Hello Jimmy,
> 
> Thank you for trying to reproduce the issue and for the detailed
> explanation of the firmware logic.
> 
> You are correct that this issue would not occur with the standard Kvaser
> firmware. The vulnerability I reported wasn’t found by running code
> on an actual Kvaser device.
> 
> Instead, I discovered this issue by performing analysis on the driver
> code using a symbolic execution tool. This tool demonstrated that
> the driver contains a vulnerable code path.
> 
> My goal was to show that if a malicious device is connected—one that
> sends a specifically crafted packet sequence not normally produced by
> the firmware—the driver code will process it incorrectly and cause
> the kernel panic.
> 
> So regretfully, I don’t have any hardware information yet.

Sorry, I overlooked the title, and assumed this was a problem you had
encountered with a real device.

Patch LGTM and tested OK with actual Kvaser devices:
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>

Thanks!
/jimmy


> Thank you for your precious time.
> 
> Best,
> Seungjin Bae
> 
> 2025년 10월 29일 (수) 오전 6:53, Jimmy Assarsson <extja@kvaser.com 
> <mailto:extja@kvaser.com>>님이 작성:
> 
>     On 10/26/25 14:26, Jimmy Assarsson wrote:
>      > Hi Seungjin,
>      >
>      > Thanks for fixing this!
>      > I'll do some testing in the beginning of next week.
>      > Which Kvaser device did you use when you discovered the problem?
>      >
>      > Best regards,
>      > jimmy
> 
>     Hi Seungjin,
> 
>     I've not been able to reproduce this problem, when testing with the
>     latest firmware on multiple different devices.
> 
>     If the next command in the firmware packet queue, doesn't fit within the
>     current endpoint transaction (wMaxPacketSize), the firmware will
>     terminate the transaction with a zero byte. The driver then interprets
>     this as a zero-length command, and skip to the next transaction.
> 
>     The firmware is responsible to insert a "zero termination byte" only
>     when there is already one or more packets in the current transaction.
>     Since all commands have even lengths (4,8,10,12,16,20,24,30,32 bytes)
>     and the wMaxPacketSize is also even (64 bytes or 512 bytes, depending on
>     the device), I cannot see a situation where the zero termination byte
>     would be inserted exactly at the wMaxPacketSize boundary.
> 
>     Can you please provide which Kvaser device and firmware you use:
>         lsusb -d 0bfd:
>         ethtool -i can0
> 
>     Best regards,
>     jimmy

