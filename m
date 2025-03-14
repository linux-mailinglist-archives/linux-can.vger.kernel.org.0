Return-Path: <linux-can+bounces-3069-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C511A611C6
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1B1B61FF4
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF6E1FF1A4;
	Fri, 14 Mar 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="u+1lgoKq"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010068.outbound.protection.outlook.com [52.101.228.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6401C878E;
	Fri, 14 Mar 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956690; cv=fail; b=UM5yxGpDAClPWSycT96EVmftSMLWq3rTQgW7mscrde+LOUqB8b3lRzcHD/gzEezxXK/yeiiq6/lPc5hpQgyw9O5yPJdxf/baTtoxSOnzV7gphz+Jx9tN+ZPBrYTis/8Lm6lSxzDka0IC9Porz5Yhis/ykWAuaE9lmMw5/l8QAt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956690; c=relaxed/simple;
	bh=NEiXMCQZkL+k79QBexATT8fI7CBebpPTqAHzjTbnpgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O9uFNUDjsz88XjRyvkWVO99yuRt/YRBApY3n8TmrV5bwb2E/a03nawd9Fjk4hTsjKs47N4qx9PQphcEY0t2Bm4htMXlGqNoosPGgYa8opaidSvgmFQUpC7lMon7uz/xSBB4z+6Onh0c5zJn5IH0SYJtFpWI0oce8JYVlJ0FCsYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=u+1lgoKq; arc=fail smtp.client-ip=52.101.228.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFy4DEKJ1saMIlPMlvdu0E1oGA8FzaMFMZUq31dlSToiwIXCZ8ZO7kIjSTus/aK+8Npr58UWnQ+Dn8E2Be+9Kt3KX+pK7hxNBNxCZvIqbE0pyrBS0CYZ1U9AR6adH/DPMhMSJ8pcTN2il3bivqz8jerFhyfesqZBhQLz9KdWfp4VhUXY6A6bp0QKuQ+tMjPEpJj4tiUeE4q9NOs/IKekFRKkPqHRCJHKuSay7kPLvyxMLBMZVUDbBdEBpKd1taI4XQFIMpmBGxVZVDnoGTiRVnjIS7waI6Rr7EkkIGFAUDGP/fPhl+iESHYtbMFDjcU5SnKBXcuHoB3B8TC41G/7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEiXMCQZkL+k79QBexATT8fI7CBebpPTqAHzjTbnpgg=;
 b=Rfq1ZwMtZJXeerh3hcA6JN+o+cvGJg0wU0ws2SNtiTqsnKEA7JC9vIruimJK+HvwOb5DEEjhwHHdWVmfIhgMwgsXR66H67aM1grDNC2/LBW/R+SL68eVz4IZD8uMJOwznMalMaoSlY4hDMp8ppKW0diUMK9+HTB61+o36GEBF0ESRQwomBj2p/l93FQ6o5ZTZLaoRVYx9d5QNujh2+ZyBpb7kN4Su8khkS9lX9B9ITT4EIATFcjAgGBZQ3JthHZW5UZxhUeHza0F/Lgdl1/olmvUb+l3w0RAG/rAtK684adIYrbQnnoFID6TQYBNRpxRH2dL4QxmqyQrkhZlcJf0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEiXMCQZkL+k79QBexATT8fI7CBebpPTqAHzjTbnpgg=;
 b=u+1lgoKqHvRcYF9KQIu0OugCyZF038jn6K7mS9e7OyybBonn/mm6nOCWaAVbn7JaGamJw9ZDr8GuxS5pkkN220dOzVpj9iMDZ3kk+qEVLdw87zX1z7hNFoLvTRgQ/D0S8OqF3XrLL5EBRCv2kyjDAicrJ0wKumL2tHDlrlcUKa8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB8127.jpnprd01.prod.outlook.com (2603:1096:400:101::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 12:51:23 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 12:51:23 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v4 00/11] Add support for RZ/G3E CANFD
Thread-Topic: [PATCH v4 00/11] Add support for RZ/G3E CANFD
Thread-Index: AQHbjpVOeys3OkoT302THn+yrY/iZ7NynrsAgAADdqA=
Date: Fri, 14 Mar 2025 12:51:23 +0000
Message-ID:
 <TY3PR01MB1134621DC7E260EBD452EF0DA86D22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250314-meticulous-daring-loon-bf86f6-mkl@pengutronix.de>
In-Reply-To: <20250314-meticulous-daring-loon-bf86f6-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB8127:EE_
x-ms-office365-filtering-correlation-id: aa980626-9ee2-485d-e606-08dd62f6ecd1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2F3L252SGp1K3FqMWNiK1p0b0lOZkVjUHptOHdScWxEck5Sd1N2SE5tbEZs?=
 =?utf-8?B?SzBkQkQySzI4SlJjNXpJZ1dJcmdwTG1SVmdZRUJsSHFkM2FrZmJETTVZNFFv?=
 =?utf-8?B?RGRjclVlZnNHOUdJdVQ5ZnEyZWlHOG5ZWVhpcmV6RnpzdW8vRSsyMnFGaVF3?=
 =?utf-8?B?N1BGUHE3QnBWWVRQZnZDTTFqMExNcXpLMFI5V3hESDFqNW9PYWZZSUhBNWJt?=
 =?utf-8?B?N3RKMXZaWC9MMFFwWFByL1dBamdCU0R6M0J2V1lkdjRLN0NTT2N4cEszZnAx?=
 =?utf-8?B?NHlKTXd0ZHBFTmY0bHQ3UlhFR3N0VnlTaTIrTWdIY0QvQ1VyZnB4bmdjQWcr?=
 =?utf-8?B?QUE5N3k5b0pmbEtiTnVpckcySC95OUxDS2t4S0dsWTBTMC9UKzdOeUdWd3JH?=
 =?utf-8?B?QXVXV0RSQVdtV0JkTC9IbTk2ZmN0NCtPY2tEYUJoYUZ1N0oxSFlrQ0dGZC9n?=
 =?utf-8?B?QlBpN0hYUDZONGlva3Znai81Y20vRTFQQ1VaTi9Ua013SC9qWnJoaHIwMjE2?=
 =?utf-8?B?Z2hUdWY5bmd3RFpVbWc0UzU5dlROZnhlQ29QWC9lQkVkMk9tS3NqalpVcFdX?=
 =?utf-8?B?dEhHQlJST1EvUFlJSjVXSk55WXJIWFIwQ2xJWFBnK1BTQlg5bXFubCtJVFhW?=
 =?utf-8?B?R0p1VXdoSXFBYml2Y2dvcXVUeklMVUVIZ21CL2pYcWtVOTRJeERTT0JaSWZa?=
 =?utf-8?B?VXhFaWVEMkFzRmRab1I0M2RuMU12L1Y3OXJmbitjMDFFQkp6V1lMdXV2ZzN4?=
 =?utf-8?B?b3RqRFpJU2NxR0kxT3U5a0V3d0lnamp0dUNRQ29Ta2k4bVNWWjFXNTlzQnpv?=
 =?utf-8?B?U2ZCb1dCRlZrNUhMNlhXeENVSXFOVS9PM0hSMElIV1cxeWR2cTVMempZNHJx?=
 =?utf-8?B?RWNLMzlaL3ZPNVJ5S1ozQjZSK1FBclBhSFFPaTJOVmxuelJOSzA0ZUdXSTFj?=
 =?utf-8?B?WTVhYUJxT1ptbDNOV0FJWmJLWlBoYjBqV01MK2hmTmVTdjFhZXVtTWFleHBu?=
 =?utf-8?B?Y1dhWWo0KzRBY0U5QUNXRFRGaWVsYklZNXhMMlRxVmgwOGF5S0dkRHRXV3Bs?=
 =?utf-8?B?RVF4dnJPL1h5L2hPb0cyaXVJVlJnRURlTnVxT3M4RzJNQW5WYTBjMDUzeXQv?=
 =?utf-8?B?enRGaUdiUGM4NXJxMmpVMmNrTW02ZzVCdWM0ZE1MVlVYc0F0cmxOTXJTd0JU?=
 =?utf-8?B?ZUJ6SWZNRUYxeUZLREprQjFJUCtMaWRzUVYwckVxdUFZVW96U3IzWDRzYThh?=
 =?utf-8?B?M0dDVTNuaVpDZ1FaNUFYU3ppQ3dWbXdwNVhidXVRa2dXYy9PNDB3RDROT3JP?=
 =?utf-8?B?KzBydHhBZ0M0cFh2a3VvRnMxVGtFWTFFM1RlZTVPN2RSNDlvc0x6TWh6V21o?=
 =?utf-8?B?WXFYdC9PaWs2QXZwRlh3ZlROWVh5M21sd0U0dzJWdUY3Z1gyOFZsT3lZTitq?=
 =?utf-8?B?ZTZxNTV6MEZJZ1I3M0VqWFZ3V3doanlEd2lLNzFPaVpkdGozK3JGQjhla0RW?=
 =?utf-8?B?RS9iRkRCVFVUbmg0Nm1PKzFHeklFNFNpUVJOZ0FVdzh0Q0hIbVl0ZjRIbkcx?=
 =?utf-8?B?eUpLZW0vcnZLOFBHRVpwQlc5RjFwV0Nrd3JsNjNUZHZzNTBSbU9zazZtcVB3?=
 =?utf-8?B?V2NidzAyei9BMDJubTYzbForRU9CcjRYYjBacjUwdTNNd240TFpmZnhoMDJw?=
 =?utf-8?B?WlliS1hheDRJa2NENXpiSnBzWmtIT1VRemlOWnlPYkl5elRNekdVbU9hZmpB?=
 =?utf-8?B?ajA2Q29zdm5Uc0Z5MmxYKzJ1LzZmWld2cS9HN292blk3WmVuYU9oS3FvSDdE?=
 =?utf-8?B?WVJuY2k4bldaRCs2UFFRamxza21jVWhiNEJEMXBBMTVTRGptTzdXYzZydFFz?=
 =?utf-8?B?SldqVjdJeUViQ0tOalBoYjg4b3pvSTlBSzFaNFhMaVh2WnhUTmlvVFd3T0g2?=
 =?utf-8?Q?5qPsXedEm2mtViCrEuLen4dMXla9NyHr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFNqVndobjVJeHpOT1BnS3VWYU1JdXlNUmFkVjIxMG5ybHJjWEsrcGU0ZzhT?=
 =?utf-8?B?S3BzVjFQN2VMNlZTSy9mYzNvbnR4VldPTXVTbUE4cENNcGF3eDg3ek9pT29W?=
 =?utf-8?B?R25ZZHQ3MHNzeGsxQ3hVL2JLT2Qva2FBK0tiV25oZzNpRGJteWU4NThoaDUx?=
 =?utf-8?B?emJ2YjVOQjY3TFJaUS9ocUJDRzdSWlN6a2ppS0lXWkQ3SW4zZkE1UGpmc293?=
 =?utf-8?B?WWNOWXg0Qks2OUtsd0FIMHJrT2QySklET29lSldOLyswVVh1NEx2NEU1aGRp?=
 =?utf-8?B?MWNsNWN2Um45Z3lCOVhML0pWOGQ5eVZNamV4dnNWZmpiQ0drZHRRNFZsT3lZ?=
 =?utf-8?B?a1NpN3U0aEdnY0pGR3RSRUo1WGcvdThjUzlZY201Qng1YytrWml1cThMMDZy?=
 =?utf-8?B?a1paL01rTjY1QkJaL1RmUzNONzR3dXNOOGxVdUpSRVVCZktvMmlWK05yWk5E?=
 =?utf-8?B?b3VHQ3EyNFoxZEx4ejBDQTFmVW1UY1lWQ3dlck13ZkZsaXAzUVFHWjJBdWJk?=
 =?utf-8?B?NlZNUXpwUUdObVA3K2N4ekhGYjFaSjM4d01uU1E2NDgvWTRSakR2dDZBM2tV?=
 =?utf-8?B?bHhuWVlCYWdlbVdBdUlVMElDeW5PdkJ5M0ZaOWljMnZXeHlBaW1Db0NlU2pG?=
 =?utf-8?B?RzhwUWR1bE9jRGNKN2x2TFFoMEt2ZWx3OEVoWEMwYlQ3Z2pLcWlJSWFLUGxj?=
 =?utf-8?B?bmhLa0NzQTQ1djFoejhoUWpyajJnT3REKzVrcGJ0cjVwa2ZYa2x0RDk5NGwz?=
 =?utf-8?B?a1pvbVFTY25ZbzI0Kzg3dE9TQ1JmSFJWYlJKc0lEdmJOVzNGazRjQ2VVQ0Q3?=
 =?utf-8?B?ZlhPNWI2M2FsNzlwbnVRdFVxV2poSVF3cFN0R2RGL2NuekZLVVJmeGRkUG4y?=
 =?utf-8?B?OEswYUdsanhYMmpwT3NxRUc0M0M3VTJ0T2E0OEg2OGlJUUd3OXV5b05oWUJ1?=
 =?utf-8?B?U2Q3VVp1VWZWWjZwZXdjK0x2OFp3VGtLdkFMV0ZCOGVJQXpIa0F4cERYMVg1?=
 =?utf-8?B?Slg2MFRoNGZQVG5VTUFua3ZkMXpQUGF3QmY0OVlOYkR1Tk9RZGx6RG52UlI5?=
 =?utf-8?B?QjlYTldzS2ZJV3FMcnZHZmtSYW9hdnVuV0NsRkFoeFI3V0dvbEQ5cFdNcmFk?=
 =?utf-8?B?dUxlNkFoSW5qVDVYMXlJL3hBenJpNTkybUlRekJTOGJEY0M1RDRRUE5aR1o3?=
 =?utf-8?B?K3NwKzhZTjVIV1lLOWM3a2tsdit6bW1jYXhLVmp4dXJVZ21qTlJyM3lDQkQ2?=
 =?utf-8?B?VUQvY3RxNElQSjYzdWpHVlhZeTZSbGc4US9ZbnBWaDRIaXhCNjJVNkg5SFZ3?=
 =?utf-8?B?WTJXbnpTSWd2dEQvaEEzdVBUTWtkVmJ3L2I0NEVENndVRWMyUHZlUnZKc0dH?=
 =?utf-8?B?dUhBVmdZMHhsRzQ4NzhVelpWSUY2b2l2R0ZrZXRONTdXR0toZ2hkdzRwa05M?=
 =?utf-8?B?V0NtSXpLSWhUcTVLSit2SFNSUUYwM3Fod2ozTDF3ZjcvRHlacGc0RktJUHJh?=
 =?utf-8?B?dEV1aUJSY2h3R3BpK3p3K3pYdVA0ZHpycElJTUpib1ZFeWZabnI1Tjg0dldL?=
 =?utf-8?B?Y1lmT1BXdllmbHFCRmRhQjJoTThBM2x1VnJwQ3JLZHJBQzAzckhhV3k2aUgy?=
 =?utf-8?B?c0tXSFhQQlJ2Wk5VTGprbUFuZDA1bmM1L0s0NmxPVmV1ekZPU1g4QXc3NzRL?=
 =?utf-8?B?KzB6aFl6cmRXLzJMWjBaUXpiUkltckpZNnorTlhvYy8wYTdxeTFtd1VyMjBQ?=
 =?utf-8?B?RHJEZUo3ekdrcXB5anFqN1FYcWZ6RkRGK0gzblh3NEs2UVBFa3lvWFRZTGt6?=
 =?utf-8?B?YTZwcHhld2RlZ0lXZHoyNUNvRDM0N1lJWXlxZ01JQkllMFV2eVptOUkraWlX?=
 =?utf-8?B?bGxCR0dLUVF4MTRqRlJ1ZmVIalltUXpYd0o5ZXJJR2lvR1p3ZFA2b1NVdUtu?=
 =?utf-8?B?Sk5FcXR6c3hDbG41S0VXdlhyaTVFd0ZUbmlvWk1MK3VoYVp1cG5JSzdjaUVx?=
 =?utf-8?B?K1JzNi9YdWhWMExZNVoyNnNYY1NWVzNxdmlHbVZxdTIwdHdBK2s4bFBNMGk2?=
 =?utf-8?B?M0pJOGZEVmpaQmpLenVXZDE5YjNoWjhmRGt6YmpleDc5aERSUDFtb3piWGNI?=
 =?utf-8?B?dVQrbjNNbW5vMmdNclE5UnZDSTBFV2k1aGx6dUlHSDNnN2xvVnlhZVRmdkFU?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa980626-9ee2-485d-e606-08dd62f6ecd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 12:51:23.1113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUGIX2PPPPOihvxRMKt0IRaHIpD02SScaxEmugag0kpaqplB0InoFbYTTFzyXdN15WB9RUfx5rxrGU+Ej/Ps0Y+0LJH7vq10cPH8RcVpvpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8127

SGkgTWFyYywNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMg
S2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUg
MTI6MzgNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMC8xMV0gQWRkIHN1cHBvcnQgZm9yIFJa
L0czRSBDQU5GRA0KPiANCj4gT24gMDYuMDMuMjAyNSAxMjo0MjozOSwgQmlqdSBEYXMgd3JvdGU6
DQo+ID4gVGhlIENBTi1GRCBtb2R1bGUgb24gUlovRzNFIGlzIHZlcnkgc2ltaWxhciB0byB0aGUg
b25lIG9uIGJvdGggUi1DYXINCj4gPiBWNEggYW5kIFJaL0cyTCwgYnV0IGRpZmZlcnMgaW4gc29t
ZSBoYXJkd2FyZSBwYXJhbWV0ZXJzOg0KPiA+ICAqIE5vIGV4dGVybmFsIGNsb2NrLCBidXQgaW5z
dGVhZCBoYXMgcmFtIGNsb2NrLg0KPiA+ICAqIFN1cHBvcnQgdXAgdG8gNiBjaGFubmVscy4NCj4g
PiAgKiAyMCBpbnRlcnJ1cHRzLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgZGVwZW5kIHVw
b24gWzFdDQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMjIw
MDk0NTE2LjEyNjU5OC0xLWJpanUuZGFzLmp6QGJwLnJlbg0KPiA+IGVzYXMuY29tLw0KPiANCj4g
SSdsbCBzZW5kIGEgUFIgZm9yIGxpbnV4LWNhbiB0b2RheS4gUGluZyBtZSBhZnRlciBuZXQgaXMg
bWVyZ2VkIHRvIG5ldC1uZXh0LCBzbyBJIGNhbiB0YWtlIHRoaXMNCj4gc2VyaWVzLg0KDQpTdXJl
LiBXaWxsIGRvLg0KDQpDaGVlcnMsDQpCaWp1DQo=

