Return-Path: <linux-can+bounces-2673-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E10A17FD9
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 15:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D951C169598
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E4F1F2C2D;
	Tue, 21 Jan 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="N51xA2Yg"
X-Original-To: linux-can@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020091.outbound.protection.outlook.com [52.101.171.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D331F1508
	for <linux-can@vger.kernel.org>; Tue, 21 Jan 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469897; cv=fail; b=cT8PEnQMf1e8l5e2H1YCXI7cD63gnWm4V9Q5QbHGN/KUJZQzFjHxPcLoUlJSwPTUHDrDFerOndOvPu//04JXbFYG2grClmVEbRInjDDJOQxPcKjZ6tnjrpBOuCuk5oXOxaVaMUZRrW611Avmg2MkxccY7zc9XPnCVoDtyim39Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469897; c=relaxed/simple;
	bh=57XdLBwbGUD/l7J3TdGeb2vhjrwSY9OeE0CLOGxN/8k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRxya/aKD9UhYPy7MNVCzmQnhccAQBG1Kn3/LXxqc8uL6TjsXgBvrVqu+U0t/v5be6rcPVLnE0c7hd5PhxRkBDLeLASQFqm44KC+6RHS57XcmY2nCnICQTLp2TyhuuJ4VCes1Qcj1ZGbliHkLLKsiTmVu+J8PgqGzp2yKZF7PyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=N51xA2Yg; arc=fail smtp.client-ip=52.101.171.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk8xEDe8M/tu/iw6RPTbXjzxwECXmwMb+FNgbX7nvYKWzwRF9MI2Iu7ECKajQG4HB89Mo001YCGEjjT3Pq14XI5uSSVYG9HXN7wCnmYAxHva5C7GjQge2LsjSnO+GfZ1qVdalU7FgTJzctAjre5h+kd1IRre6yoTowMNpM2vgsXvEimFLEiawcbCdoshTOE4Lvul4+hizN07V3Ax1kGM3uKMvT5pshs3jq5L4a2WOk89cZ1aTtFBajdKbu0sionAHiGyTQNyYbSCCpmVOCCBP0KeGe/OqLPIGeooMhEEpeNpa7G3Bs8oTeSwNXsqd9osJnXqlojjxxvHRATo9g/Rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MYolH9lN6vtlWlS19uPRcFE9B9aP68x5Dwc50yCzig=;
 b=nas+xvFfLBQUvxEMIC4JgEDEMOip+Wp9JTVJwO/F+GXnZ/6oPGEsiBZS/oK5S+rUql2r24H+VrxISyXKDk9mu1mPgVk3d+yO9+6IO8yxGknTS3sxOyV8E8pMsya//WBbBzYzojJnoTAL10sxGtNw38pE3LigeLHjZcZ1Y9r1GYbzPOl45u0xks04n0rCdKc65EZsmnTp7j8otaa40O+qWwQc7k4yJ6YVp0oaHA5XgOx8XyhepKwvZkO13LknJX10PehCC3lLT88lP6/Se2khAZKfwBODhFphbxLeQ4ClSl+cY4Wt55wesCTr1DQ8n1Q1bkspx2pYVrHPovcIlW+hKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MYolH9lN6vtlWlS19uPRcFE9B9aP68x5Dwc50yCzig=;
 b=N51xA2YgI352HFuIg9mClXHs3lKjobTVNNb6Fd9M7vmhiZJpn+xRqftU9JOxvNHgyQpUTuQLtY05DcNv7MUEMsF/FGvLvBrtwCIEzSlJmyvgzi1kB1xWXgt5lopKHaUa/9CfXAXu1dHHqeps+8L2gdN3BkAqbzJuY8gDSADbEtM=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR2PPFBABFBDFE4.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::83) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 14:31:30 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 14:31:30 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List
	<linux-can@vger.kernel.org>
Subject: AW: canbusload and canfd
Thread-Topic: canbusload and canfd
Thread-Index: AQHba/0/6F/6NZUR4Ea9t80HFvTRPLMhMLsAgAAYqC4=
Date: Tue, 21 Jan 2025 14:31:30 +0000
Message-ID:
 <BEZP281MB2245AFDD4037A89E61194544D9E62@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB2245032053822A5B4303317AD9E62@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <73bd2d13-6f30-4fbb-8842-77dea6231a33@hartkopp.net>
In-Reply-To: <73bd2d13-6f30-4fbb-8842-77dea6231a33@hartkopp.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR2PPFBABFBDFE4:EE_
x-ms-office365-filtering-correlation-id: e890e13b-c2f2-4fb0-b4f2-08dd3a284bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fb6d5DThp2xlMYea8IQ7vdYLVn4dbmQUUgO2gyicQvkbmZRPABKz98Z9ri?=
 =?iso-8859-1?Q?x5SK4PX6yZnhT43Oil0cOBaocBwJju/zw1g1YKL63tooau8YyUCc+Pjc2N?=
 =?iso-8859-1?Q?CYx2upHS9m16YzL61oQ8I6mTdRLL00x904l7iq2azLRngTlOG1CqPEs1XJ?=
 =?iso-8859-1?Q?Ljaye1WPZe0SMrMDlRrNf7+AJ7DYOJlJ3Uy+4dwnQf4Fyc4RHCvHWs0a7D?=
 =?iso-8859-1?Q?cFcNLHzw9ryda8lv2CmoTT3t07Y3PdBJkY/OYvqN+sZ/LpNyNJzQr0f5fA?=
 =?iso-8859-1?Q?MW9dJQ4kE29fYDASow5SOK8trPq//uXmxva6zSft+mxPNDKYj0REe84nbT?=
 =?iso-8859-1?Q?nXC6P0WNP8UujVM6zhuIsrEZwBl5IZ5wervCusn9xO03VplIjzD4ElP/ic?=
 =?iso-8859-1?Q?zNpKFF4IOoFBwY8AoVj+KZzaS8pGFrkJFrE9unXSBMJg4X/aqg1K8nAJJY?=
 =?iso-8859-1?Q?ylLzXtZS6QTBRI6P7j3Tx98Vfk/B6RgQI1R1foz9bEUzUO640ME6N/G5G6?=
 =?iso-8859-1?Q?K1ea/KJswq/3IjtPfmSE4iB/ioAsLW3GTaHPjYSLZYxVodwtNGgbTozvBu?=
 =?iso-8859-1?Q?V4/87DNeZQ8Ez9sMUgb6/oOCc40fynpotZq1TIW0ChIfDXB4W41saskGss?=
 =?iso-8859-1?Q?zR+IVkKCHrXjuCZr2ZAs+cPn/pqKgc+mveVwCP50PmWGaBHibYU/PxZBJP?=
 =?iso-8859-1?Q?55FzzOPOs+vh1ez1wrXrsqCjr/cG7pYsnT67FVXZYncudbrgwVSzLENCXe?=
 =?iso-8859-1?Q?ZgxVBpSli5FK1Qo8F9BDlnldv0pq4gMUguwibqbTb334CHeYGU5mYxziFn?=
 =?iso-8859-1?Q?+LrMDeVVcVgs9bYzB97yGi1f5UaUVkRt0XzSkXfcIw9GaLfNZFPVFWRdVr?=
 =?iso-8859-1?Q?jqJl97zhJ+xvsLwCkAr66uQlWe3wzdveNb78BhF8QljkvOcxjdfIdMgRB6?=
 =?iso-8859-1?Q?ukG6g75kpbxc+AvojRcm6PAQUKeUhrcBsCDj5FFnu8qakcUrBgC4/w4kdy?=
 =?iso-8859-1?Q?wRhrwwivQ3rfYr4AnUcgp0tC7fHT/CwkwmYTwRRAOB37f7SQYqAM8iZ3dR?=
 =?iso-8859-1?Q?zYqpVRVfIRsB062cCEWoumQW3KGODq5nlXxvQxez2V2ixASOTvNNOzTSaI?=
 =?iso-8859-1?Q?M14eDt3MHPlWYdUU3cceLG6ZatgHmQV1DmMs6qGHaXpsSnRXmQ0nb62Jkh?=
 =?iso-8859-1?Q?5uLplQzrDum9cNuoL0ft9gju9IjsZaS8ik75sedwPVwi7NKqHNHgT/C17u?=
 =?iso-8859-1?Q?OnKuTQcGruijwVtu7xgaIWaNVqDXbvM0ag/DU9pqMt3ww/bKsmNUe/TAjG?=
 =?iso-8859-1?Q?cUKmfX2FNsTldDm8UhwkdFWDxQUyQacehr3NB1r02as5LmiITL6tSe6W77?=
 =?iso-8859-1?Q?UG4Ss/GO6cA/lpCsFNMPGu2ermksqxKoqHZsxpOcbQfJsT4PMcPyJp29xx?=
 =?iso-8859-1?Q?hhOYhywODZarahKMCpRMUDRlaq2fJvfs9mHKFFbSVW5uo5DZ2iqVOhdMFr?=
 =?iso-8859-1?Q?mrkW6aVkHtIpeg2cM5tewa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q2PhVpBhrDtqvyrbkqKW2+19XCYC/sVE0LHoLFQ7jc5TDvkjghPeJrGtlD?=
 =?iso-8859-1?Q?Z1kmY8naCC2SXMniwM+EeEMMkhFp8EJ5xRX73cK+z0Oxn1GhQXsSKz7/fk?=
 =?iso-8859-1?Q?gIG6LHVBO88gaxYD/GDNTra/hd1qMbV8yGmdaXubA1josN4Q3w64bI1F7x?=
 =?iso-8859-1?Q?usqdbnC7RYqTXyBrJGt2t7Z95ES2eTrq9qSTh9PFyBFeSVUclABOMxshkE?=
 =?iso-8859-1?Q?uOyaF2taOGMmaKN0xuQ3Iesi1EyVOHvMLYBRsIuael5k1OC5jETKf0fEhf?=
 =?iso-8859-1?Q?m2Dg4+piHqTVzAbVGjyloapcZv+O2dwRUIuYLLN6I40MAWI1s6+wwjeCde?=
 =?iso-8859-1?Q?iZgGruwpHd9L3r555Uwe90o6rWPe0HJCqNLJlaxcLvytovKo63zZkuAygZ?=
 =?iso-8859-1?Q?DEL2+UfLocAh1trHAJYQq4IuDVe3pzH4126KNiPhKCap8W8C1LuwIP0YIX?=
 =?iso-8859-1?Q?yAhyj9qcMCOoXOhNO/5qVVRjpdkvantbtD1CSkLf6GFXKKve4QJgAfmHfV?=
 =?iso-8859-1?Q?iO3Btxb0q5iKJlTNcidz+TQWZkg2Ned+CqUKmy2HokJRA1sNHtDY6kQgI5?=
 =?iso-8859-1?Q?wAK2YHG1r+DfQJncvqsKYZ7rDRKwaFr+gX90bFKFdF+WyGjeBl9eMevWyc?=
 =?iso-8859-1?Q?hZ8yR6ohlGhGjmDz5Q/fFf1ErjC8NHWhlBJbQAAH5eVxfRkWENlCg+OtgA?=
 =?iso-8859-1?Q?2S2JnrnjVpHlw+BKIS4p4RoMp7Hprisuib0MfhUpaikC5F5nEzasOzMRGj?=
 =?iso-8859-1?Q?iIWrWG0ULO7+cCTdrziSqqNqDSpcAiCsr2pCqKgvjoIj/EJA8uxpP0tpMN?=
 =?iso-8859-1?Q?+MoBClYFNQ/oleoQjbIfPROz4pP5nwHkLGDhidNzjPlUtOosKIV8EJqAcs?=
 =?iso-8859-1?Q?X4r3dVrH8joHO3mSWWTqyPUmpzmZnaCQ8jD39J2q09gl6lgpR4UjkUChyx?=
 =?iso-8859-1?Q?EANXLAR8dpIrhg+QBP3C6F/A54GLglvZWG7SuCqBI4Yxlzi4emPjC2tQoC?=
 =?iso-8859-1?Q?4zqZJ6Kq0jE+MDDrzERMeUP77PN367jEyhkFW727q9O4VohNTIx/K/A5mN?=
 =?iso-8859-1?Q?QXtCQpKwGORhb589atmU2mIIq1KZ6dUN+P62DPcUEUBUYsAkZVA1MWCrIV?=
 =?iso-8859-1?Q?U0vZuoF6oyd59ZvtwINBweQ0M30OecMfOU+n3SHJZWm6bO0Z30sw93G4tx?=
 =?iso-8859-1?Q?KtuXAxaurn53tTuGAL2pxf5qIVB/lq2KgqUyxXa/0joaVe9cpw+W2xc9Gd?=
 =?iso-8859-1?Q?5Yw48O+LXmm0NAJXFwrItw3Mo7harczznKu1GjRAHXb8uPsR2xls046T5o?=
 =?iso-8859-1?Q?Mnbv9oKfacljXd0ZawnYygWBioEf+9lDbCo1SvE51nenxv7K8YVR6+m68Q?=
 =?iso-8859-1?Q?SsOQ6HqGJg0SXzF4GpCz0IO3ry0Qy5K5DQWSH8kbTexbrLmiJHQnSCXfVz?=
 =?iso-8859-1?Q?UOroHbYRNqtYuzXXDhLaN9BueWI1cxLPpp2PSTDT17RXH3VukgMHUFGQbo?=
 =?iso-8859-1?Q?dbeLP6VJA0K3sijwZQ4VaskZ11IwnQEoNfzW00NEktt1d2fRDk737Qs27s?=
 =?iso-8859-1?Q?oWc7tNiAB8t4PuK4T0HOD/rpNB1dIu5TIhjNQGD9fFl+kSKfH8aOUVBpjl?=
 =?iso-8859-1?Q?Mm/PTSqtcpyXx7eodZSv22UrJIbDXCDRd6tEuW1YH4vL6Iu88WE710jQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e890e13b-c2f2-4fb0-b4f2-08dd3a284bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 14:31:30.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kxc95Lc0sVkZWo2tH1gwdF1wJW9O57omLTHNDaClicpqZtc60smbiYKvBoE1bFOGpyfqc70k51q11KkrDl9oOhQxCNyMndY2ZrfJP4E1+xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2PPFBABFBDFE4

Von:=A0Oliver Hartkopp <socketcan@hartkopp.net>=0A=
Gesendet:=A0Dienstag, 21. Januar 2025 13:59=0A=
An:=A0Sven Schuchmann <schuchmann@schleissheimer.de>; linux-can Mailing Lis=
t <linux-can@vger.kernel.org>=0A=
Betreff:=A0Re: canbusload and canfd=0A=
=A0=0A=
Hello Oliver, thanks for fast reponse.=0A=
=0A=
> or just without any options to get the help text:=0A=
> $ canbusload -?=0A=
> commandline in the form: <ifname>@<bitrate>[,<dbitrate>]=0A=
=0A=
my version of canbusload shows:=0A=
commandline in the form: <ifname>@<bitrate>=0A=
=0A=
So I think I am little too old... will try again, sorry.=0A=
=0A=
Regards,=0A=
=0A=
   Sven=0A=

