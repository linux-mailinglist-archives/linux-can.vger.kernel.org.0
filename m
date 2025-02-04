Return-Path: <linux-can+bounces-2724-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58ACA26CC4
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 08:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A593A8164
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450912063D4;
	Tue,  4 Feb 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="arnKeKDS"
X-Original-To: linux-can@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2010.outbound.protection.outlook.com [40.92.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FC204C3C;
	Tue,  4 Feb 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738655065; cv=fail; b=h3uXnLJiGwzj934FweGq21VhQnvBT9XqWjLMTQ1BtQBB7fFpFSkyqYypKLjSXJYf5dbJ3luEvsT6dRw7rdswXO/gJr2ndRj+Hsme9Nz5pEpSUHn6Tdvs8KmEZ7wGMB3jA6b9BkWUMqDxET8mxyiQoU9GONumRfcW7SFo5f99TUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738655065; c=relaxed/simple;
	bh=/Eh6C77mQn+e1pX5M3KB+fJL2btNGTtEbYOYaJ8z4i4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oKZz44KdgCJw8vUF7WOONhuczcGGRYR7j1+iG5HLB1eSoJvf0akCPjBXeOMvpsATbCamE2mssjRHz1jYu//kFTu6Z9zP08QUVOoBSTrIDlJYeSYCD/rD9r8CPM5JqW0ovP5OHTeUA4qzItZjDsX9TLFVTK+e4rxm4d+gqnca1YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=arnKeKDS; arc=fail smtp.client-ip=40.92.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFiMc86dHdNqUsNet1i6AdOMOPgmu4//ugx17qyE2tqkahjxua/xR/NpSA+7GsY7I+V1+u8duY0UYH3R+ft7UkQmo+FFbghGVZEbuhBTobxvbNPVeO6vE6rSKN7n0h+RTQJaTTLLh6sGVjLikpPB9aTwyBDoifKRdieor3+5rs4ang3WFGpB8AYoV586Bf+CLGfnVkYK622GfoxfuUPE0HkuIqivN69oSnvxo5TPSKr6rKhdhvSp2iUkV9dbLcaZp61XgzVYEesWwq66bliPz64+o3Tu78CxBzANR7v+IHOj07IVfJjijGtXWPkCfMHmuoDuqp/41WZNXOSHlVh3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlhpsJ+lr9VF4c5mzb2WuHxHVLo/7lnKVA0yxDmMP34=;
 b=OQooayjyfU8J42hJ+MXKK9pqj9a5KsHQSC12r3edNR2VcHtYBswz2mUdWs1Dd7dmcfvzVACYUUJHKbD7fMRNFYL53otpL8aBFe+wE5ztufapa9E0rgdyCYmsgDJuq+Fqk3rc1sJIichb3cSRUVXXfhLoI0JfcNckykoyF+BsL9h6vlfHhx0UQZACgV+o6bC2Qqa0CFSr+Vv73PhowLA1aVK26rOtwyFH0dyTo3kfLieqvBBj3hijamGQ3glsKBkBx125vkKXRAGHclOzoXFU5oKuVgPpR470XbXw+2P3ZXrgmGX612k6mHQ5GnvWHTQwJbGYGZSurG2+cUP1IH/5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlhpsJ+lr9VF4c5mzb2WuHxHVLo/7lnKVA0yxDmMP34=;
 b=arnKeKDSs9zRIdoYyKKH0UQ2oJhpBGLNMblIwsNVwZLqn/0M9hrJg5AXQq0166bUvjSDqpliBBV8MU30Gsnhcf293JobyaZi1LrlzYw75Wg+G61DFxhaGEm5M9F1HeuUJgT2zQh+WLSbasmpCUA0h8USaM7WXPP+touAmxS9g0Ly/0M1dyjhHIFCvuX5uFPp7E3Q4Vua3A/rU1gBWyc4idwY7PjEzbreKom02EQybYnoQDpTzMwU18EgGXwHExTNQN9/ifs9d0tL8yYE+HOViIZWO4MDMpPLoGtkJpfYQb5is9ouCgqM/654Mtv9lQcF+fsc2BYNP6N1+8zy8yUREw==
Received: from SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:293::17)
 by SY7P300MB1404.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 07:44:08 +0000
Received: from SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM
 ([fe80::c7a9:a687:779f:a9cc]) by SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM
 ([fe80::c7a9:a687:779f:a9cc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 07:44:08 +0000
From: YAN KANG <kangyan91@outlook.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde
	<mkl@pengutronix.de>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: general protection fault in devlink_info_serial_number_put
Thread-Topic: general protection fault in devlink_info_serial_number_put
Thread-Index: AQHbdsEkDWnKNQ4k/EyTWn4LmV2gjw==
Date: Tue, 4 Feb 2025 07:44:08 +0000
Message-ID:
 <SY8P300MB0421E0013C0EBD2AA46BA709A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY8P300MB0421:EE_|SY7P300MB1404:EE_
x-ms-office365-filtering-correlation-id: e4efadab-1f7c-4976-6634-08dd44efb50f
x-microsoft-antispam:
 BCL:0;ARA:14566002|13031999003|7072599006|461199028|7092599003|15080799006|8062599003|12121999004|15030799003|8060799006|19110799003|56899033|102099032|1602099012|3412199025|4302099013|440099028|10035399004|12091999003|19111999003|41001999003|30101999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3DBR1PG+ZOtVfPQU9Q5V5PpszUqXrMXoGIr0wRcrBZTdw8F1m8zFu4Kdal?=
 =?iso-8859-1?Q?M2ar6fjHUSyp20ByyvvFo6QdfdQ9KF6wBjfe2I8IlyE9QCV6YUVntDu4EC?=
 =?iso-8859-1?Q?z3aaqpgP3hrRZFpCaYkuLCglIqLWXe9iatshJB02DkbPEKIH6yaWT2RFxJ?=
 =?iso-8859-1?Q?w3FfbdRsOd4Ds3E1PIelNTAk0PtCJIPIBO3jOjNcTC7H5ht8xSxUGzuC1T?=
 =?iso-8859-1?Q?TqHbFLjvAAr9VBXyqHOUSu5jnFqdC1ARGtUetLIHUsvHzSaGAOMYwdrz4h?=
 =?iso-8859-1?Q?fsQJHhbKp/6Sz+5m5E+e9SdIdUoPLLUfwERrryMBKhiiWLPAFDZI1Dig4q?=
 =?iso-8859-1?Q?R9Sq3UBA4ALp/bzC2D5oIU09NxCZM1g3HVmhGmR45UUuK7tQ7ZL2ftaxfA?=
 =?iso-8859-1?Q?05rjVK8TQBXZ3nF8Qx+8kRd/Hl7OlyXMuvmd5jASwWATecCZmrcdPrxXal?=
 =?iso-8859-1?Q?c02ZqagO/KB7aBLE+yI19+NeuY30ROeZLiKScD/ZzZl6bSHXWNe/uLqmYp?=
 =?iso-8859-1?Q?+Ud3ljktQTIme18AEpxl4eRs0bYo8cJ6jQ3JE8keUGo8g65Hbfy6jHhA2W?=
 =?iso-8859-1?Q?5ZKtj1pDuKHRiKosnSnjPjVaocKck4O0ddzJK94ek47apSzX1o/dyfUyAu?=
 =?iso-8859-1?Q?bKrm4xxubLiXNrubnjodannNifP1J2El5zvLpzNIo/jvIVZXoKYJzQ175d?=
 =?iso-8859-1?Q?0Wh1dP6o7bR4iIKQuR6mQCm4snZLXEW3uUT4neZVPb0EtaT2GiBv6oKuqN?=
 =?iso-8859-1?Q?tEH8dgENy6BGvsQgRT32Cl79L1oMN87ZFCODc6tvjuBWoottE/du14VKAZ?=
 =?iso-8859-1?Q?6M7OvV+Gyyx3c6lW7c0p2rRxFMS5OGNzW+TyKDzMvFl/qEFROXkgaRUsLT?=
 =?iso-8859-1?Q?W+SS21PHgVrnB3tjObqDkmaxOLkTGwcg/IOuLjCPV7PfwsYUt0Fl7CBwQ7?=
 =?iso-8859-1?Q?7nEzGxNGBTQSo9vl1uiv8XAlejt9y8czsFQBp6HbTS+zJIq3O27VYqSoK6?=
 =?iso-8859-1?Q?6iewLYFsKtzlqkDJX65g4ehwksSnZr5EvlvhZpCWNfBE5yG9bOskxbF0Br?=
 =?iso-8859-1?Q?aPO/iyqIAMg2KvqKcegqiHjdsO0nG9TaiSC79eahZYUN1Vb8wvRwVEL67N?=
 =?iso-8859-1?Q?s0tYt96Xtri70SEnSWqasgniqS1kkCladv15E0VKWyYJAU2RQYAkJUzZW7?=
 =?iso-8859-1?Q?XJPqX6hEZrMBkDCGlikXdoWgXotwMPWkp9uX1PrMH2UronsFGyWEl1n2en?=
 =?iso-8859-1?Q?VzTOVKtoeVYlVdycnSwlWeBzabF3u1y/mhYBKK99wwXBySR4iVlm7f5YlL?=
 =?iso-8859-1?Q?r0MX9QVERK+RWVhdEdZ0wglDkKWKmO3/IB5sLJn9zUOuF3ZrjlqhHb0/tP?=
 =?iso-8859-1?Q?5FFsGMsDLpc/aj3cWM4pTjZunolk/MySPz42Jej6fPoKbYLhKdYdU1Haqg?=
 =?iso-8859-1?Q?XrufdIwSProETTJKV4/Jdl93/Dz2BHm7d1hg7A4CPTY1SgJkHUcMQTQc5Y?=
 =?iso-8859-1?Q?XfCZ8IvkC1ORsr82JIgmjxNJMt6SLkr1x0RxDBe7uG5+Hod1+iqYm2/Mg3?=
 =?iso-8859-1?Q?NRIijVI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Z9f+sYKmFkJ5LV4E3piZRfT2c3zXKqqziqyHCBFVmWMh5dOFhSPtwVfwX4?=
 =?iso-8859-1?Q?2gQL3hPXIO2qVMg0l/fEqBs01uN17A+QkBWke6Rtno9pD2pQ4pyxVZImFX?=
 =?iso-8859-1?Q?KG5MMzOkr0iSbwk4xOHzRO66H81LzGjC4ZrX6g1kaTdDZmHRRTjAqH4QSR?=
 =?iso-8859-1?Q?8CDE4DDpQTfqa+qeUg4PoDVHr/jtAjLD+gqLX/NpS2Rt79U1DrEkyoilVU?=
 =?iso-8859-1?Q?ojjn4tbML4+hxQmlTCgr8XHE3qr4H+IVFY122jryT3rGzqdZHhUD1WW4Fy?=
 =?iso-8859-1?Q?NcWx1DF8ob4LJwf+cFQATWUytBqFdgQh8IfhyTvLMY8RRIqp4SCfFMNX08?=
 =?iso-8859-1?Q?XOKUwl28c903uAzKGnSiMAihApb8ccjlEVVZgXLQ7wDeEL42bfNYUXpoOP?=
 =?iso-8859-1?Q?FyiKzANygzC4CIVFZQ9klaeoO6INzDkqd34LDytCqcXFchqinSk0LfqOUW?=
 =?iso-8859-1?Q?Y35lzoQ0/WmI0h0I4ooBzs+kEJnFVs1oLC3XauYtn5ge8yUXT9qhnOlJq3?=
 =?iso-8859-1?Q?ya1F8Fbvd4aVchcY752D5VMQtC0ajYV2QHEQte2o/ggJK4LZ5SX9FMU4Rm?=
 =?iso-8859-1?Q?C7G3Km4v9T+tgk82o8gkubLjHeFqnTu4phNocHizNce2EB2NkU0uU8nxus?=
 =?iso-8859-1?Q?4us8+fk72ksBrQiA5twpOWHlGefGYPf51enymQqQG9DtdbbXMIo9WoxIvs?=
 =?iso-8859-1?Q?UIC3J3zH6UpxOFqhzwVgKWuZSOWOoP6a75WoB0j9Y9xpvxKESer9Pd6/qu?=
 =?iso-8859-1?Q?EqqCGuUZdQVITRgQ3z3zdryw4GYX8wWegJRLi6G2IiZ+4OnyW7TTz/fm0p?=
 =?iso-8859-1?Q?pa1C+0csEscnGm5QM4k3hyiCGKHb1tIUdQQnQXRe3T2cnVmYfVsGEi1ify?=
 =?iso-8859-1?Q?VEAh5rAWuDWBomSXVCUf0U4luUXVd3PRRL3B82+ve41QkFvxJeBVyS4uyW?=
 =?iso-8859-1?Q?KK9csDKx2rX5SgO+2/FEaq7/VsFhAn6aO7E4Jl0jXqB7X2TYqQefmmVjhe?=
 =?iso-8859-1?Q?4Lfi7voDo/g4NsKYt2uXK2isx+w6smXJtwGvk28QjstNz9t7PN+nyozFrz?=
 =?iso-8859-1?Q?7q3bqwY58O3aTHqs4F8NwEP92gp+jaP22M7If2FBJeMMEJ+gA/dO3rCpFF?=
 =?iso-8859-1?Q?e/xj6LYw77rYnyjW+S12nObtJRPFH0BfOC+0PfjPNXFer4FHs/6yk62IrY?=
 =?iso-8859-1?Q?uzIGYstesy9bKIpT7uteYGzEB4uImXRhVzvMMd+XgqIWh64MXHigZ9+0zn?=
 =?iso-8859-1?Q?zJRnkbDvdltaaUk8XN5SaWeqpCiPPVj8DaTWBZfJ3v7+n1tA2fmBNwg3x6?=
 =?iso-8859-1?Q?PTTbzWeWV4U3LAVZhr8XnyHq013YU9lTdAQj/7QAwLcX0W8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e4efadab-1f7c-4976-6634-08dd44efb50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 07:44:08.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1404

Dear developers and maintainers,=0A=
=0A=
I found a new kernel  NULL-Pointer-Dereference bug titiled "general protect=
ion fault in devlink_info_serial_number_put" while using modified syzkaller=
 fuzzing tool. I Itested it on the latest Linux upstream version (6.13.0-rc=
7)related to ETAS ES58X CAN/USB DRIVER, and it was able to be triggered.=0A=
=0A=
The bug info is:=0A=
=0A=
kernel revision: v6.13-rc7=0A=
OOPS message: general protection fault in devlink_info_serial_number_put=0A=
reproducer:YES=0A=
=0A=
After preliminary analysis,  The root casue may be :=0A=
in the function:  es58x_devlink_info_get drivers/net/can/usb/etas_es58x/es5=
8x_devlink.c=0A=
es58x_dev->udev->serial   =3D=3D NULL ,but no check for it.=0A=
=0A=
 devlink_info_serial_number_put(req, es58x_dev->udev->serial) triggers NPD =
.=0A=
=0A=
Fix suggestion: Check es58x_dev->udev->serial before deference pointer.=0A=
=0A=
If you fix this issue, please add the following tag to the commit:=0A=
Reported-by: yan kang <kangyan91@outlook.com>=0A=
Reported-by: yue sun <samsun1006219@gmail.com=0A=
=0A=
I hope it helps.=0A=
Best regards=0A=
yan kang=0A=
=0A=
Kernel crash log , PoC and .config are listed below.=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
kernel bug report=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Oops: general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI=0A=
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]=0A=
CPU: 0 UID: 0 PID: 5778 Comm: systemd-udevd Not tainted 6.13.0-rc1-00003-gd=
4774759e15b-dirty #87=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:strlen+0x1e/0xa0 lib/string.c:413=0A=
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 00 =
fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04 02 48 8=
9 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 80 7d 00 00=0A=
RSP: 0018:ffffc900063efa18 EFLAGS: 00010296=0A=
RAX: dffffc0000000000 RBX: ffffc900063efb50 RCX: ffffffff864aa263=0A=
RDX: 0000000000000000 RSI: ffffffff89fe1cbc RDI: 0000000000000000=0A=
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1004abf1dc=0A=
R10: 0000000000000000 R11: 00000000000a4001 R12: 0000000000000000=0A=
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8bf5aa00=0A=
FS: =A000007fc385f648c0(0000) GS:ffff888062800000(0000) knlGS:0000000000000=
000=0A=
CS: =A00010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fc38520bd81 CR3: 000000010ee10000 CR4: 0000000000752ef0=0A=
DR0: 0000000000000002 DR1: 0000000000000101 DR2: 0000000080000000=0A=
DR3: 000000000000000a DR6: 00000000fffe07f0 DR7: 0000000000000400=0A=
PKRU: 55555554=0A=
Call Trace:=0A=
 <TASK>=0A=
 __fortify_strlen include/linux/fortify-string.h:268 [inline]=0A=
 nla_put_string include/net/netlink.h:1620 [inline]=0A=
 devlink_info_serial_number_put+0x44/0x80 net/devlink/dev.c:752=0A=
 es58x_devlink_info_get+0x385/0x5b0 drivers/net/can/usb/etas_es58x/es58x_de=
vlink.c:251=0A=
 __devlink_compat_running_version net/devlink/dev.c:1199 [inline]=0A=
 devlink_compat_running_version+0x220/0x800 net/devlink/dev.c:1226=0A=
 dev_ethtool+0x27a/0x330 net/ethtool/ioctl.c:3410=0A=
 dev_ioctl+0x2d4/0x10c0 net/core/dev_ioctl.c:719=0A=
 sock_do_ioctl+0x1ca/0x260 net/socket.c:1223=0A=
 sock_ioctl+0x23a/0x6c0 net/socket.c:1328=0A=
 vfs_ioctl fs/ioctl.c:51 [inline]=0A=
 __do_sys_ioctl fs/ioctl.c:906 [inline]=0A=
 __se_sys_ioctl fs/ioctl.c:892 [inline]=0A=
 __x64_sys_ioctl+0x1a4/0x210 fs/ioctl.c:892=0A=
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]=0A=
 do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83=0A=
 entry_SYSCALL_64_after_hwframe+0x77/0x7f=0A=
RIP: 0033:0x7fc3861222d7=0A=
Code: 00 00 00 48 8b 05 b9 cb 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 89 cb 0d 00 f7 d8 64 89 01 48=0A=
RSP: 002b:00007ffde72635c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 000056515bde9b80 RCX: 00007fc3861222d7=0A=
RDX: 00007ffde7263690 RSI: 0000000000008946 RDI: 0000000000000007=0A=
RBP: 00007ffde72636c0 R08: 000056515bdece40 R09: 0000000000000000=0A=
R10: 00007fc385f646c0 R11: 0000000000000246 R12: 000056515bdece40=0A=
R13: 000056515be3a060 R14: 00007ffde7263690 R15: 0000000000000007=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:strlen+0x1e/0xa0 lib/string.c:413=0A=
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 00 =
fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04 02 48 8=
9 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 80 7d 00 00=0A=
RSP: 0018:ffffc900063efa18 EFLAGS: 00010296=0A=
RAX: dffffc0000000000 RBX: ffffc900063efb50 RCX: ffffffff864aa263=0A=
RDX: 0000000000000000 RSI: ffffffff89fe1cbc RDI: 0000000000000000=0A=
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1004abf1dc=0A=
R10: 0000000000000000 R11: 00000000000a4001 R12: 0000000000000000=0A=
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8bf5aa00=0A=
FS: =A000007fc385f648c0(0000) GS:ffff888135e00000(0000) knlGS:0000000000000=
000=0A=
CS: =A00010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f7c364f4720 CR3: 000000010ee10000 CR4: 0000000000752ef0=0A=
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=0A=
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400=0A=
PKRU: 55555554=0A=
----------------=0A=
Code disassembly (best guess):=0A=
 =A0 0:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 1:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 2:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 3:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 4:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 5:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 6:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 7:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 8:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 9:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 a:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 b:	90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	nop=0A=
 =A0 c:	f3 0f 1e fa =A0 =A0 =A0 =A0 =A0	endbr64=0A=
 =A010:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax=0A=
 =A017:	fc ff df=0A=
 =A01a:	48 89 fa =A0 =A0 =A0 =A0 =A0 =A0 	mov =A0 =A0%rdi,%rdx=0A=
 =A01d:	55 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	push =A0 %rbp=0A=
 =A01e:	48 89 fd =A0 =A0 =A0 =A0 =A0 =A0 	mov =A0 =A0%rdi,%rbp=0A=
 =A021:	48 c1 ea 03 =A0 =A0 =A0 =A0 =A0	shr =A0 =A0$0x3,%rdx=0A=
 =A025:	53 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	push =A0 %rbx=0A=
 =A026:	48 83 ec 08 =A0 =A0 =A0 =A0 =A0	sub =A0 =A0$0x8,%rsp=0A=
* 2a:	0f b6 04 02 =A0 =A0 =A0 =A0 =A0	movzbl (%rdx,%rax,1),%eax <-- trappin=
g instruction=0A=
 =A02e:	48 89 fa =A0 =A0 =A0 =A0 =A0 =A0 	mov =A0 =A0%rdi,%rdx=0A=
 =A031:	83 e2 07 =A0 =A0 =A0 =A0 =A0 =A0 	and =A0 =A0$0x7,%edx=0A=
 =A034:	38 d0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0	cmp =A0 =A0%dl,%al=0A=
 =A036:	7f 04 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0	jg =A0 =A0 0x3c=0A=
 =A038:	84 c0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0	test =A0 %al,%al=0A=
 =A03a:	75 50 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0	jne =A0 =A00x8c=0A=
 =A03c:	80 7d 00 00 =A0 =A0 =A0 =A0 =A0	cmpb =A0 $0x0,0x0(%rbp)=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
poc.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
// autogenerated by syzkaller (https://github.com/google/syzkaller)=0A=
=0A=
#define _GNU_SOURCE=0A=
=0A=
#include <endian.h>=0A=
#include <errno.h>=0A=
#include <fcntl.h>=0A=
#include <stdarg.h>=0A=
#include <stdbool.h>=0A=
#include <stddef.h>=0A=
#include <stdint.h>=0A=
#include <stdio.h>=0A=
#include <stdlib.h>=0A=
#include <string.h>=0A=
#include <sys/mount.h>=0A=
#include <sys/stat.h>=0A=
#include <sys/syscall.h>=0A=
#include <sys/types.h>=0A=
#include <unistd.h>=0A=
=0A=
#include <linux/usb/ch9.h>=0A=
=0A=
static unsigned long long procid;=0A=
=0A=
static void sleep_ms(uint64_t ms)=0A=
{=0A=
  usleep(ms * 1000);=0A=
}=0A=
=0A=
#define MAX_FDS 30=0A=
=0A=
#define USB_MAX_IFACE_NUM 4=0A=
#define USB_MAX_EP_NUM 32=0A=
#define USB_MAX_FDS 6=0A=
=0A=
struct usb_endpoint_index {=0A=
  struct usb_endpoint_descriptor desc;=0A=
  int handle;=0A=
};=0A=
=0A=
struct usb_iface_index {=0A=
  struct usb_interface_descriptor* iface;=0A=
  uint8_t bInterfaceNumber;=0A=
  uint8_t bAlternateSetting;=0A=
  uint8_t bInterfaceClass;=0A=
  struct usb_endpoint_index eps[USB_MAX_EP_NUM];=0A=
  int eps_num;=0A=
};=0A=
=0A=
struct usb_device_index {=0A=
  struct usb_device_descriptor* dev;=0A=
  struct usb_config_descriptor* config;=0A=
  uint8_t bDeviceClass;=0A=
  uint8_t bMaxPower;=0A=
  int config_length;=0A=
  struct usb_iface_index ifaces[USB_MAX_IFACE_NUM];=0A=
  int ifaces_num;=0A=
  int iface_cur;=0A=
};=0A=
=0A=
struct usb_info {=0A=
  int fd;=0A=
  struct usb_device_index index;=0A=
};=0A=
=0A=
static struct usb_info usb_devices[USB_MAX_FDS];=0A=
=0A=
static struct usb_device_index* lookup_usb_index(int fd)=0A=
{=0A=
  for (int i =3D 0; i < USB_MAX_FDS; i++) {=0A=
    if (__atomic_load_n(&usb_devices[i].fd, __ATOMIC_ACQUIRE) =3D=3D fd)=0A=
      return &usb_devices[i].index;=0A=
  }=0A=
  return NULL;=0A=
}=0A=
=0A=
static int usb_devices_num;=0A=
=0A=
static bool parse_usb_descriptor(const char* buffer, size_t length,=0A=
                                 struct usb_device_index* index)=0A=
{=0A=
  if (length < sizeof(*index->dev) + sizeof(*index->config))=0A=
    return false;=0A=
  memset(index, 0, sizeof(*index));=0A=
  index->dev =3D (struct usb_device_descriptor*)buffer;=0A=
  index->config =3D (struct usb_config_descriptor*)(buffer + sizeof(*index-=
>dev));=0A=
  index->bDeviceClass =3D index->dev->bDeviceClass;=0A=
  index->bMaxPower =3D index->config->bMaxPower;=0A=
  index->config_length =3D length - sizeof(*index->dev);=0A=
  index->iface_cur =3D -1;=0A=
  size_t offset =3D 0;=0A=
  while (true) {=0A=
    if (offset + 1 >=3D length)=0A=
      break;=0A=
    uint8_t desc_length =3D buffer[offset];=0A=
    uint8_t desc_type =3D buffer[offset + 1];=0A=
    if (desc_length <=3D 2)=0A=
      break;=0A=
    if (offset + desc_length > length)=0A=
      break;=0A=
    if (desc_type =3D=3D USB_DT_INTERFACE &&=0A=
        index->ifaces_num < USB_MAX_IFACE_NUM) {=0A=
      struct usb_interface_descriptor* iface =3D=0A=
          (struct usb_interface_descriptor*)(buffer + offset);=0A=
      index->ifaces[index->ifaces_num].iface =3D iface;=0A=
      index->ifaces[index->ifaces_num].bInterfaceNumber =3D=0A=
          iface->bInterfaceNumber;=0A=
      index->ifaces[index->ifaces_num].bAlternateSetting =3D=0A=
          iface->bAlternateSetting;=0A=
      index->ifaces[index->ifaces_num].bInterfaceClass =3D iface->bInterfac=
eClass;=0A=
      index->ifaces_num++;=0A=
    }=0A=
    if (desc_type =3D=3D USB_DT_ENDPOINT && index->ifaces_num > 0) {=0A=
      struct usb_iface_index* iface =3D &index->ifaces[index->ifaces_num - =
1];=0A=
      if (iface->eps_num < USB_MAX_EP_NUM) {=0A=
        memcpy(&iface->eps[iface->eps_num].desc, buffer + offset,=0A=
               sizeof(iface->eps[iface->eps_num].desc));=0A=
        iface->eps_num++;=0A=
      }=0A=
    }=0A=
    offset +=3D desc_length;=0A=
  }=0A=
  return true;=0A=
}=0A=
=0A=
static struct usb_device_index* add_usb_index(int fd, const char* dev,=0A=
                                              size_t dev_len)=0A=
{=0A=
  int i =3D __atomic_fetch_add(&usb_devices_num, 1, __ATOMIC_RELAXED);=0A=
  if (i >=3D USB_MAX_FDS)=0A=
    return NULL;=0A=
  if (!parse_usb_descriptor(dev, dev_len, &usb_devices[i].index))=0A=
    return NULL;=0A=
  __atomic_store_n(&usb_devices[i].fd, fd, __ATOMIC_RELEASE);=0A=
  return &usb_devices[i].index;=0A=
}=0A=
=0A=
struct vusb_connect_string_descriptor {=0A=
  uint32_t len;=0A=
  char* str;=0A=
} __attribute__((packed));=0A=
=0A=
struct vusb_connect_descriptors {=0A=
  uint32_t qual_len;=0A=
  char* qual;=0A=
  uint32_t bos_len;=0A=
  char* bos;=0A=
  uint32_t strs_len;=0A=
  struct vusb_connect_string_descriptor strs[0];=0A=
} __attribute__((packed));=0A=
=0A=
static const char default_string[] =3D {8, USB_DT_STRING, 's', 0, 'y', 0, '=
z', 0};=0A=
=0A=
static const char default_lang_id[] =3D {4, USB_DT_STRING, 0x09, 0x04};=0A=
=0A=
static bool=0A=
lookup_connect_response_in(int fd, const struct vusb_connect_descriptors* d=
escs,=0A=
                           const struct usb_ctrlrequest* ctrl,=0A=
                           struct usb_qualifier_descriptor* qual,=0A=
                           char** response_data, uint32_t* response_length)=
=0A=
{=0A=
  struct usb_device_index* index =3D lookup_usb_index(fd);=0A=
  uint8_t str_idx;=0A=
  if (!index)=0A=
    return false;=0A=
  switch (ctrl->bRequestType & USB_TYPE_MASK) {=0A=
  case USB_TYPE_STANDARD:=0A=
    switch (ctrl->bRequest) {=0A=
    case USB_REQ_GET_DESCRIPTOR:=0A=
      switch (ctrl->wValue >> 8) {=0A=
      case USB_DT_DEVICE:=0A=
        *response_data =3D (char*)index->dev;=0A=
        *response_length =3D sizeof(*index->dev);=0A=
        return true;=0A=
      case USB_DT_CONFIG:=0A=
        *response_data =3D (char*)index->config;=0A=
        *response_length =3D index->config_length;=0A=
        return true;=0A=
      case USB_DT_STRING:=0A=
        str_idx =3D (uint8_t)ctrl->wValue;=0A=
        if (descs && str_idx < descs->strs_len) {=0A=
          *response_data =3D descs->strs[str_idx].str;=0A=
          *response_length =3D descs->strs[str_idx].len;=0A=
          return true;=0A=
        }=0A=
        if (str_idx =3D=3D 0) {=0A=
          *response_data =3D (char*)&default_lang_id[0];=0A=
          *response_length =3D default_lang_id[0];=0A=
          return true;=0A=
        }=0A=
        *response_data =3D (char*)&default_string[0];=0A=
        *response_length =3D default_string[0];=0A=
        return true;=0A=
      case USB_DT_BOS:=0A=
        *response_data =3D descs->bos;=0A=
        *response_length =3D descs->bos_len;=0A=
        return true;=0A=
      case USB_DT_DEVICE_QUALIFIER:=0A=
        if (!descs->qual) {=0A=
          qual->bLength =3D sizeof(*qual);=0A=
          qual->bDescriptorType =3D USB_DT_DEVICE_QUALIFIER;=0A=
          qual->bcdUSB =3D index->dev->bcdUSB;=0A=
          qual->bDeviceClass =3D index->dev->bDeviceClass;=0A=
          qual->bDeviceSubClass =3D index->dev->bDeviceSubClass;=0A=
          qual->bDeviceProtocol =3D index->dev->bDeviceProtocol;=0A=
          qual->bMaxPacketSize0 =3D index->dev->bMaxPacketSize0;=0A=
          qual->bNumConfigurations =3D index->dev->bNumConfigurations;=0A=
          qual->bRESERVED =3D 0;=0A=
          *response_data =3D (char*)qual;=0A=
          *response_length =3D sizeof(*qual);=0A=
          return true;=0A=
        }=0A=
        *response_data =3D descs->qual;=0A=
        *response_length =3D descs->qual_len;=0A=
        return true;=0A=
      default:=0A=
        break;=0A=
      }=0A=
      break;=0A=
    default:=0A=
      break;=0A=
    }=0A=
    break;=0A=
  default:=0A=
    break;=0A=
  }=0A=
  return false;=0A=
}=0A=
=0A=
typedef bool (*lookup_connect_out_response_t)(=0A=
    int fd, const struct vusb_connect_descriptors* descs,=0A=
    const struct usb_ctrlrequest* ctrl, bool* done);=0A=
=0A=
static bool lookup_connect_response_out_generic(=0A=
    int fd, const struct vusb_connect_descriptors* descs,=0A=
    const struct usb_ctrlrequest* ctrl, bool* done)=0A=
{=0A=
  switch (ctrl->bRequestType & USB_TYPE_MASK) {=0A=
  case USB_TYPE_STANDARD:=0A=
    switch (ctrl->bRequest) {=0A=
    case USB_REQ_SET_CONFIGURATION:=0A=
      *done =3D true;=0A=
      return true;=0A=
    default:=0A=
      break;=0A=
    }=0A=
    break;=0A=
  }=0A=
  return false;=0A=
}=0A=
=0A=
#define UDC_NAME_LENGTH_MAX 128=0A=
=0A=
struct usb_raw_init {=0A=
  __u8 driver_name[UDC_NAME_LENGTH_MAX];=0A=
  __u8 device_name[UDC_NAME_LENGTH_MAX];=0A=
  __u8 speed;=0A=
};=0A=
=0A=
enum usb_raw_event_type {=0A=
  USB_RAW_EVENT_INVALID =3D 0,=0A=
  USB_RAW_EVENT_CONNECT =3D 1,=0A=
  USB_RAW_EVENT_CONTROL =3D 2,=0A=
};=0A=
=0A=
struct usb_raw_event {=0A=
  __u32 type;=0A=
  __u32 length;=0A=
  __u8 data[0];=0A=
};=0A=
=0A=
struct usb_raw_ep_io {=0A=
  __u16 ep;=0A=
  __u16 flags;=0A=
  __u32 length;=0A=
  __u8 data[0];=0A=
};=0A=
=0A=
#define USB_RAW_EPS_NUM_MAX 30=0A=
#define USB_RAW_EP_NAME_MAX 16=0A=
#define USB_RAW_EP_ADDR_ANY 0xff=0A=
=0A=
struct usb_raw_ep_caps {=0A=
  __u32 type_control : 1;=0A=
  __u32 type_iso : 1;=0A=
  __u32 type_bulk : 1;=0A=
  __u32 type_int : 1;=0A=
  __u32 dir_in : 1;=0A=
  __u32 dir_out : 1;=0A=
};=0A=
=0A=
struct usb_raw_ep_limits {=0A=
  __u16 maxpacket_limit;=0A=
  __u16 max_streams;=0A=
  __u32 reserved;=0A=
};=0A=
=0A=
struct usb_raw_ep_info {=0A=
  __u8 name[USB_RAW_EP_NAME_MAX];=0A=
  __u32 addr;=0A=
  struct usb_raw_ep_caps caps;=0A=
  struct usb_raw_ep_limits limits;=0A=
};=0A=
=0A=
struct usb_raw_eps_info {=0A=
  struct usb_raw_ep_info eps[USB_RAW_EPS_NUM_MAX];=0A=
};=0A=
=0A=
#define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)=0A=
#define USB_RAW_IOCTL_RUN _IO('U', 1)=0A=
#define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)=0A=
#define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)=0A=
#define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)=0A=
#define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descriptor=
)=0A=
#define USB_RAW_IOCTL_EP_DISABLE _IOW('U', 6, __u32)=0A=
#define USB_RAW_IOCTL_EP_WRITE _IOW('U', 7, struct usb_raw_ep_io)=0A=
#define USB_RAW_IOCTL_EP_READ _IOWR('U', 8, struct usb_raw_ep_io)=0A=
#define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)=0A=
#define USB_RAW_IOCTL_VBUS_DRAW _IOW('U', 10, __u32)=0A=
#define USB_RAW_IOCTL_EPS_INFO _IOR('U', 11, struct usb_raw_eps_info)=0A=
#define USB_RAW_IOCTL_EP0_STALL _IO('U', 12)=0A=
#define USB_RAW_IOCTL_EP_SET_HALT _IOW('U', 13, __u32)=0A=
#define USB_RAW_IOCTL_EP_CLEAR_HALT _IOW('U', 14, __u32)=0A=
#define USB_RAW_IOCTL_EP_SET_WEDGE _IOW('U', 15, __u32)=0A=
=0A=
static int usb_raw_open()=0A=
{=0A=
  return open("/dev/raw-gadget", O_RDWR);=0A=
}=0A=
=0A=
static int usb_raw_init(int fd, uint32_t speed, const char* driver,=0A=
                        const char* device)=0A=
{=0A=
  struct usb_raw_init arg;=0A=
  strncpy((char*)&arg.driver_name[0], driver, sizeof(arg.driver_name));=0A=
  strncpy((char*)&arg.device_name[0], device, sizeof(arg.device_name));=0A=
  arg.speed =3D speed;=0A=
  return ioctl(fd, USB_RAW_IOCTL_INIT, &arg);=0A=
}=0A=
=0A=
static int usb_raw_run(int fd)=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_RUN, 0);=0A=
}=0A=
=0A=
static int usb_raw_configure(int fd)=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_CONFIGURE, 0);=0A=
}=0A=
=0A=
static int usb_raw_vbus_draw(int fd, uint32_t power)=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_VBUS_DRAW, power);=0A=
}=0A=
=0A=
static int usb_raw_ep0_write(int fd, struct usb_raw_ep_io* io)=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, io);=0A=
}=0A=
=0A=
static int usb_raw_ep0_read(int fd, struct usb_raw_ep_io* io)=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_EP0_READ, io);=0A=
}=0A=
=0A=
static int usb_raw_event_fetch(int fd, struct usb_raw_event* event)=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, event);=0A=
}=0A=
=0A=
static int usb_raw_ep_enable(int fd, struct usb_endpoint_descriptor* desc)=
=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_EP_ENABLE, desc);=0A=
}=0A=
=0A=
static int usb_raw_ep_disable(int fd, int ep)=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_EP_DISABLE, ep);=0A=
}=0A=
=0A=
static int usb_raw_ep0_stall(int fd)=0A=
{=0A=
  return ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);=0A=
}=0A=
=0A=
#define USB_MAX_PACKET_SIZE 4096=0A=
=0A=
struct usb_raw_control_event {=0A=
  struct usb_raw_event inner;=0A=
  struct usb_ctrlrequest ctrl;=0A=
  char data[USB_MAX_PACKET_SIZE];=0A=
};=0A=
=0A=
struct usb_raw_ep_io_data {=0A=
  struct usb_raw_ep_io inner;=0A=
  char data[USB_MAX_PACKET_SIZE];=0A=
};=0A=
=0A=
static void set_interface(int fd, int n)=0A=
{=0A=
  struct usb_device_index* index =3D lookup_usb_index(fd);=0A=
  if (!index)=0A=
    return;=0A=
  if (index->iface_cur >=3D 0 && index->iface_cur < index->ifaces_num) {=0A=
    for (int ep =3D 0; ep < index->ifaces[index->iface_cur].eps_num; ep++) =
{=0A=
      int rv =3D usb_raw_ep_disable(=0A=
          fd, index->ifaces[index->iface_cur].eps[ep].handle);=0A=
      if (rv < 0) {=0A=
      } else {=0A=
      }=0A=
    }=0A=
  }=0A=
  if (n >=3D 0 && n < index->ifaces_num) {=0A=
    for (int ep =3D 0; ep < index->ifaces[n].eps_num; ep++) {=0A=
      int rv =3D usb_raw_ep_enable(fd, &index->ifaces[n].eps[ep].desc);=0A=
      if (rv < 0) {=0A=
      } else {=0A=
        index->ifaces[n].eps[ep].handle =3D rv;=0A=
      }=0A=
    }=0A=
    index->iface_cur =3D n;=0A=
  }=0A=
}=0A=
=0A=
static int configure_device(int fd)=0A=
{=0A=
  struct usb_device_index* index =3D lookup_usb_index(fd);=0A=
  if (!index)=0A=
    return -1;=0A=
  int rv =3D usb_raw_vbus_draw(fd, index->bMaxPower);=0A=
  if (rv < 0) {=0A=
    return rv;=0A=
  }=0A=
  rv =3D usb_raw_configure(fd);=0A=
  if (rv < 0) {=0A=
    return rv;=0A=
  }=0A=
  set_interface(fd, 0);=0A=
  return 0;=0A=
}=0A=
=0A=
static volatile long=0A=
syz_usb_connect_impl(uint64_t speed, uint64_t dev_len, const char* dev,=0A=
                     const struct vusb_connect_descriptors* descs,=0A=
                     lookup_connect_out_response_t lookup_connect_response_=
out)=0A=
{=0A=
  if (!dev) {=0A=
    return -1;=0A=
  }=0A=
  int fd =3D usb_raw_open();=0A=
  if (fd < 0) {=0A=
    return fd;=0A=
  }=0A=
  if (fd >=3D MAX_FDS) {=0A=
    close(fd);=0A=
    return -1;=0A=
  }=0A=
  struct usb_device_index* index =3D add_usb_index(fd, dev, dev_len);=0A=
  if (!index) {=0A=
    return -1;=0A=
  }=0A=
  char device[32];=0A=
  sprintf(&device[0], "dummy_udc.%llu", procid);=0A=
  int rv =3D usb_raw_init(fd, speed, "dummy_udc", &device[0]);=0A=
  if (rv < 0) {=0A=
    return rv;=0A=
  }=0A=
  rv =3D usb_raw_run(fd);=0A=
  if (rv < 0) {=0A=
    return rv;=0A=
  }=0A=
  bool done =3D false;=0A=
  while (!done) {=0A=
    struct usb_raw_control_event event;=0A=
    event.inner.type =3D 0;=0A=
    event.inner.length =3D sizeof(event.ctrl);=0A=
    rv =3D usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);=0A=
    if (rv < 0) {=0A=
      return rv;=0A=
    }=0A=
    if (event.inner.type !=3D USB_RAW_EVENT_CONTROL)=0A=
      continue;=0A=
    char* response_data =3D NULL;=0A=
    uint32_t response_length =3D 0;=0A=
    struct usb_qualifier_descriptor qual;=0A=
    if (event.ctrl.bRequestType & USB_DIR_IN) {=0A=
      if (!lookup_connect_response_in(fd, descs, &event.ctrl, &qual,=0A=
                                      &response_data, &response_length)) {=
=0A=
        usb_raw_ep0_stall(fd);=0A=
        continue;=0A=
      }=0A=
    } else {=0A=
      if (!lookup_connect_response_out(fd, descs, &event.ctrl, &done)) {=0A=
        usb_raw_ep0_stall(fd);=0A=
        continue;=0A=
      }=0A=
      response_data =3D NULL;=0A=
      response_length =3D event.ctrl.wLength;=0A=
    }=0A=
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDARD =
&&=0A=
        event.ctrl.bRequest =3D=3D USB_REQ_SET_CONFIGURATION) {=0A=
      rv =3D configure_device(fd);=0A=
      if (rv < 0) {=0A=
        return rv;=0A=
      }=0A=
    }=0A=
    struct usb_raw_ep_io_data response;=0A=
    response.inner.ep =3D 0;=0A=
    response.inner.flags =3D 0;=0A=
    if (response_length > sizeof(response.data))=0A=
      response_length =3D 0;=0A=
    if (event.ctrl.wLength < response_length)=0A=
      response_length =3D event.ctrl.wLength;=0A=
    response.inner.length =3D response_length;=0A=
    if (response_data)=0A=
      memcpy(&response.data[0], response_data, response_length);=0A=
    else=0A=
      memset(&response.data[0], 0, response_length);=0A=
    if (event.ctrl.bRequestType & USB_DIR_IN) {=0A=
      rv =3D usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);=0A=
    } else {=0A=
      rv =3D usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);=0A=
    }=0A=
    if (rv < 0) {=0A=
      return rv;=0A=
    }=0A=
  }=0A=
  sleep_ms(200);=0A=
  return fd;=0A=
}=0A=
=0A=
static volatile long syz_usb_connect(volatile long a0, volatile long a1,=0A=
                                     volatile long a2, volatile long a3)=0A=
{=0A=
  uint64_t speed =3D a0;=0A=
  uint64_t dev_len =3D a1;=0A=
  const char* dev =3D (const char*)a2;=0A=
  const struct vusb_connect_descriptors* descs =3D=0A=
      (const struct vusb_connect_descriptors*)a3;=0A=
  return syz_usb_connect_impl(speed, dev_len, dev, descs,=0A=
                              &lookup_connect_response_out_generic);=0A=
}=0A=
=0A=
int main(void)=0A=
{=0A=
  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,=0A=
          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/=
-1,=0A=
          /*offset=3D*/0ul);=0A=
  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,=0A=
          /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,=0A=
          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/=
-1,=0A=
          /*offset=3D*/0ul);=0A=
  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,=0A=
          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/=
-1,=0A=
          /*offset=3D*/0ul);=0A=
  const char* reason;=0A=
  (void)reason;=0A=
  if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {=
=0A=
  }=0A=
  memcpy(=0A=
      (void*)0x20000780,=0A=
      "\x12\x01\x00\x03\x5f\xcc\xd2\x20\x8c\x10\x59\x01\x3a\x7b\x01\x02\x03=
\x01"=0A=
      "\x09\x02\x7b\x08\x02\x02\x06\x90\x0d\x09\x04\x5d\x37\x0f\x3e\xdb\xba=
\x03"=0A=
      "\x09\x21\xf9\xff\x80\x01\x22\xf1\x0a\x09\x05\x01\x02\x08\x00\x01\x81=
\xc2"=0A=
      "\x09\x05\x0f\x01\x08\x00\x02\xc5\x01\x07\x25\x01\x83\x01\x03\x00\x09=
\x05"=0A=
      "\x02\x10\x3c\x00\x09\x03\x06\x07\x25\x01\x55\x09\x06\x00\x09\x05\x09=
\x00"=0A=
      "\x08\x00\x0d\x03\x05\x64\x23\xfa\xe9\x10\xc2\x1d\x2b\x1f\x05\x01\x17=
\x3d"=0A=
      "\xec\x4f\xe8\x2a\x1d\x9a\x7b\x0d\xa9\x7e\x91\x6d\x16\x86\xfd\x1d\x72=
\x5f"=0A=
      "\x19\xb0\x60\x7f\x43\xe8\x2a\x1c\x33\xbd\xab\x25\xb4\x12\x63\x66\x92=
\x41"=0A=
      "\xad\x04\x64\xc8\x97\x1f\x79\x82\x92\x1b\x53\xf9\x2c\xd8\x3f\x62\x3f=
\xf9"=0A=
      "\xdc\xd2\x14\x37\x29\x3a\xcc\x6b\x25\x01\xc4\xc0\x8a\xf1\x0b\x1e\x36=
\x3f"=0A=
      "\xac\x6d\xa5\xf7\xa4\x83\xd3\x10\x9e\x0e\x33\x2c\xf2\xe7\xcb\x07\x25=
\x01"=0A=
      "\x82\x09\x08\x00\x09\x05\x05\x01\x08\x00\x08\x08\x04\x07\x25\x01\x03=
\x08"=0A=
      "\x02\x00\x09\x05\x09\x04\x10\x00\x07\x03\x00\x07\x25\x01\x80\x09\x09=
\x00"=0A=
      "\x09\x05\x05\x10\x20\x00\x00\x06\x03\x07\x25\x01\x00\xfc\x05\x00\xfb=
\x07"=0A=
      "\xe2\x12\x75\xf5\x54\x9b\x12\x93\xaa\xd6\x40\xd0\xd2\xd5\x15\x41\xb4=
\x16"=0A=
      "\xd3\xef\x70\xf3\xe8\x89\x3f\x8d\xf7\x80\x3a\x2e\x7e\x83\x0f\xea\x50=
\x74"=0A=
      "\x2f\xca\xd2\xe3\xaf\xb7\x34\x62\xb6\xdf\xd2\x3a\x01\xa9\x17\x50\xc5=
\x83"=0A=
      "\x58\xf9\xd6\xff\x31\x65\x4c\xb3\x35\x53\xb5\xd1\xa2\x84\xaf\xda\xcd=
\xb7"=0A=
      "\x24\x7e\xa0\xab\x6c\x41\x0d\x4a\xc3\xbc\x06\xf6\x38\xd8\xe8\x8f\x26=
\xb7"=0A=
      "\xc9\xb9\x74\xc6\x4d\x8e\x72\xcd\xae\xf8\xc0\x09\x16\xc5\x1c\x50\xeb=
\x45"=0A=
      "\xe3\x8e\x81\x8e\xa3\x18\x07\x11\x61\x29\x42\xe9\x0c\x04\x4d\x42\xda=
\xb4"=0A=
      "\x9c\x19\x32\xcb\x06\x17\x3b\x86\xe7\x09\x60\x16\x62\xec\x7d\xb9\x51=
\xec"=0A=
      "\xfc\x43\xf4\x6f\xf1\xd8\xaf\x27\x5d\xee\x89\x24\xd8\x71\x7f\xd6\xc0=
\x1a"=0A=
      "\x67\x14\x04\x1f\x41\x0a\x8c\xf0\xd9\x81\x49\x31\xf4\x4f\x94\x13\x5c=
\x30"=0A=
      "\x34\x0b\xda\x8a\x3e\x30\xbc\x50\xa6\x1e\x36\xe8\x5c\x29\x28\x26\x46=
\xc7"=0A=
      "\xa0\x87\xea\x22\xe7\x72\x74\x30\x4e\xad\x67\x3d\x3d\xb0\xe0\x3b\x7a=
\x8c"=0A=
      "\x64\xe2\x5e\x0b\xdc\x1a\x57\x63\x93\xe2\x92\xfb\xad\x87\xe6\x1b\x75=
\xbf"=0A=
      "\xb7\x0e\x8f\x8d\xb0\x88\xb3\x11\x6e\xdb\x14\x3b\xae\x01\x19\x09\x05=
\x0e"=0A=
      "\x14\x00\x04\x80\x40\xf8\xf3\x04\x51\x55\x5b\xa2\x65\x64\xda\x16\x6d=
\x33"=0A=
      "\xfd\x5b\x81\xc7\xa4\x20\xfa\x67\x86\x44\x80\x1a\xfb\x39\x9f\x6c\xf0=
\x8d"=0A=
      "\x65\x54\x42\x20\xa9\xdc\xad\xfe\x6a\xfa\xb6\x49\x3d\x16\xe1\x28\x3c=
\xf7"=0A=
      "\x5a\x85\xda\x31\x16\x3d\xda\x00\xcc\x12\x07\xb2\xe3\x92\x61\xc8\x9b=
\x1b"=0A=
      "\x4b\x40\x66\xd7\x8f\x14\xe2\x8f\xb0\x05\xf5\x43\x0e\xc5\x76\xce\x34=
\x3a"=0A=
      "\xcf\x0c\x4f\xf6\xfc\x6f\x6a\xdf\x84\x88\xb9\x00\xe2\xc9\xeb\x80\x9a=
\xcd"=0A=
      "\xa2\x3b\x02\x8d\xee\xa2\x4e\xbd\xb3\x2e\xbf\x11\x7b\x1d\xaa\xbe\x43=
\xd4"=0A=
      "\x29\x21\xae\x13\x15\xe4\x8f\xb6\x16\x6c\x87\x0d\x0c\xa9\xa2\x14\x1a=
\x2a"=0A=
      "\xff\x0c\xad\x3b\x19\xbf\x39\xbe\x57\xf1\x70\xad\xed\xa8\x35\x03\x91=
\x80"=0A=
      "\x3b\x79\x74\x3a\xd4\xbd\xb5\x3c\x8a\x71\xf6\x00\x71\xa1\xbd\xe7\x1b=
\x16"=0A=
      "\x8b\x9f\x8c\x56\xf2\x10\xeb\x86\x7b\x3a\x11\xc9\xa9\x65\x29\xd5\xba=
\xb2"=0A=
      "\x87\xeb\xd7\x3e\x0a\x58\xca\x98\x7c\x83\x15\xdd\x1e\x1c\x5b\xf5\x98=
\x4c"=0A=
      "\x47\x3b\x83\x27\xaa\x1b\xfe\x41\x79\xf4\xdf\xd3\x88\xc9\x6f\xb6\x85=
\x02"=0A=
      "\x58\xad\x7d\xf5\xd2\xeb\x2c\x7f\x4a\x5b\x1f\xbd\xc4\xcc\xa3\xba\x09=
\xaa"=0A=
      "\xdf\x48\x6d\x82\x97\xcc\xe2\xeb\x66\x0b\xf9\x78\x09\x9e\x0c\x41\x59=
\x20"=0A=
      "\x40\xd8\x5f\xbc\x15\x94\xbd\xd2\x97\x78\x66\xf4\x28\xe3\x26\x13\xc3=
\xb8"=0A=
      "\x9f\xe6\xa3\x11\xb9\x78\xee\x23\x62\x2f\xe1\x93\xcc\xa8\x44\x47\x67=
\xb8"=0A=
      "\x16\xfd\x77\xbf\x91\x15\xd0\xf6\x1a\x0f\xec\xf7\x6a\xf1\x0e\x2e\x75=
\x4b"=0A=
      "\x24\xfe\xc7\x19\x8e\xc4\x92\x41\xe0\x61\x16\x70\xb3\xeb\x90\x7b\x0a=
\x38"=0A=
      "\xba\x3f\xcb\x16\xf1\x66\xe4\xc8\x7d\x10\x6e\x8e\x1e\xfa\xbd\x27\x05=
\x26"=0A=
      "\xf6\x2d\xd4\xb6\x93\xba\xdc\x6e\xd2\x84\x4e\x9b\x5b\x67\x85\xc7\xb9=
\xa3"=0A=
      "\x39\x5b\xe4\x5c\x07\x76\xeb\xc5\x07\xb3\xf6\x93\x4d\x6a\x8b\xf3\xdb=
\x22"=0A=
      "\xda\x63\x73\x02\x83\xc4\x64\x48\x16\x23\x6e\xbf\x65\x06\x6f\xe2\x9a=
\x2e"=0A=
      "\xca\xbd\xd8\x40\xd0\xb8\x1b\xb3\x97\xf9\xac\x83\x46\x6c\x35\xd7\x92=
\xa6"=0A=
      "\x06\xdb\xd4\x09\x05\x03\x02\x08\x00\x07\x01\x47\x09\x05\x05\x18\x40=
\x00"=0A=
      "\xfe\x08\x07\x56\x05\xc4\x36\xac\x01\x64\x2a\xc7\x90\x73\x4d\x26\x6f=
\x37"=0A=
      "\xc1\xad\x9b\xcf\x0a\xa9\xf4\xea\xcd\x98\x2a\xd0\x6c\xd3\xb1\xc7\x47=
\x9d"=0A=
      "\x94\xd3\x5a\xee\x99\x37\xed\xe9\xce\x9a\xa5\x71\x43\x99\x92\x7e\xed=
\x4c"=0A=
      "\x35\x14\x5c\x82\x74\xf2\x74\x0c\x7f\xc8\x32\x89\xd7\x85\x67\xfe\x2a=
\x77"=0A=
      "\xee\x27\x84",=0A=
      1029);=0A=
  *(uint32_t*)0x200004c0 =3D 0;=0A=
  *(uint64_t*)0x200004c4 =3D 0;=0A=
  *(uint32_t*)0x200004cc =3D 0;=0A=
  *(uint64_t*)0x200004d0 =3D 0;=0A=
  *(uint32_t*)0x200004d8 =3D 0x55555814;=0A=
  syz_usb_connect(/*speed=3DUSB_SPEED_HIGH*/ 3, /*dev_len=3D*/0x88d,=0A=
                  /*dev=3D*/0x20000780, /*conn_descs=3D*/0x200004c0);=0A=
  return 0;=0A=
}=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
kernel .config=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
#=0A=
# Automatically generated file; DO NOT EDIT.=0A=
# Linux/x86 6.13.0-rc7 Kernel Configuration=0A=
#=0A=
CONFIG_CC_VERSION_TEXT=3D"gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"=0A=
CONFIG_CC_IS_GCC=3Dy=0A=
CONFIG_GCC_VERSION=3D110400=0A=
CONFIG_CLANG_VERSION=3D0=0A=
CONFIG_AS_IS_GNU=3Dy=0A=
CONFIG_AS_VERSION=3D23800=0A=
CONFIG_LD_IS_BFD=3Dy=0A=
CONFIG_LD_VERSION=3D23800c=0A=
CONFIG_LLD_VERSION=3D0=0A=
CONFIG_RUSTC_VERSION=3D0=0A=
CONFIG_RUSTC_LLVM_VERSION=3D0=0A=
CONFIG_CC_CAN_LINK=3Dy=0A=
CONFIG_CC_CAN_LINK_STATIC=3Dy=0A=
CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=3Dy=0A=
CONFIG_TOOLS_SUPPORT_RELR=3Dy=0A=
CONFIG_CC_HAS_ASM_INLINE=3Dy=0A=
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy=0A=
CONFIG_PAHOLE_VERSION=3D125=0A=
CONFIG_CONSTRUCTORS=3Dy=0A=
CONFIG_IRQ_WORK=3Dy=0A=
CONFIG_BUILDTIME_TABLE_SORT=3Dy=0A=
CONFIG_THREAD_INFO_IN_TASK=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_INIT_ENV_ARG_LIMIT=3D32=0A=
# CONFIG_COMPILE_TEST is not set=0A=
# CONFIG_WERROR is not set=0A=
CONFIG_LOCALVERSION=3D""=0A=
CONFIG_LOCALVERSION_AUTO=3Dy=0A=
CONFIG_BUILD_SALT=3D""=0A=
CONFIG_HAVE_KERNEL_GZIP=3Dy=0A=
CONFIG_HAVE_KERNEL_BZIP2=3Dy=0A=
CONFIG_HAVE_KERNEL_LZMA=3Dy=0A=
CONFIG_HAVE_KERNEL_XZ=3Dy=0A=
CONFIG_HAVE_KERNEL_LZO=3Dy=0A=
CONFIG_HAVE_KERNEL_LZ4=3Dy=0A=
CONFIG_HAVE_KERNEL_ZSTD=3Dy=0A=
CONFIG_KERNEL_GZIP=3Dy=0A=
# CONFIG_KERNEL_BZIP2 is not set=0A=
# CONFIG_KERNEL_LZMA is not set=0A=
# CONFIG_KERNEL_XZ is not set=0A=
# CONFIG_KERNEL_LZO is not set=0A=
# CONFIG_KERNEL_LZ4 is not set=0A=
# CONFIG_KERNEL_ZSTD is not set=0A=
CONFIG_DEFAULT_INIT=3D""=0A=
CONFIG_DEFAULT_HOSTNAME=3D"(none)"=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_SYSVIPC_SYSCTL=3Dy=0A=
CONFIG_SYSVIPC_COMPAT=3Dy=0A=
CONFIG_POSIX_MQUEUE=3Dy=0A=
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy=0A=
CONFIG_WATCH_QUEUE=3Dy=0A=
CONFIG_CROSS_MEMORY_ATTACH=3Dy=0A=
# CONFIG_USELIB is not set=0A=
CONFIG_AUDIT=3Dy=0A=
CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy=0A=
CONFIG_AUDITSYSCALL=3Dy=0A=
=0A=
#=0A=
# IRQ subsystem=0A=
#=0A=
CONFIG_GENERIC_IRQ_PROBE=3Dy=0A=
CONFIG_GENERIC_IRQ_SHOW=3Dy=0A=
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy=0A=
CONFIG_GENERIC_PENDING_IRQ=3Dy=0A=
CONFIG_GENERIC_IRQ_MIGRATION=3Dy=0A=
CONFIG_HARDIRQS_SW_RESEND=3Dy=0A=
CONFIG_IRQ_DOMAIN=3Dy=0A=
CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy=0A=
CONFIG_GENERIC_MSI_IRQ=3Dy=0A=
CONFIG_IRQ_MSI_IOMMU=3Dy=0A=
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy=0A=
CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy=0A=
CONFIG_IRQ_FORCED_THREADING=3Dy=0A=
CONFIG_SPARSE_IRQ=3Dy=0A=
# CONFIG_GENERIC_IRQ_DEBUGFS is not set=0A=
# end of IRQ subsystem=0A=
=0A=
CONFIG_CLOCKSOURCE_WATCHDOG=3Dy=0A=
CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy=0A=
CONFIG_GENERIC_TIME_VSYSCALL=3Dy=0A=
CONFIG_GENERIC_CLOCKEVENTS=3Dy=0A=
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy=0A=
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=3Dy=0A=
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy=0A=
CONFIG_GENERIC_CMOS_UPDATE=3Dy=0A=
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy=0A=
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy=0A=
CONFIG_CONTEXT_TRACKING=3Dy=0A=
CONFIG_CONTEXT_TRACKING_IDLE=3Dy=0A=
=0A=
#=0A=
# Timers subsystem=0A=
#=0A=
CONFIG_TICK_ONESHOT=3Dy=0A=
CONFIG_NO_HZ_COMMON=3Dy=0A=
# CONFIG_HZ_PERIODIC is not set=0A=
CONFIG_NO_HZ_IDLE=3Dy=0A=
# CONFIG_NO_HZ_FULL is not set=0A=
CONFIG_CONTEXT_TRACKING_USER=3Dy=0A=
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set=0A=
CONFIG_NO_HZ=3Dy=0A=
CONFIG_HIGH_RES_TIMERS=3Dy=0A=
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=3D125=0A=
# end of Timers subsystem=0A=
=0A=
CONFIG_BPF=3Dy=0A=
CONFIG_HAVE_EBPF_JIT=3Dy=0A=
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy=0A=
=0A=
#=0A=
# BPF subsystem=0A=
#=0A=
CONFIG_BPF_SYSCALL=3Dy=0A=
CONFIG_BPF_JIT=3Dy=0A=
# CONFIG_BPF_JIT_ALWAYS_ON is not set=0A=
CONFIG_BPF_JIT_DEFAULT_ON=3Dy=0A=
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set=0A=
CONFIG_USERMODE_DRIVER=3Dy=0A=
CONFIG_BPF_PRELOAD=3Dy=0A=
CONFIG_BPF_PRELOAD_UMD=3Dy=0A=
CONFIG_BPF_LSM=3Dy=0A=
# end of BPF subsystem=0A=
=0A=
CONFIG_PREEMPT_BUILD=3Dy=0A=
CONFIG_ARCH_HAS_PREEMPT_LAZY=3Dy=0A=
# CONFIG_PREEMPT_NONE is not set=0A=
# CONFIG_PREEMPT_VOLUNTARY is not set=0A=
CONFIG_PREEMPT=3Dy=0A=
# CONFIG_PREEMPT_LAZY is not set=0A=
# CONFIG_PREEMPT_RT is not set=0A=
CONFIG_PREEMPT_COUNT=3Dy=0A=
CONFIG_PREEMPTION=3Dy=0A=
CONFIG_PREEMPT_DYNAMIC=3Dy=0A=
CONFIG_SCHED_CORE=3Dy=0A=
=0A=
#=0A=
# CPU/Task time and stats accounting=0A=
#=0A=
CONFIG_VIRT_CPU_ACCOUNTING=3Dy=0A=
# CONFIG_TICK_CPU_ACCOUNTING is not set=0A=
CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy=0A=
CONFIG_IRQ_TIME_ACCOUNTING=3Dy=0A=
CONFIG_HAVE_SCHED_AVG_IRQ=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT_V3=3Dy=0A=
CONFIG_TASKSTATS=3Dy=0A=
CONFIG_TASK_DELAY_ACCT=3Dy=0A=
CONFIG_TASK_XACCT=3Dy=0A=
CONFIG_TASK_IO_ACCOUNTING=3Dy=0A=
CONFIG_PSI=3Dy=0A=
# CONFIG_PSI_DEFAULT_DISABLED is not set=0A=
# end of CPU/Task time and stats accounting=0A=
=0A=
CONFIG_CPU_ISOLATION=3Dy=0A=
=0A=
#=0A=
# RCU Subsystem=0A=
#=0A=
CONFIG_TREE_RCU=3Dy=0A=
CONFIG_PREEMPT_RCU=3Dy=0A=
# CONFIG_RCU_EXPERT is not set=0A=
CONFIG_TREE_SRCU=3Dy=0A=
CONFIG_TASKS_RCU_GENERIC=3Dy=0A=
CONFIG_NEED_TASKS_RCU=3Dy=0A=
CONFIG_TASKS_RCU=3Dy=0A=
CONFIG_TASKS_TRACE_RCU=3Dy=0A=
CONFIG_RCU_STALL_COMMON=3Dy=0A=
CONFIG_RCU_NEED_SEGCBLIST=3Dy=0A=
# end of RCU Subsystem=0A=
=0A=
CONFIG_IKCONFIG=3Dy=0A=
CONFIG_IKCONFIG_PROC=3Dy=0A=
# CONFIG_IKHEADERS is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D18=0A=
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12=0A=
# CONFIG_PRINTK_INDEX is not set=0A=
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy=0A=
=0A=
#=0A=
# Scheduler features=0A=
#=0A=
# CONFIG_UCLAMP_TASK is not set=0A=
# end of Scheduler features=0A=
=0A=
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy=0A=
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy=0A=
CONFIG_CC_HAS_INT128=3Dy=0A=
CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"=0A=
CONFIG_GCC10_NO_ARRAY_BOUNDS=3Dy=0A=
CONFIG_CC_NO_ARRAY_BOUNDS=3Dy=0A=
CONFIG_GCC_NO_STRINGOP_OVERFLOW=3Dy=0A=
CONFIG_CC_NO_STRINGOP_OVERFLOW=3Dy=0A=
CONFIG_ARCH_SUPPORTS_INT128=3Dy=0A=
CONFIG_NUMA_BALANCING=3Dy=0A=
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy=0A=
CONFIG_SLAB_OBJ_EXT=3Dy=0A=
CONFIG_CGROUPS=3Dy=0A=
CONFIG_PAGE_COUNTER=3Dy=0A=
# CONFIG_CGROUP_FAVOR_DYNMODS is not set=0A=
CONFIG_MEMCG=3Dy=0A=
CONFIG_MEMCG_V1=3Dy=0A=
CONFIG_BLK_CGROUP=3Dy=0A=
CONFIG_CGROUP_WRITEBACK=3Dy=0A=
CONFIG_CGROUP_SCHED=3Dy=0A=
CONFIG_GROUP_SCHED_WEIGHT=3Dy=0A=
CONFIG_FAIR_GROUP_SCHED=3Dy=0A=
CONFIG_CFS_BANDWIDTH=3Dy=0A=
# CONFIG_RT_GROUP_SCHED is not set=0A=
CONFIG_SCHED_MM_CID=3Dy=0A=
CONFIG_CGROUP_PIDS=3Dy=0A=
CONFIG_CGROUP_RDMA=3Dy=0A=
CONFIG_CGROUP_FREEZER=3Dy=0A=
CONFIG_CGROUP_HUGETLB=3Dy=0A=
CONFIG_CPUSETS=3Dy=0A=
# CONFIG_CPUSETS_V1 is not set=0A=
CONFIG_PROC_PID_CPUSET=3Dy=0A=
CONFIG_CGROUP_DEVICE=3Dy=0A=
CONFIG_CGROUP_CPUACCT=3Dy=0A=
CONFIG_CGROUP_PERF=3Dy=0A=
CONFIG_CGROUP_BPF=3Dy=0A=
CONFIG_CGROUP_MISC=3Dy=0A=
CONFIG_CGROUP_DEBUG=3Dy=0A=
CONFIG_SOCK_CGROUP_DATA=3Dy=0A=
CONFIG_NAMESPACES=3Dy=0A=
CONFIG_UTS_NS=3Dy=0A=
CONFIG_TIME_NS=3Dy=0A=
CONFIG_IPC_NS=3Dy=0A=
CONFIG_USER_NS=3Dy=0A=
CONFIG_PID_NS=3Dy=0A=
CONFIG_NET_NS=3Dy=0A=
CONFIG_CHECKPOINT_RESTORE=3Dy=0A=
# CONFIG_SCHED_AUTOGROUP is not set=0A=
CONFIG_RELAY=3Dy=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_INITRAMFS_SOURCE=3D""=0A=
CONFIG_RD_GZIP=3Dy=0A=
CONFIG_RD_BZIP2=3Dy=0A=
CONFIG_RD_LZMA=3Dy=0A=
CONFIG_RD_XZ=3Dy=0A=
CONFIG_RD_LZO=3Dy=0A=
CONFIG_RD_LZ4=3Dy=0A=
CONFIG_RD_ZSTD=3Dy=0A=
# CONFIG_BOOT_CONFIG is not set=0A=
CONFIG_INITRAMFS_PRESERVE_MTIME=3Dy=0A=
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
CONFIG_LD_ORPHAN_WARN=3Dy=0A=
CONFIG_LD_ORPHAN_WARN_LEVEL=3D"warn"=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_HAVE_UID16=3Dy=0A=
CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy=0A=
CONFIG_HAVE_PCSPKR_PLATFORM=3Dy=0A=
CONFIG_EXPERT=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_MULTIUSER=3Dy=0A=
CONFIG_SGETMASK_SYSCALL=3Dy=0A=
CONFIG_SYSFS_SYSCALL=3Dy=0A=
CONFIG_FHANDLE=3Dy=0A=
CONFIG_POSIX_TIMERS=3Dy=0A=
CONFIG_PRINTK=3Dy=0A=
CONFIG_BUG=3Dy=0A=
CONFIG_ELF_CORE=3Dy=0A=
CONFIG_PCSPKR_PLATFORM=3Dy=0A=
# CONFIG_BASE_SMALL is not set=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_FUTEX_PI=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_SIGNALFD=3Dy=0A=
CONFIG_TIMERFD=3Dy=0A=
CONFIG_EVENTFD=3Dy=0A=
CONFIG_SHMEM=3Dy=0A=
CONFIG_AIO=3Dy=0A=
CONFIG_IO_URING=3Dy=0A=
CONFIG_ADVISE_SYSCALLS=3Dy=0A=
CONFIG_MEMBARRIER=3Dy=0A=
CONFIG_KCMP=3Dy=0A=
CONFIG_RSEQ=3Dy=0A=
# CONFIG_DEBUG_RSEQ is not set=0A=
CONFIG_CACHESTAT_SYSCALL=3Dy=0A=
# CONFIG_PC104 is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
# CONFIG_KALLSYMS_SELFTEST is not set=0A=
CONFIG_KALLSYMS_ALL=3Dy=0A=
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy=0A=
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy=0A=
CONFIG_HAVE_PERF_EVENTS=3Dy=0A=
CONFIG_GUEST_PERF_EVENTS=3Dy=0A=
=0A=
#=0A=
# Kernel Performance Events And Counters=0A=
#=0A=
CONFIG_PERF_EVENTS=3Dy=0A=
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set=0A=
# end of Kernel Performance Events And Counters=0A=
=0A=
CONFIG_SYSTEM_DATA_VERIFICATION=3Dy=0A=
CONFIG_PROFILING=3Dy=0A=
CONFIG_TRACEPOINTS=3Dy=0A=
=0A=
#=0A=
# Kexec and crash features=0A=
#=0A=
CONFIG_CRASH_RESERVE=3Dy=0A=
CONFIG_VMCORE_INFO=3Dy=0A=
CONFIG_KEXEC_CORE=3Dy=0A=
CONFIG_KEXEC=3Dy=0A=
# CONFIG_KEXEC_FILE is not set=0A=
# CONFIG_KEXEC_JUMP is not set=0A=
CONFIG_CRASH_DUMP=3Dy=0A=
CONFIG_CRASH_HOTPLUG=3Dy=0A=
CONFIG_CRASH_MAX_MEMORY_RANGES=3D8192=0A=
# end of Kexec and crash features=0A=
# end of General setup=0A=
=0A=
CONFIG_64BIT=3Dy=0A=
CONFIG_X86_64=3Dy=0A=
CONFIG_X86=3Dy=0A=
CONFIG_INSTRUCTION_DECODER=3Dy=0A=
CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"=0A=
CONFIG_LOCKDEP_SUPPORT=3Dy=0A=
CONFIG_STACKTRACE_SUPPORT=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28=0A=
CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32=0A=
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8=0A=
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
CONFIG_GENERIC_CSUM=3Dy=0A=
CONFIG_GENERIC_BUG=3Dy=0A=
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy=0A=
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy=0A=
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0A=
CONFIG_ARCH_HAS_CPU_RELAX=3Dy=0A=
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy=0A=
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy=0A=
CONFIG_AUDIT_ARCH=3Dy=0A=
CONFIG_KASAN_SHADOW_OFFSET=3D0xdffffc0000000000=0A=
CONFIG_HAVE_INTEL_TXT=3Dy=0A=
CONFIG_X86_64_SMP=3Dy=0A=
CONFIG_ARCH_SUPPORTS_UPROBES=3Dy=0A=
CONFIG_FIX_EARLYCON_MEM=3Dy=0A=
CONFIG_PGTABLE_LEVELS=3D4=0A=
CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_SMP=3Dy=0A=
CONFIG_X86_X2APIC=3Dy=0A=
# CONFIG_X86_POSTED_MSI is not set=0A=
CONFIG_X86_MPPARSE=3Dy=0A=
# CONFIG_X86_CPU_RESCTRL is not set=0A=
# CONFIG_X86_FRED is not set=0A=
CONFIG_X86_EXTENDED_PLATFORM=3Dy=0A=
# CONFIG_X86_NUMACHIP is not set=0A=
# CONFIG_X86_VSMP is not set=0A=
# CONFIG_X86_GOLDFISH is not set=0A=
# CONFIG_X86_INTEL_MID is not set=0A=
# CONFIG_X86_INTEL_LPSS is not set=0A=
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set=0A=
CONFIG_IOSF_MBI=3Dy=0A=
# CONFIG_IOSF_MBI_DEBUG is not set=0A=
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy=0A=
CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy=0A=
CONFIG_HYPERVISOR_GUEST=3Dy=0A=
CONFIG_PARAVIRT=3Dy=0A=
CONFIG_PARAVIRT_DEBUG=3Dy=0A=
CONFIG_PARAVIRT_SPINLOCKS=3Dy=0A=
CONFIG_X86_HV_CALLBACK_VECTOR=3Dy=0A=
# CONFIG_XEN is not set=0A=
CONFIG_KVM_GUEST=3Dy=0A=
CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy=0A=
CONFIG_PVH=3Dy=0A=
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set=0A=
CONFIG_PARAVIRT_CLOCK=3Dy=0A=
# CONFIG_JAILHOUSE_GUEST is not set=0A=
# CONFIG_ACRN_GUEST is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MPSC is not set=0A=
CONFIG_MCORE2=3Dy=0A=
# CONFIG_MATOM is not set=0A=
# CONFIG_GENERIC_CPU is not set=0A=
CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D6=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
CONFIG_X86_P6_NOP=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_HAVE_PAE=3Dy=0A=
CONFIG_X86_CMPXCHG64=3Dy=0A=
CONFIG_X86_CMOV=3Dy=0A=
CONFIG_X86_MINIMUM_CPU_FAMILY=3D64=0A=
CONFIG_X86_DEBUGCTLMSR=3Dy=0A=
CONFIG_IA32_FEAT_CTL=3Dy=0A=
CONFIG_X86_VMX_FEATURE_NAMES=3Dy=0A=
CONFIG_PROCESSOR_SELECT=3Dy=0A=
CONFIG_CPU_SUP_INTEL=3Dy=0A=
CONFIG_CPU_SUP_AMD=3Dy=0A=
# CONFIG_CPU_SUP_HYGON is not set=0A=
# CONFIG_CPU_SUP_CENTAUR is not set=0A=
# CONFIG_CPU_SUP_ZHAOXIN is not set=0A=
CONFIG_HPET_TIMER=3Dy=0A=
CONFIG_HPET_EMULATE_RTC=3Dy=0A=
CONFIG_DMI=3Dy=0A=
# CONFIG_GART_IOMMU is not set=0A=
CONFIG_BOOT_VESA_SUPPORT=3Dy=0A=
# CONFIG_MAXSMP is not set=0A=
CONFIG_NR_CPUS_RANGE_BEGIN=3D2=0A=
CONFIG_NR_CPUS_RANGE_END=3D512=0A=
CONFIG_NR_CPUS_DEFAULT=3D64=0A=
CONFIG_NR_CPUS=3D8=0A=
CONFIG_SCHED_CLUSTER=3Dy=0A=
CONFIG_SCHED_SMT=3Dy=0A=
CONFIG_SCHED_MC=3Dy=0A=
CONFIG_SCHED_MC_PRIO=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_ACPI_MADT_WAKEUP=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCELOG_LEGACY is not set=0A=
CONFIG_X86_MCE_INTEL=3Dy=0A=
CONFIG_X86_MCE_AMD=3Dy=0A=
CONFIG_X86_MCE_THRESHOLD=3Dy=0A=
# CONFIG_X86_MCE_INJECT is not set=0A=
=0A=
#=0A=
# Performance monitoring=0A=
#=0A=
CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dy=0A=
CONFIG_PERF_EVENTS_INTEL_RAPL=3Dy=0A=
CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dy=0A=
# CONFIG_PERF_EVENTS_AMD_POWER is not set=0A=
CONFIG_PERF_EVENTS_AMD_UNCORE=3Dy=0A=
# CONFIG_PERF_EVENTS_AMD_BRS is not set=0A=
# end of Performance monitoring=0A=
=0A=
CONFIG_X86_16BIT=3Dy=0A=
CONFIG_X86_ESPFIX64=3Dy=0A=
CONFIG_X86_VSYSCALL_EMULATION=3Dy=0A=
CONFIG_X86_IOPL_IOPERM=3Dy=0A=
CONFIG_MICROCODE=3Dy=0A=
# CONFIG_MICROCODE_LATE_LOADING is not set=0A=
CONFIG_X86_MSR=3Dy=0A=
CONFIG_X86_CPUID=3Dy=0A=
# CONFIG_X86_5LEVEL is not set=0A=
CONFIG_X86_DIRECT_GBPAGES=3Dy=0A=
# CONFIG_X86_CPA_STATISTICS is not set=0A=
CONFIG_NUMA=3Dy=0A=
CONFIG_AMD_NUMA=3Dy=0A=
CONFIG_X86_64_ACPI_NUMA=3Dy=0A=
CONFIG_NODES_SHIFT=3D6=0A=
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy=0A=
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy=0A=
# CONFIG_ARCH_MEMORY_PROBE is not set=0A=
CONFIG_ARCH_PROC_KCORE_TEXT=3Dy=0A=
CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000=0A=
# CONFIG_X86_PMEM_LEGACY is not set=0A=
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set=0A=
CONFIG_MTRR=3Dy=0A=
# CONFIG_MTRR_SANITIZER is not set=0A=
CONFIG_X86_PAT=3Dy=0A=
CONFIG_X86_UMIP=3Dy=0A=
CONFIG_CC_HAS_IBT=3Dy=0A=
CONFIG_X86_CET=3Dy=0A=
CONFIG_X86_KERNEL_IBT=3Dy=0A=
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy=0A=
CONFIG_ARCH_PKEY_BITS=3D4=0A=
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set=0A=
CONFIG_X86_INTEL_TSX_MODE_ON=3Dy=0A=
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set=0A=
CONFIG_X86_SGX=3Dy=0A=
CONFIG_X86_USER_SHADOW_STACK=3Dy=0A=
# CONFIG_EFI is not set=0A=
CONFIG_HZ_100=3Dy=0A=
# CONFIG_HZ_250 is not set=0A=
# CONFIG_HZ_300 is not set=0A=
# CONFIG_HZ_1000 is not set=0A=
CONFIG_HZ=3D100=0A=
CONFIG_SCHED_HRTICK=3Dy=0A=
CONFIG_ARCH_SUPPORTS_KEXEC=3Dy=0A=
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=3Dy=0A=
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=3Dy=0A=
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=3Dy=0A=
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=3Dy=0A=
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=3Dy=0A=
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=3Dy=0A=
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=3Dy=0A=
CONFIG_ARCH_DEFAULT_CRASH_DUMP=3Dy=0A=
CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=3Dy=0A=
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=3Dy=0A=
CONFIG_PHYSICAL_START=3D0x1000000=0A=
# CONFIG_RELOCATABLE is not set=0A=
CONFIG_PHYSICAL_ALIGN=3D0x200000=0A=
CONFIG_HOTPLUG_CPU=3Dy=0A=
# CONFIG_COMPAT_VDSO is not set=0A=
CONFIG_LEGACY_VSYSCALL_XONLY=3Dy=0A=
# CONFIG_LEGACY_VSYSCALL_NONE is not set=0A=
CONFIG_CMDLINE_BOOL=3Dy=0A=
CONFIG_CMDLINE=3D"earlyprintk=3Dserial net.ifnames=3D0 sysctl.kernel.hung_t=
ask_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-conntrack-ftp.ports=3D20000 n=
f-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000 nf-conntrack-=
irc.ports=3D20000 nf-conntrack-sane.ports=3D20000 binder.debug_mask=3D0 rcu=
pdate.rcu_expedited=3D1 rcupdate.rcu_cpu_stall_cputime=3D1 no_hash_pointers=
 page_owner=3Don sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_hugepag=
es=3D4 secretmem.enable=3D1 sysctl.max_rcu_stall_to_panic=3D1 msr.allow_wri=
tes=3Doff coredump_filter=3D0xffff root=3D/dev/sda console=3DttyS0 vsyscall=
=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 spec_store_bypass_disable=3D=
prctl nopcid vivid.n_devs=3D64 vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1,2,=
1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2=
,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D32 rose.rose_ndevs=3D32 smp.=
csd_lock_timeout=3D100000 watchdog_thresh=3D55 workqueue.watchdog_thresh=3D=
140 sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.num=3D32=
 max_loop=3D32 nbds_max=3D32 panic_on_warn=3D1"=0A=
# CONFIG_CMDLINE_OVERRIDE is not set=0A=
CONFIG_MODIFY_LDT_SYSCALL=3Dy=0A=
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set=0A=
CONFIG_HAVE_LIVEPATCH=3Dy=0A=
CONFIG_X86_BUS_LOCK_DETECT=3Dy=0A=
# end of Processor type and features=0A=
=0A=
CONFIG_CC_HAS_NAMED_AS=3Dy=0A=
CONFIG_CC_HAS_SLS=3Dy=0A=
CONFIG_CC_HAS_RETURN_THUNK=3Dy=0A=
CONFIG_CC_HAS_ENTRY_PADDING=3Dy=0A=
CONFIG_FUNCTION_PADDING_CFI=3D11=0A=
CONFIG_FUNCTION_PADDING_BYTES=3D16=0A=
CONFIG_CALL_PADDING=3Dy=0A=
CONFIG_HAVE_CALL_THUNKS=3Dy=0A=
CONFIG_CALL_THUNKS=3Dy=0A=
CONFIG_PREFIX_SYMBOLS=3Dy=0A=
CONFIG_CPU_MITIGATIONS=3Dy=0A=
CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=3Dy=0A=
CONFIG_MITIGATION_RETPOLINE=3Dy=0A=
CONFIG_MITIGATION_RETHUNK=3Dy=0A=
CONFIG_MITIGATION_UNRET_ENTRY=3Dy=0A=
CONFIG_MITIGATION_CALL_DEPTH_TRACKING=3Dy=0A=
# CONFIG_CALL_THUNKS_DEBUG is not set=0A=
CONFIG_MITIGATION_IBPB_ENTRY=3Dy=0A=
CONFIG_MITIGATION_IBRS_ENTRY=3Dy=0A=
CONFIG_MITIGATION_SRSO=3Dy=0A=
# CONFIG_MITIGATION_SLS is not set=0A=
CONFIG_MITIGATION_GDS=3Dy=0A=
CONFIG_MITIGATION_RFDS=3Dy=0A=
CONFIG_MITIGATION_SPECTRE_BHI=3Dy=0A=
CONFIG_MITIGATION_MDS=3Dy=0A=
CONFIG_MITIGATION_TAA=3Dy=0A=
CONFIG_MITIGATION_MMIO_STALE_DATA=3Dy=0A=
CONFIG_MITIGATION_L1TF=3Dy=0A=
CONFIG_MITIGATION_RETBLEED=3Dy=0A=
CONFIG_MITIGATION_SPECTRE_V1=3Dy=0A=
CONFIG_MITIGATION_SPECTRE_V2=3Dy=0A=
CONFIG_MITIGATION_SRBDS=3Dy=0A=
CONFIG_MITIGATION_SSB=3Dy=0A=
CONFIG_ARCH_HAS_ADD_PAGES=3Dy=0A=
=0A=
#=0A=
# Power management and ACPI options=0A=
#=0A=
CONFIG_ARCH_HIBERNATION_HEADER=3Dy=0A=
CONFIG_SUSPEND=3Dy=0A=
CONFIG_SUSPEND_FREEZER=3Dy=0A=
# CONFIG_SUSPEND_SKIP_SYNC is not set=0A=
CONFIG_HIBERNATE_CALLBACKS=3Dy=0A=
CONFIG_HIBERNATION=3Dy=0A=
CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy=0A=
CONFIG_HIBERNATION_COMP_LZO=3Dy=0A=
# CONFIG_HIBERNATION_COMP_LZ4 is not set=0A=
CONFIG_HIBERNATION_DEF_COMP=3D"lzo"=0A=
CONFIG_PM_STD_PARTITION=3D""=0A=
CONFIG_PM_SLEEP=3Dy=0A=
CONFIG_PM_SLEEP_SMP=3Dy=0A=
# CONFIG_PM_AUTOSLEEP is not set=0A=
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set=0A=
# CONFIG_PM_WAKELOCKS is not set=0A=
CONFIG_PM=3Dy=0A=
CONFIG_PM_DEBUG=3Dy=0A=
# CONFIG_PM_ADVANCED_DEBUG is not set=0A=
# CONFIG_PM_TEST_SUSPEND is not set=0A=
CONFIG_PM_SLEEP_DEBUG=3Dy=0A=
# CONFIG_DPM_WATCHDOG is not set=0A=
CONFIG_PM_TRACE=3Dy=0A=
CONFIG_PM_TRACE_RTC=3Dy=0A=
CONFIG_PM_CLK=3Dy=0A=
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set=0A=
# CONFIG_ENERGY_MODEL is not set=0A=
CONFIG_ARCH_SUPPORTS_ACPI=3Dy=0A=
CONFIG_ACPI=3Dy=0A=
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy=0A=
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy=0A=
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy=0A=
CONFIG_ACPI_THERMAL_LIB=3Dy=0A=
# CONFIG_ACPI_DEBUGGER is not set=0A=
CONFIG_ACPI_SPCR_TABLE=3Dy=0A=
# CONFIG_ACPI_FPDT is not set=0A=
CONFIG_ACPI_LPIT=3Dy=0A=
CONFIG_ACPI_SLEEP=3Dy=0A=
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy=0A=
CONFIG_ACPI_EC=3Dy=0A=
# CONFIG_ACPI_EC_DEBUGFS is not set=0A=
CONFIG_ACPI_AC=3Dy=0A=
CONFIG_ACPI_BATTERY=3Dy=0A=
CONFIG_ACPI_BUTTON=3Dy=0A=
CONFIG_ACPI_VIDEO=3Dy=0A=
CONFIG_ACPI_FAN=3Dy=0A=
# CONFIG_ACPI_TAD is not set=0A=
CONFIG_ACPI_DOCK=3Dy=0A=
CONFIG_ACPI_CPU_FREQ_PSS=3Dy=0A=
CONFIG_ACPI_PROCESSOR_CSTATE=3Dy=0A=
CONFIG_ACPI_PROCESSOR_IDLE=3Dy=0A=
CONFIG_ACPI_CPPC_LIB=3Dy=0A=
CONFIG_ACPI_PROCESSOR=3Dy=0A=
CONFIG_ACPI_HOTPLUG_CPU=3Dy=0A=
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set=0A=
CONFIG_ACPI_THERMAL=3Dy=0A=
CONFIG_ACPI_PLATFORM_PROFILE=3Dy=0A=
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy=0A=
CONFIG_ACPI_TABLE_UPGRADE=3Dy=0A=
# CONFIG_ACPI_DEBUG is not set=0A=
# CONFIG_ACPI_PCI_SLOT is not set=0A=
CONFIG_ACPI_CONTAINER=3Dy=0A=
# CONFIG_ACPI_HOTPLUG_MEMORY is not set=0A=
CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy=0A=
# CONFIG_ACPI_SBS is not set=0A=
# CONFIG_ACPI_HED is not set=0A=
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set=0A=
CONFIG_ACPI_NHLT=3Dy=0A=
CONFIG_ACPI_NFIT=3Dy=0A=
# CONFIG_NFIT_SECURITY_DEBUG is not set=0A=
CONFIG_ACPI_NUMA=3Dy=0A=
# CONFIG_ACPI_HMAT is not set=0A=
CONFIG_HAVE_ACPI_APEI=3Dy=0A=
CONFIG_HAVE_ACPI_APEI_NMI=3Dy=0A=
# CONFIG_ACPI_APEI is not set=0A=
# CONFIG_ACPI_DPTF is not set=0A=
# CONFIG_ACPI_EXTLOG is not set=0A=
# CONFIG_ACPI_CONFIGFS is not set=0A=
# CONFIG_ACPI_PFRUT is not set=0A=
CONFIG_ACPI_PCC=3Dy=0A=
# CONFIG_ACPI_FFH is not set=0A=
CONFIG_PMIC_OPREGION=3Dy=0A=
CONFIG_BXT_WC_PMIC_OPREGION=3Dy=0A=
# CONFIG_CHT_WC_PMIC_OPREGION is not set=0A=
CONFIG_X86_PM_TIMER=3Dy=0A=
=0A=
#=0A=
# CPU Frequency scaling=0A=
#=0A=
CONFIG_CPU_FREQ=3Dy=0A=
CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy=0A=
CONFIG_CPU_FREQ_GOV_COMMON=3Dy=0A=
# CONFIG_CPU_FREQ_STAT is not set=0A=
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set=0A=
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set=0A=
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy=0A=
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set=0A=
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy=0A=
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set=0A=
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy=0A=
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy=0A=
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set=0A=
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy=0A=
=0A=
#=0A=
# CPU frequency scaling drivers=0A=
#=0A=
# CONFIG_CPUFREQ_DT is not set=0A=
# CONFIG_CPUFREQ_DT_PLATDEV is not set=0A=
CONFIG_X86_INTEL_PSTATE=3Dy=0A=
# CONFIG_X86_PCC_CPUFREQ is not set=0A=
CONFIG_X86_AMD_PSTATE=3Dy=0A=
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3=0A=
# CONFIG_X86_AMD_PSTATE_UT is not set=0A=
CONFIG_X86_ACPI_CPUFREQ=3Dy=0A=
CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy=0A=
# CONFIG_X86_POWERNOW_K8 is not set=0A=
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set=0A=
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set=0A=
# CONFIG_X86_P4_CLOCKMOD is not set=0A=
=0A=
#=0A=
# shared options=0A=
#=0A=
# end of CPU Frequency scaling=0A=
=0A=
#=0A=
# CPU Idle=0A=
#=0A=
CONFIG_CPU_IDLE=3Dy=0A=
# CONFIG_CPU_IDLE_GOV_LADDER is not set=0A=
CONFIG_CPU_IDLE_GOV_MENU=3Dy=0A=
# CONFIG_CPU_IDLE_GOV_TEO is not set=0A=
CONFIG_CPU_IDLE_GOV_HALTPOLL=3Dy=0A=
CONFIG_HALTPOLL_CPUIDLE=3Dy=0A=
# end of CPU Idle=0A=
=0A=
CONFIG_INTEL_IDLE=3Dy=0A=
# end of Power management and ACPI options=0A=
=0A=
#=0A=
# Bus options (PCI etc.)=0A=
#=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_MMCONFIG=3Dy=0A=
CONFIG_MMCONF_FAM10H=3Dy=0A=
# CONFIG_PCI_CNB20LE_QUIRK is not set=0A=
# CONFIG_ISA_BUS is not set=0A=
CONFIG_ISA_DMA_API=3Dy=0A=
CONFIG_AMD_NB=3Dy=0A=
# end of Bus options (PCI etc.)=0A=
=0A=
#=0A=
# Binary Emulations=0A=
#=0A=
CONFIG_IA32_EMULATION=3Dy=0A=
# CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set=0A=
CONFIG_X86_X32_ABI=3Dy=0A=
CONFIG_COMPAT_32=3Dy=0A=
CONFIG_COMPAT=3Dy=0A=
CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy=0A=
# end of Binary Emulations=0A=
=0A=
CONFIG_KVM_COMMON=3Dy=0A=
CONFIG_HAVE_KVM_PFNCACHE=3Dy=0A=
CONFIG_HAVE_KVM_IRQCHIP=3Dy=0A=
CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy=0A=
CONFIG_HAVE_KVM_DIRTY_RING=3Dy=0A=
CONFIG_HAVE_KVM_DIRTY_RING_TSO=3Dy=0A=
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=3Dy=0A=
CONFIG_KVM_MMIO=3Dy=0A=
CONFIG_KVM_ASYNC_PF=3Dy=0A=
CONFIG_HAVE_KVM_MSI=3Dy=0A=
CONFIG_HAVE_KVM_READONLY_MEM=3Dy=0A=
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy=0A=
CONFIG_KVM_VFIO=3Dy=0A=
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy=0A=
CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY=3Dy=0A=
CONFIG_KVM_COMPAT=3Dy=0A=
CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy=0A=
CONFIG_HAVE_KVM_NO_POLL=3Dy=0A=
CONFIG_KVM_XFER_TO_GUEST_WORK=3Dy=0A=
CONFIG_HAVE_KVM_PM_NOTIFIER=3Dy=0A=
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=3Dy=0A=
CONFIG_KVM_GENERIC_MMU_NOTIFIER=3Dy=0A=
CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG=3Dy=0A=
CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES=3Dy=0A=
CONFIG_KVM_PRIVATE_MEM=3Dy=0A=
CONFIG_KVM_GENERIC_PRIVATE_MEM=3Dy=0A=
CONFIG_VIRTUALIZATION=3Dy=0A=
CONFIG_KVM_X86=3Dy=0A=
CONFIG_KVM=3Dy=0A=
CONFIG_KVM_SW_PROTECTED_VM=3Dy=0A=
CONFIG_KVM_INTEL=3Dy=0A=
# CONFIG_KVM_INTEL_PROVE_VE is not set=0A=
CONFIG_X86_SGX_KVM=3Dy=0A=
CONFIG_KVM_AMD=3Dy=0A=
# CONFIG_KVM_SMM is not set=0A=
CONFIG_KVM_HYPERV=3Dy=0A=
CONFIG_KVM_XEN=3Dy=0A=
CONFIG_KVM_PROVE_MMU=3Dy=0A=
CONFIG_KVM_MAX_NR_VCPUS=3D1024=0A=
CONFIG_AS_AVX512=3Dy=0A=
CONFIG_AS_SHA1_NI=3Dy=0A=
CONFIG_AS_SHA256_NI=3Dy=0A=
CONFIG_AS_TPAUSE=3Dy=0A=
CONFIG_AS_GFNI=3Dy=0A=
CONFIG_AS_VAES=3Dy=0A=
CONFIG_AS_VPCLMULQDQ=3Dy=0A=
CONFIG_AS_WRUSS=3Dy=0A=
CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=3Dy=0A=
=0A=
#=0A=
# General architecture-dependent options=0A=
#=0A=
CONFIG_HOTPLUG_SMT=3Dy=0A=
CONFIG_HOTPLUG_CORE_SYNC=3Dy=0A=
CONFIG_HOTPLUG_CORE_SYNC_DEAD=3Dy=0A=
CONFIG_HOTPLUG_CORE_SYNC_FULL=3Dy=0A=
CONFIG_HOTPLUG_SPLIT_STARTUP=3Dy=0A=
CONFIG_HOTPLUG_PARALLEL=3Dy=0A=
CONFIG_GENERIC_ENTRY=3Dy=0A=
# CONFIG_KPROBES is not set=0A=
CONFIG_JUMP_LABEL=3Dy=0A=
# CONFIG_STATIC_KEYS_SELFTEST is not set=0A=
# CONFIG_STATIC_CALL_SELFTEST is not set=0A=
CONFIG_UPROBES=3Dy=0A=
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy=0A=
CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy=0A=
CONFIG_USER_RETURN_NOTIFIER=3Dy=0A=
CONFIG_HAVE_IOREMAP_PROT=3Dy=0A=
CONFIG_HAVE_KPROBES=3Dy=0A=
CONFIG_HAVE_KRETPROBES=3Dy=0A=
CONFIG_HAVE_OPTPROBES=3Dy=0A=
CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy=0A=
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy=0A=
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy=0A=
CONFIG_HAVE_NMI=3Dy=0A=
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy=0A=
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy=0A=
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy=0A=
CONFIG_HAVE_DMA_CONTIGUOUS=3Dy=0A=
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy=0A=
CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy=0A=
CONFIG_ARCH_HAS_SET_MEMORY=3Dy=0A=
CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy=0A=
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=3Dy=0A=
CONFIG_ARCH_HAS_CPU_PASID=3Dy=0A=
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy=0A=
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy=0A=
CONFIG_ARCH_WANTS_NO_INSTR=3Dy=0A=
CONFIG_HAVE_ASM_MODVERSIONS=3Dy=0A=
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy=0A=
CONFIG_HAVE_RSEQ=3Dy=0A=
CONFIG_HAVE_RUST=3Dy=0A=
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy=0A=
CONFIG_HAVE_HW_BREAKPOINT=3Dy=0A=
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy=0A=
CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy=0A=
CONFIG_HAVE_PERF_EVENTS_NMI=3Dy=0A=
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy=0A=
CONFIG_HAVE_PERF_REGS=3Dy=0A=
CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy=0A=
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy=0A=
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy=0A=
CONFIG_MMU_GATHER_TABLE_FREE=3Dy=0A=
CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy=0A=
CONFIG_MMU_GATHER_MERGE_VMAS=3Dy=0A=
CONFIG_MMU_LAZY_TLB_REFCOUNT=3Dy=0A=
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy=0A=
CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=3Dy=0A=
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=3Dy=0A=
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy=0A=
CONFIG_HAVE_CMPXCHG_LOCAL=3Dy=0A=
CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy=0A=
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy=0A=
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy=0A=
CONFIG_HAVE_ARCH_SECCOMP=3Dy=0A=
CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy=0A=
CONFIG_SECCOMP=3Dy=0A=
CONFIG_SECCOMP_FILTER=3Dy=0A=
# CONFIG_SECCOMP_CACHE_DEBUG is not set=0A=
CONFIG_HAVE_ARCH_STACKLEAK=3Dy=0A=
CONFIG_HAVE_STACKPROTECTOR=3Dy=0A=
CONFIG_STACKPROTECTOR=3Dy=0A=
CONFIG_STACKPROTECTOR_STRONG=3Dy=0A=
CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy=0A=
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy=0A=
CONFIG_LTO_NONE=3Dy=0A=
CONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=3Dy=0A=
CONFIG_ARCH_SUPPORTS_PROPELLER_CLANG=3Dy=0A=
CONFIG_ARCH_SUPPORTS_CFI_CLANG=3Dy=0A=
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy=0A=
CONFIG_HAVE_CONTEXT_TRACKING_USER=3Dy=0A=
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=3Dy=0A=
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy=0A=
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy=0A=
CONFIG_HAVE_MOVE_PUD=3Dy=0A=
CONFIG_HAVE_MOVE_PMD=3Dy=0A=
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy=0A=
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy=0A=
CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy=0A=
CONFIG_HAVE_ARCH_HUGE_VMALLOC=3Dy=0A=
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy=0A=
CONFIG_ARCH_WANT_PMD_MKWRITE=3Dy=0A=
CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy=0A=
CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy=0A=
CONFIG_MODULES_USE_ELF_RELA=3Dy=0A=
CONFIG_ARCH_HAS_EXECMEM_ROX=3Dy=0A=
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy=0A=
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy=0A=
CONFIG_SOFTIRQ_ON_OWN_STACK=3Dy=0A=
CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy=0A=
CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy=0A=
CONFIG_HAVE_EXIT_THREAD=3Dy=0A=
CONFIG_ARCH_MMAP_RND_BITS=3D28=0A=
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy=0A=
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8=0A=
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy=0A=
CONFIG_HAVE_PAGE_SIZE_4KB=3Dy=0A=
CONFIG_PAGE_SIZE_4KB=3Dy=0A=
CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy=0A=
CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy=0A=
CONFIG_PAGE_SHIFT=3D12=0A=
CONFIG_HAVE_OBJTOOL=3Dy=0A=
CONFIG_HAVE_JUMP_LABEL_HACK=3Dy=0A=
CONFIG_HAVE_NOINSTR_HACK=3Dy=0A=
CONFIG_HAVE_NOINSTR_VALIDATION=3Dy=0A=
CONFIG_HAVE_UACCESS_VALIDATION=3Dy=0A=
CONFIG_HAVE_STACK_VALIDATION=3Dy=0A=
CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy=0A=
CONFIG_OLD_SIGSUSPEND3=3Dy=0A=
CONFIG_COMPAT_OLD_SIGACTION=3Dy=0A=
CONFIG_COMPAT_32BIT_TIME=3Dy=0A=
CONFIG_ARCH_SUPPORTS_RT=3Dy=0A=
CONFIG_HAVE_ARCH_VMAP_STACK=3Dy=0A=
CONFIG_VMAP_STACK=3Dy=0A=
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy=0A=
CONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy=0A=
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set=0A=
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy=0A=
CONFIG_STRICT_KERNEL_RWX=3Dy=0A=
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy=0A=
CONFIG_STRICT_MODULE_RWX=3Dy=0A=
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy=0A=
# CONFIG_LOCK_EVENT_COUNTS is not set=0A=
CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy=0A=
CONFIG_HAVE_STATIC_CALL=3Dy=0A=
CONFIG_HAVE_STATIC_CALL_INLINE=3Dy=0A=
CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy=0A=
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy=0A=
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy=0A=
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy=0A=
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=3Dy=0A=
CONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy=0A=
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=3Dy=0A=
CONFIG_DYNAMIC_SIGFRAME=3Dy=0A=
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=3Dy=0A=
CONFIG_ARCH_HAS_HW_PTE_YOUNG=3Dy=0A=
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=3Dy=0A=
CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=3Dy=0A=
=0A=
#=0A=
# GCOV-based kernel profiling=0A=
#=0A=
# CONFIG_GCOV_KERNEL is not set=0A=
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy=0A=
# end of GCOV-based kernel profiling=0A=
=0A=
CONFIG_HAVE_GCC_PLUGINS=3Dy=0A=
CONFIG_FUNCTION_ALIGNMENT_4B=3Dy=0A=
CONFIG_FUNCTION_ALIGNMENT_16B=3Dy=0A=
CONFIG_FUNCTION_ALIGNMENT=3D16=0A=
# end of General architecture-dependent options=0A=
=0A=
CONFIG_RT_MUTEXES=3Dy=0A=
CONFIG_MODULE_SIG_FORMAT=3Dy=0A=
CONFIG_MODULES=3Dy=0A=
# CONFIG_MODULE_DEBUG is not set=0A=
# CONFIG_MODULE_FORCE_LOAD is not set=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_ASM_MODVERSIONS=3Dy=0A=
CONFIG_MODULE_SRCVERSION_ALL=3Dy=0A=
CONFIG_MODULE_SIG=3Dy=0A=
# CONFIG_MODULE_SIG_FORCE is not set=0A=
# CONFIG_MODULE_SIG_ALL is not set=0A=
CONFIG_MODULE_SIG_SHA1=3Dy=0A=
# CONFIG_MODULE_SIG_SHA256 is not set=0A=
# CONFIG_MODULE_SIG_SHA384 is not set=0A=
# CONFIG_MODULE_SIG_SHA512 is not set=0A=
# CONFIG_MODULE_SIG_SHA3_256 is not set=0A=
# CONFIG_MODULE_SIG_SHA3_384 is not set=0A=
# CONFIG_MODULE_SIG_SHA3_512 is not set=0A=
CONFIG_MODULE_SIG_HASH=3D"sha1"=0A=
# CONFIG_MODULE_COMPRESS is not set=0A=
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set=0A=
CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"=0A=
# CONFIG_TRIM_UNUSED_KSYMS is not set=0A=
CONFIG_MODULES_TREE_LOOKUP=3Dy=0A=
CONFIG_BLOCK=3Dy=0A=
CONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy=0A=
CONFIG_BLK_RQ_ALLOC_TIME=3Dy=0A=
CONFIG_BLK_CGROUP_RWSTAT=3Dy=0A=
CONFIG_BLK_CGROUP_PUNT_BIO=3Dy=0A=
CONFIG_BLK_DEV_BSG_COMMON=3Dy=0A=
CONFIG_BLK_ICQ=3Dy=0A=
CONFIG_BLK_DEV_BSGLIB=3Dy=0A=
CONFIG_BLK_DEV_INTEGRITY=3Dy=0A=
# CONFIG_BLK_DEV_WRITE_MOUNTED is not set=0A=
CONFIG_BLK_DEV_ZONED=3Dy=0A=
CONFIG_BLK_DEV_THROTTLING=3Dy=0A=
CONFIG_BLK_WBT=3Dy=0A=
CONFIG_BLK_WBT_MQ=3Dy=0A=
CONFIG_BLK_CGROUP_IOLATENCY=3Dy=0A=
# CONFIG_BLK_CGROUP_FC_APPID is not set=0A=
CONFIG_BLK_CGROUP_IOCOST=3Dy=0A=
CONFIG_BLK_CGROUP_IOPRIO=3Dy=0A=
CONFIG_BLK_DEBUG_FS=3Dy=0A=
# CONFIG_BLK_SED_OPAL is not set=0A=
CONFIG_BLK_INLINE_ENCRYPTION=3Dy=0A=
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=3Dy=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
CONFIG_ACORN_PARTITION=3Dy=0A=
CONFIG_ACORN_PARTITION_CUMANA=3Dy=0A=
CONFIG_ACORN_PARTITION_EESOX=3Dy=0A=
CONFIG_ACORN_PARTITION_ICS=3Dy=0A=
CONFIG_ACORN_PARTITION_ADFS=3Dy=0A=
CONFIG_ACORN_PARTITION_POWERTEC=3Dy=0A=
CONFIG_ACORN_PARTITION_RISCIX=3Dy=0A=
CONFIG_AIX_PARTITION=3Dy=0A=
CONFIG_OSF_PARTITION=3Dy=0A=
CONFIG_AMIGA_PARTITION=3Dy=0A=
CONFIG_ATARI_PARTITION=3Dy=0A=
CONFIG_MAC_PARTITION=3Dy=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_BSD_DISKLABEL=3Dy=0A=
CONFIG_MINIX_SUBPARTITION=3Dy=0A=
CONFIG_SOLARIS_X86_PARTITION=3Dy=0A=
CONFIG_UNIXWARE_DISKLABEL=3Dy=0A=
CONFIG_LDM_PARTITION=3Dy=0A=
# CONFIG_LDM_DEBUG is not set=0A=
CONFIG_SGI_PARTITION=3Dy=0A=
CONFIG_ULTRIX_PARTITION=3Dy=0A=
CONFIG_SUN_PARTITION=3Dy=0A=
CONFIG_KARMA_PARTITION=3Dy=0A=
CONFIG_EFI_PARTITION=3Dy=0A=
CONFIG_SYSV68_PARTITION=3Dy=0A=
CONFIG_CMDLINE_PARTITION=3Dy=0A=
# CONFIG_OF_PARTITION is not set=0A=
# end of Partition Types=0A=
=0A=
CONFIG_BLK_MQ_PCI=3Dy=0A=
CONFIG_BLK_MQ_VIRTIO=3Dy=0A=
CONFIG_BLK_PM=3Dy=0A=
CONFIG_BLOCK_HOLDER_DEPRECATED=3Dy=0A=
CONFIG_BLK_MQ_STACKING=3Dy=0A=
=0A=
#=0A=
# IO Schedulers=0A=
#=0A=
CONFIG_MQ_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_MQ_IOSCHED_KYBER=3Dy=0A=
CONFIG_IOSCHED_BFQ=3Dy=0A=
CONFIG_BFQ_GROUP_IOSCHED=3Dy=0A=
CONFIG_BFQ_CGROUP_DEBUG=3Dy=0A=
# end of IO Schedulers=0A=
=0A=
CONFIG_PREEMPT_NOTIFIERS=3Dy=0A=
CONFIG_PADATA=3Dy=0A=
CONFIG_ASN1=3Dy=0A=
CONFIG_UNINLINE_SPIN_UNLOCK=3Dy=0A=
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy=0A=
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy=0A=
CONFIG_RWSEM_SPIN_ON_OWNER=3Dy=0A=
CONFIG_LOCK_SPIN_ON_OWNER=3Dy=0A=
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy=0A=
CONFIG_QUEUED_SPINLOCKS=3Dy=0A=
CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy=0A=
CONFIG_QUEUED_RWLOCKS=3Dy=0A=
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy=0A=
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy=0A=
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy=0A=
CONFIG_FREEZER=3Dy=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_COMPAT_BINFMT_ELF=3Dy=0A=
CONFIG_ELFCORE=3Dy=0A=
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy=0A=
CONFIG_BINFMT_SCRIPT=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
CONFIG_COREDUMP=3Dy=0A=
# end of Executable file formats=0A=
=0A=
#=0A=
# Memory Management options=0A=
#=0A=
CONFIG_ZPOOL=3Dy=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_ZSWAP=3Dy=0A=
CONFIG_ZSWAP_DEFAULT_ON=3Dy=0A=
CONFIG_ZSWAP_SHRINKER_DEFAULT_ON=3Dy=0A=
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set=0A=
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set=0A=
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842=3Dy=0A=
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set=0A=
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set=0A=
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set=0A=
CONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"842"=0A=
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set=0A=
CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED=3Dy=0A=
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set=0A=
CONFIG_ZSWAP_ZPOOL_DEFAULT=3D"z3fold"=0A=
# CONFIG_ZBUD is not set=0A=
CONFIG_Z3FOLD_DEPRECATED=3Dy=0A=
CONFIG_Z3FOLD=3Dy=0A=
CONFIG_ZSMALLOC=3Dy=0A=
# CONFIG_ZSMALLOC_STAT is not set=0A=
CONFIG_ZSMALLOC_CHAIN_SIZE=3D8=0A=
=0A=
#=0A=
# Slab allocator options=0A=
#=0A=
CONFIG_SLUB=3Dy=0A=
# CONFIG_SLUB_TINY is not set=0A=
CONFIG_SLAB_MERGE_DEFAULT=3Dy=0A=
# CONFIG_SLAB_FREELIST_RANDOM is not set=0A=
# CONFIG_SLAB_FREELIST_HARDENED is not set=0A=
# CONFIG_SLAB_BUCKETS is not set=0A=
# CONFIG_SLUB_STATS is not set=0A=
CONFIG_SLUB_CPU_PARTIAL=3Dy=0A=
# CONFIG_RANDOM_KMALLOC_CACHES is not set=0A=
# end of Slab allocator options=0A=
=0A=
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set=0A=
# CONFIG_COMPAT_BRK is not set=0A=
CONFIG_SPARSEMEM=3Dy=0A=
CONFIG_SPARSEMEM_EXTREME=3Dy=0A=
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy=0A=
CONFIG_SPARSEMEM_VMEMMAP=3Dy=0A=
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=3Dy=0A=
CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=3Dy=0A=
CONFIG_HAVE_GUP_FAST=3Dy=0A=
CONFIG_NUMA_KEEP_MEMINFO=3Dy=0A=
CONFIG_MEMORY_ISOLATION=3Dy=0A=
CONFIG_EXCLUSIVE_SYSTEM_RAM=3Dy=0A=
CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy=0A=
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy=0A=
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy=0A=
CONFIG_MEMORY_HOTPLUG=3Dy=0A=
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy=0A=
CONFIG_MEMORY_HOTREMOVE=3Dy=0A=
CONFIG_MHP_MEMMAP_ON_MEMORY=3Dy=0A=
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy=0A=
CONFIG_SPLIT_PTE_PTLOCKS=3Dy=0A=
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy=0A=
CONFIG_SPLIT_PMD_PTLOCKS=3Dy=0A=
CONFIG_MEMORY_BALLOON=3Dy=0A=
# CONFIG_BALLOON_COMPACTION is not set=0A=
CONFIG_COMPACTION=3Dy=0A=
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=3D1=0A=
CONFIG_PAGE_REPORTING=3Dy=0A=
CONFIG_MIGRATION=3Dy=0A=
CONFIG_DEVICE_MIGRATION=3Dy=0A=
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy=0A=
CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy=0A=
CONFIG_CONTIG_ALLOC=3Dy=0A=
CONFIG_PCP_BATCH_SCALE_MAX=3D5=0A=
CONFIG_PHYS_ADDR_T_64BIT=3Dy=0A=
CONFIG_MMU_NOTIFIER=3Dy=0A=
CONFIG_KSM=3Dy=0A=
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096=0A=
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy=0A=
# CONFIG_MEMORY_FAILURE is not set=0A=
CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy=0A=
CONFIG_ARCH_WANTS_THP_SWAP=3Dy=0A=
CONFIG_TRANSPARENT_HUGEPAGE=3Dy=0A=
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set=0A=
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy=0A=
# CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set=0A=
CONFIG_THP_SWAP=3Dy=0A=
CONFIG_READ_ONLY_THP_FOR_FS=3Dy=0A=
CONFIG_PGTABLE_HAS_HUGE_LEAVES=3Dy=0A=
CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP=3Dy=0A=
CONFIG_ARCH_SUPPORTS_PMD_PFNMAP=3Dy=0A=
CONFIG_ARCH_SUPPORTS_PUD_PFNMAP=3Dy=0A=
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy=0A=
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy=0A=
CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy=0A=
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy=0A=
CONFIG_CMA=3Dy=0A=
# CONFIG_CMA_DEBUGFS is not set=0A=
# CONFIG_CMA_SYSFS is not set=0A=
CONFIG_CMA_AREAS=3D20=0A=
CONFIG_MEM_SOFT_DIRTY=3Dy=0A=
CONFIG_GENERIC_EARLY_IOREMAP=3Dy=0A=
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set=0A=
CONFIG_PAGE_IDLE_FLAG=3Dy=0A=
# CONFIG_IDLE_PAGE_TRACKING is not set=0A=
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy=0A=
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy=0A=
CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy=0A=
CONFIG_ARCH_HAS_ZONE_DMA_SET=3Dy=0A=
CONFIG_ZONE_DMA=3Dy=0A=
CONFIG_ZONE_DMA32=3Dy=0A=
CONFIG_ZONE_DEVICE=3Dy=0A=
CONFIG_HMM_MIRROR=3Dy=0A=
CONFIG_GET_FREE_REGION=3Dy=0A=
CONFIG_DEVICE_PRIVATE=3Dy=0A=
CONFIG_VMAP_PFN=3Dy=0A=
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy=0A=
CONFIG_ARCH_HAS_PKEYS=3Dy=0A=
CONFIG_ARCH_USES_PG_ARCH_2=3Dy=0A=
CONFIG_VM_EVENT_COUNTERS=3Dy=0A=
CONFIG_PERCPU_STATS=3Dy=0A=
# CONFIG_GUP_TEST is not set=0A=
# CONFIG_DMAPOOL_TEST is not set=0A=
CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy=0A=
CONFIG_MAPPING_DIRTY_HELPERS=3Dy=0A=
CONFIG_KMAP_LOCAL=3Dy=0A=
CONFIG_MEMFD_CREATE=3Dy=0A=
CONFIG_SECRETMEM=3Dy=0A=
CONFIG_ANON_VMA_NAME=3Dy=0A=
CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy=0A=
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy=0A=
CONFIG_USERFAULTFD=3Dy=0A=
# CONFIG_PTE_MARKER_UFFD_WP is not set=0A=
CONFIG_LRU_GEN=3Dy=0A=
CONFIG_LRU_GEN_ENABLED=3Dy=0A=
# CONFIG_LRU_GEN_STATS is not set=0A=
CONFIG_LRU_GEN_WALKS_MMU=3Dy=0A=
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=3Dy=0A=
CONFIG_PER_VMA_LOCK=3Dy=0A=
CONFIG_LOCK_MM_AND_FIND_VMA=3Dy=0A=
CONFIG_IOMMU_MM_DATA=3Dy=0A=
CONFIG_EXECMEM=3Dy=0A=
CONFIG_NUMA_MEMBLKS=3Dy=0A=
CONFIG_NUMA_EMU=3Dy=0A=
CONFIG_ARCH_HAS_USER_SHADOW_STACK=3Dy=0A=
=0A=
#=0A=
# Data Access Monitoring=0A=
#=0A=
CONFIG_DAMON=3Dy=0A=
CONFIG_DAMON_VADDR=3Dy=0A=
CONFIG_DAMON_PADDR=3Dy=0A=
# CONFIG_DAMON_SYSFS is not set=0A=
# CONFIG_DAMON_DBGFS_DEPRECATED is not set=0A=
CONFIG_DAMON_RECLAIM=3Dy=0A=
# CONFIG_DAMON_LRU_SORT is not set=0A=
# end of Data Access Monitoring=0A=
# end of Memory Management options=0A=
=0A=
CONFIG_NET=3Dy=0A=
CONFIG_WANT_COMPAT_NETLINK_MESSAGES=3Dy=0A=
CONFIG_COMPAT_NETLINK_MESSAGES=3Dy=0A=
CONFIG_NET_INGRESS=3Dy=0A=
CONFIG_NET_EGRESS=3Dy=0A=
CONFIG_NET_XGRESS=3Dy=0A=
CONFIG_NET_REDIRECT=3Dy=0A=
CONFIG_SKB_DECRYPTED=3Dy=0A=
CONFIG_SKB_EXTENSIONS=3Dy=0A=
CONFIG_NET_DEVMEM=3Dy=0A=
CONFIG_NET_SHAPER=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_PACKET_DIAG=3Dy=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_AF_UNIX_OOB=3Dy=0A=
CONFIG_UNIX_DIAG=3Dy=0A=
CONFIG_TLS=3Dy=0A=
CONFIG_TLS_DEVICE=3Dy=0A=
CONFIG_TLS_TOE=3Dy=0A=
CONFIG_XFRM=3Dy=0A=
CONFIG_XFRM_OFFLOAD=3Dy=0A=
CONFIG_XFRM_ALGO=3Dy=0A=
CONFIG_XFRM_USER=3Dy=0A=
CONFIG_XFRM_USER_COMPAT=3Dy=0A=
CONFIG_XFRM_INTERFACE=3Dy=0A=
CONFIG_XFRM_SUB_POLICY=3Dy=0A=
CONFIG_XFRM_MIGRATE=3Dy=0A=
CONFIG_XFRM_STATISTICS=3Dy=0A=
CONFIG_XFRM_AH=3Dy=0A=
CONFIG_XFRM_ESP=3Dy=0A=
CONFIG_XFRM_IPCOMP=3Dy=0A=
CONFIG_NET_KEY=3Dy=0A=
CONFIG_NET_KEY_MIGRATE=3Dy=0A=
CONFIG_XFRM_ESPINTCP=3Dy=0A=
CONFIG_SMC=3Dy=0A=
CONFIG_SMC_DIAG=3Dy=0A=
# CONFIG_SMC_LO is not set=0A=
CONFIG_XDP_SOCKETS=3Dy=0A=
CONFIG_XDP_SOCKETS_DIAG=3Dy=0A=
CONFIG_NET_HANDSHAKE=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
CONFIG_IP_ADVANCED_ROUTER=3Dy=0A=
CONFIG_IP_FIB_TRIE_STATS=3Dy=0A=
CONFIG_IP_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IP_ROUTE_MULTIPATH=3Dy=0A=
CONFIG_IP_ROUTE_VERBOSE=3Dy=0A=
CONFIG_IP_ROUTE_CLASSID=3Dy=0A=
CONFIG_IP_PNP=3Dy=0A=
CONFIG_IP_PNP_DHCP=3Dy=0A=
CONFIG_IP_PNP_BOOTP=3Dy=0A=
CONFIG_IP_PNP_RARP=3Dy=0A=
CONFIG_NET_IPIP=3Dy=0A=
CONFIG_NET_IPGRE_DEMUX=3Dy=0A=
CONFIG_NET_IP_TUNNEL=3Dy=0A=
CONFIG_NET_IPGRE=3Dy=0A=
CONFIG_NET_IPGRE_BROADCAST=3Dy=0A=
CONFIG_IP_MROUTE_COMMON=3Dy=0A=
CONFIG_IP_MROUTE=3Dy=0A=
CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IP_PIMSM_V1=3Dy=0A=
CONFIG_IP_PIMSM_V2=3Dy=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
CONFIG_NET_IPVTI=3Dy=0A=
CONFIG_NET_UDP_TUNNEL=3Dy=0A=
CONFIG_NET_FOU=3Dy=0A=
CONFIG_NET_FOU_IP_TUNNELS=3Dy=0A=
CONFIG_INET_AH=3Dy=0A=
CONFIG_INET_ESP=3Dy=0A=
CONFIG_INET_ESP_OFFLOAD=3Dy=0A=
CONFIG_INET_ESPINTCP=3Dy=0A=
CONFIG_INET_IPCOMP=3Dy=0A=
CONFIG_INET_TABLE_PERTURB_ORDER=3D16=0A=
CONFIG_INET_XFRM_TUNNEL=3Dy=0A=
CONFIG_INET_TUNNEL=3Dy=0A=
CONFIG_INET_DIAG=3Dy=0A=
CONFIG_INET_TCP_DIAG=3Dy=0A=
CONFIG_INET_UDP_DIAG=3Dy=0A=
CONFIG_INET_RAW_DIAG=3Dy=0A=
CONFIG_INET_DIAG_DESTROY=3Dy=0A=
CONFIG_TCP_CONG_ADVANCED=3Dy=0A=
CONFIG_TCP_CONG_BIC=3Dy=0A=
CONFIG_TCP_CONG_CUBIC=3Dy=0A=
CONFIG_TCP_CONG_WESTWOOD=3Dy=0A=
CONFIG_TCP_CONG_HTCP=3Dy=0A=
CONFIG_TCP_CONG_HSTCP=3Dy=0A=
CONFIG_TCP_CONG_HYBLA=3Dy=0A=
CONFIG_TCP_CONG_VEGAS=3Dy=0A=
CONFIG_TCP_CONG_NV=3Dy=0A=
CONFIG_TCP_CONG_SCALABLE=3Dy=0A=
CONFIG_TCP_CONG_LP=3Dy=0A=
CONFIG_TCP_CONG_VENO=3Dy=0A=
CONFIG_TCP_CONG_YEAH=3Dy=0A=
CONFIG_TCP_CONG_ILLINOIS=3Dy=0A=
CONFIG_TCP_CONG_DCTCP=3Dy=0A=
CONFIG_TCP_CONG_CDG=3Dy=0A=
CONFIG_TCP_CONG_BBR=3Dy=0A=
# CONFIG_DEFAULT_BIC is not set=0A=
CONFIG_DEFAULT_CUBIC=3Dy=0A=
# CONFIG_DEFAULT_HTCP is not set=0A=
# CONFIG_DEFAULT_HYBLA is not set=0A=
# CONFIG_DEFAULT_VEGAS is not set=0A=
# CONFIG_DEFAULT_VENO is not set=0A=
# CONFIG_DEFAULT_WESTWOOD is not set=0A=
# CONFIG_DEFAULT_DCTCP is not set=0A=
# CONFIG_DEFAULT_CDG is not set=0A=
# CONFIG_DEFAULT_BBR is not set=0A=
# CONFIG_DEFAULT_RENO is not set=0A=
CONFIG_DEFAULT_TCP_CONG=3D"cubic"=0A=
CONFIG_TCP_SIGPOOL=3Dy=0A=
# CONFIG_TCP_AO is not set=0A=
CONFIG_TCP_MD5SIG=3Dy=0A=
CONFIG_IPV6=3Dy=0A=
CONFIG_IPV6_ROUTER_PREF=3Dy=0A=
CONFIG_IPV6_ROUTE_INFO=3Dy=0A=
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy=0A=
CONFIG_INET6_AH=3Dy=0A=
CONFIG_INET6_ESP=3Dy=0A=
CONFIG_INET6_ESP_OFFLOAD=3Dy=0A=
CONFIG_INET6_ESPINTCP=3Dy=0A=
CONFIG_INET6_IPCOMP=3Dy=0A=
CONFIG_IPV6_MIP6=3Dy=0A=
CONFIG_IPV6_ILA=3Dy=0A=
CONFIG_INET6_XFRM_TUNNEL=3Dy=0A=
CONFIG_INET6_TUNNEL=3Dy=0A=
CONFIG_IPV6_VTI=3Dy=0A=
CONFIG_IPV6_SIT=3Dy=0A=
CONFIG_IPV6_SIT_6RD=3Dy=0A=
CONFIG_IPV6_NDISC_NODETYPE=3Dy=0A=
CONFIG_IPV6_TUNNEL=3Dy=0A=
CONFIG_IPV6_GRE=3Dy=0A=
CONFIG_IPV6_FOU=3Dy=0A=
CONFIG_IPV6_FOU_TUNNEL=3Dy=0A=
CONFIG_IPV6_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IPV6_SUBTREES=3Dy=0A=
CONFIG_IPV6_MROUTE=3Dy=0A=
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IPV6_PIMSM_V2=3Dy=0A=
CONFIG_IPV6_SEG6_LWTUNNEL=3Dy=0A=
CONFIG_IPV6_SEG6_HMAC=3Dy=0A=
CONFIG_IPV6_SEG6_BPF=3Dy=0A=
CONFIG_IPV6_RPL_LWTUNNEL=3Dy=0A=
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set=0A=
CONFIG_NETLABEL=3Dy=0A=
CONFIG_MPTCP=3Dy=0A=
CONFIG_INET_MPTCP_DIAG=3Dy=0A=
CONFIG_MPTCP_IPV6=3Dy=0A=
CONFIG_NETWORK_SECMARK=3Dy=0A=
CONFIG_NET_PTP_CLASSIFY=3Dy=0A=
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
CONFIG_NETFILTER_ADVANCED=3Dy=0A=
CONFIG_BRIDGE_NETFILTER=3Dy=0A=
=0A=
#=0A=
# Core Netfilter Configuration=0A=
#=0A=
CONFIG_NETFILTER_INGRESS=3Dy=0A=
CONFIG_NETFILTER_EGRESS=3Dy=0A=
CONFIG_NETFILTER_SKIP_EGRESS=3Dy=0A=
CONFIG_NETFILTER_NETLINK=3Dy=0A=
CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy=0A=
CONFIG_NETFILTER_FAMILY_ARP=3Dy=0A=
CONFIG_NETFILTER_BPF_LINK=3Dy=0A=
# CONFIG_NETFILTER_NETLINK_HOOK is not set=0A=
CONFIG_NETFILTER_NETLINK_ACCT=3Dy=0A=
CONFIG_NETFILTER_NETLINK_QUEUE=3Dy=0A=
CONFIG_NETFILTER_NETLINK_LOG=3Dy=0A=
CONFIG_NETFILTER_NETLINK_OSF=3Dy=0A=
CONFIG_NF_CONNTRACK=3Dy=0A=
CONFIG_NF_LOG_SYSLOG=3Dy=0A=
CONFIG_NETFILTER_CONNCOUNT=3Dy=0A=
CONFIG_NF_CONNTRACK_MARK=3Dy=0A=
CONFIG_NF_CONNTRACK_SECMARK=3Dy=0A=
CONFIG_NF_CONNTRACK_ZONES=3Dy=0A=
# CONFIG_NF_CONNTRACK_PROCFS is not set=0A=
CONFIG_NF_CONNTRACK_EVENTS=3Dy=0A=
CONFIG_NF_CONNTRACK_TIMEOUT=3Dy=0A=
CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy=0A=
CONFIG_NF_CONNTRACK_LABELS=3Dy=0A=
CONFIG_NF_CONNTRACK_OVS=3Dy=0A=
CONFIG_NF_CT_PROTO_DCCP=3Dy=0A=
CONFIG_NF_CT_PROTO_GRE=3Dy=0A=
CONFIG_NF_CT_PROTO_SCTP=3Dy=0A=
CONFIG_NF_CT_PROTO_UDPLITE=3Dy=0A=
CONFIG_NF_CONNTRACK_AMANDA=3Dy=0A=
CONFIG_NF_CONNTRACK_FTP=3Dy=0A=
CONFIG_NF_CONNTRACK_H323=3Dy=0A=
CONFIG_NF_CONNTRACK_IRC=3Dy=0A=
CONFIG_NF_CONNTRACK_BROADCAST=3Dy=0A=
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dy=0A=
CONFIG_NF_CONNTRACK_SNMP=3Dy=0A=
CONFIG_NF_CONNTRACK_PPTP=3Dy=0A=
CONFIG_NF_CONNTRACK_SANE=3Dy=0A=
CONFIG_NF_CONNTRACK_SIP=3Dy=0A=
CONFIG_NF_CONNTRACK_TFTP=3Dy=0A=
CONFIG_NF_CT_NETLINK=3Dy=0A=
CONFIG_NF_CT_NETLINK_TIMEOUT=3Dy=0A=
CONFIG_NF_CT_NETLINK_HELPER=3Dy=0A=
CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy=0A=
CONFIG_NF_NAT=3Dy=0A=
CONFIG_NF_NAT_AMANDA=3Dy=0A=
CONFIG_NF_NAT_FTP=3Dy=0A=
CONFIG_NF_NAT_IRC=3Dy=0A=
CONFIG_NF_NAT_SIP=3Dy=0A=
CONFIG_NF_NAT_TFTP=3Dy=0A=
CONFIG_NF_NAT_REDIRECT=3Dy=0A=
CONFIG_NF_NAT_MASQUERADE=3Dy=0A=
CONFIG_NF_NAT_OVS=3Dy=0A=
CONFIG_NETFILTER_SYNPROXY=3Dy=0A=
CONFIG_NF_TABLES=3Dy=0A=
CONFIG_NF_TABLES_INET=3Dy=0A=
CONFIG_NF_TABLES_NETDEV=3Dy=0A=
CONFIG_NFT_NUMGEN=3Dy=0A=
CONFIG_NFT_CT=3Dy=0A=
CONFIG_NFT_FLOW_OFFLOAD=3Dy=0A=
CONFIG_NFT_CONNLIMIT=3Dy=0A=
CONFIG_NFT_LOG=3Dy=0A=
CONFIG_NFT_LIMIT=3Dy=0A=
CONFIG_NFT_MASQ=3Dy=0A=
CONFIG_NFT_REDIR=3Dy=0A=
CONFIG_NFT_NAT=3Dy=0A=
CONFIG_NFT_TUNNEL=3Dy=0A=
CONFIG_NFT_QUEUE=3Dy=0A=
CONFIG_NFT_QUOTA=3Dy=0A=
CONFIG_NFT_REJECT=3Dy=0A=
CONFIG_NFT_REJECT_INET=3Dy=0A=
CONFIG_NFT_COMPAT=3Dy=0A=
CONFIG_NFT_HASH=3Dy=0A=
CONFIG_NFT_FIB=3Dy=0A=
CONFIG_NFT_FIB_INET=3Dy=0A=
CONFIG_NFT_XFRM=3Dy=0A=
CONFIG_NFT_SOCKET=3Dy=0A=
CONFIG_NFT_OSF=3Dy=0A=
CONFIG_NFT_TPROXY=3Dy=0A=
CONFIG_NFT_SYNPROXY=3Dy=0A=
CONFIG_NF_DUP_NETDEV=3Dy=0A=
CONFIG_NFT_DUP_NETDEV=3Dy=0A=
CONFIG_NFT_FWD_NETDEV=3Dy=0A=
CONFIG_NFT_FIB_NETDEV=3Dy=0A=
CONFIG_NFT_REJECT_NETDEV=3Dy=0A=
CONFIG_NF_FLOW_TABLE_INET=3Dy=0A=
CONFIG_NF_FLOW_TABLE=3Dy=0A=
# CONFIG_NF_FLOW_TABLE_PROCFS is not set=0A=
CONFIG_NETFILTER_XTABLES=3Dy=0A=
CONFIG_NETFILTER_XTABLES_COMPAT=3Dy=0A=
=0A=
#=0A=
# Xtables combined modules=0A=
#=0A=
CONFIG_NETFILTER_XT_MARK=3Dy=0A=
CONFIG_NETFILTER_XT_CONNMARK=3Dy=0A=
CONFIG_NETFILTER_XT_SET=3Dy=0A=
=0A=
#=0A=
# Xtables targets=0A=
#=0A=
CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_CT=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_HL=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_HMARK=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_LED=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_LOG=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_MARK=3Dy=0A=
CONFIG_NETFILTER_XT_NAT=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_TEE=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy=0A=
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dy=0A=
=0A=
#=0A=
# Xtables matches=0A=
#=0A=
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_BPF=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_CPU=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_ECN=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_ESP=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_HL=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_IPCOMP=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_IPVS=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_L2TP=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_MAC=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_MARK=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_NFACCT=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_OSF=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_REALM=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_STATE=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_STRING=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_TIME=3Dy=0A=
CONFIG_NETFILTER_XT_MATCH_U32=3Dy=0A=
# end of Core Netfilter Configuration=0A=
=0A=
CONFIG_IP_SET=3Dy=0A=
CONFIG_IP_SET_MAX=3D256=0A=
CONFIG_IP_SET_BITMAP_IP=3Dy=0A=
CONFIG_IP_SET_BITMAP_IPMAC=3Dy=0A=
CONFIG_IP_SET_BITMAP_PORT=3Dy=0A=
CONFIG_IP_SET_HASH_IP=3Dy=0A=
CONFIG_IP_SET_HASH_IPMARK=3Dy=0A=
CONFIG_IP_SET_HASH_IPPORT=3Dy=0A=
CONFIG_IP_SET_HASH_IPPORTIP=3Dy=0A=
CONFIG_IP_SET_HASH_IPPORTNET=3Dy=0A=
CONFIG_IP_SET_HASH_IPMAC=3Dy=0A=
CONFIG_IP_SET_HASH_MAC=3Dy=0A=
CONFIG_IP_SET_HASH_NETPORTNET=3Dy=0A=
CONFIG_IP_SET_HASH_NET=3Dy=0A=
CONFIG_IP_SET_HASH_NETNET=3Dy=0A=
CONFIG_IP_SET_HASH_NETPORT=3Dy=0A=
CONFIG_IP_SET_HASH_NETIFACE=3Dy=0A=
CONFIG_IP_SET_LIST_SET=3Dy=0A=
CONFIG_IP_VS=3Dy=0A=
CONFIG_IP_VS_IPV6=3Dy=0A=
# CONFIG_IP_VS_DEBUG is not set=0A=
CONFIG_IP_VS_TAB_BITS=3D12=0A=
=0A=
#=0A=
# IPVS transport protocol load balancing support=0A=
#=0A=
CONFIG_IP_VS_PROTO_TCP=3Dy=0A=
CONFIG_IP_VS_PROTO_UDP=3Dy=0A=
CONFIG_IP_VS_PROTO_AH_ESP=3Dy=0A=
CONFIG_IP_VS_PROTO_ESP=3Dy=0A=
CONFIG_IP_VS_PROTO_AH=3Dy=0A=
CONFIG_IP_VS_PROTO_SCTP=3Dy=0A=
=0A=
#=0A=
# IPVS scheduler=0A=
#=0A=
CONFIG_IP_VS_RR=3Dy=0A=
CONFIG_IP_VS_WRR=3Dy=0A=
CONFIG_IP_VS_LC=3Dy=0A=
CONFIG_IP_VS_WLC=3Dy=0A=
CONFIG_IP_VS_FO=3Dy=0A=
CONFIG_IP_VS_OVF=3Dy=0A=
CONFIG_IP_VS_LBLC=3Dy=0A=
CONFIG_IP_VS_LBLCR=3Dy=0A=
CONFIG_IP_VS_DH=3Dy=0A=
CONFIG_IP_VS_SH=3Dy=0A=
CONFIG_IP_VS_MH=3Dy=0A=
CONFIG_IP_VS_SED=3Dy=0A=
CONFIG_IP_VS_NQ=3Dy=0A=
CONFIG_IP_VS_TWOS=3Dy=0A=
=0A=
#=0A=
# IPVS SH scheduler=0A=
#=0A=
CONFIG_IP_VS_SH_TAB_BITS=3D8=0A=
=0A=
#=0A=
# IPVS MH scheduler=0A=
#=0A=
CONFIG_IP_VS_MH_TAB_INDEX=3D12=0A=
=0A=
#=0A=
# IPVS application helper=0A=
#=0A=
CONFIG_IP_VS_FTP=3Dy=0A=
CONFIG_IP_VS_NFCT=3Dy=0A=
CONFIG_IP_VS_PE_SIP=3Dy=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
CONFIG_NF_DEFRAG_IPV4=3Dy=0A=
CONFIG_IP_NF_IPTABLES_LEGACY=3Dy=0A=
CONFIG_NF_SOCKET_IPV4=3Dy=0A=
CONFIG_NF_TPROXY_IPV4=3Dy=0A=
CONFIG_NF_TABLES_IPV4=3Dy=0A=
CONFIG_NFT_REJECT_IPV4=3Dy=0A=
CONFIG_NFT_DUP_IPV4=3Dy=0A=
CONFIG_NFT_FIB_IPV4=3Dy=0A=
CONFIG_NF_TABLES_ARP=3Dy=0A=
CONFIG_NF_DUP_IPV4=3Dy=0A=
CONFIG_NF_LOG_ARP=3Dy=0A=
CONFIG_NF_LOG_IPV4=3Dy=0A=
CONFIG_NF_REJECT_IPV4=3Dy=0A=
CONFIG_NF_NAT_SNMP_BASIC=3Dy=0A=
CONFIG_NF_NAT_PPTP=3Dy=0A=
CONFIG_NF_NAT_H323=3Dy=0A=
CONFIG_IP_NF_IPTABLES=3Dy=0A=
CONFIG_IP_NF_MATCH_AH=3Dy=0A=
CONFIG_IP_NF_MATCH_ECN=3Dy=0A=
CONFIG_IP_NF_MATCH_RPFILTER=3Dy=0A=
CONFIG_IP_NF_MATCH_TTL=3Dy=0A=
CONFIG_IP_NF_FILTER=3Dy=0A=
CONFIG_IP_NF_TARGET_REJECT=3Dy=0A=
CONFIG_IP_NF_TARGET_SYNPROXY=3Dy=0A=
CONFIG_IP_NF_NAT=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy=0A=
CONFIG_IP_NF_TARGET_NETMAP=3Dy=0A=
CONFIG_IP_NF_TARGET_REDIRECT=3Dy=0A=
CONFIG_IP_NF_MANGLE=3Dy=0A=
CONFIG_IP_NF_TARGET_ECN=3Dy=0A=
CONFIG_IP_NF_TARGET_TTL=3Dy=0A=
CONFIG_IP_NF_RAW=3Dy=0A=
CONFIG_IP_NF_SECURITY=3Dy=0A=
CONFIG_IP_NF_ARPTABLES=3Dy=0A=
CONFIG_NFT_COMPAT_ARP=3Dy=0A=
CONFIG_IP_NF_ARPFILTER=3Dy=0A=
CONFIG_IP_NF_ARP_MANGLE=3Dy=0A=
# end of IP: Netfilter Configuration=0A=
=0A=
#=0A=
# IPv6: Netfilter Configuration=0A=
#=0A=
CONFIG_IP6_NF_IPTABLES_LEGACY=3Dy=0A=
CONFIG_NF_SOCKET_IPV6=3Dy=0A=
CONFIG_NF_TPROXY_IPV6=3Dy=0A=
CONFIG_NF_TABLES_IPV6=3Dy=0A=
CONFIG_NFT_REJECT_IPV6=3Dy=0A=
CONFIG_NFT_DUP_IPV6=3Dy=0A=
CONFIG_NFT_FIB_IPV6=3Dy=0A=
CONFIG_NF_DUP_IPV6=3Dy=0A=
CONFIG_NF_REJECT_IPV6=3Dy=0A=
CONFIG_NF_LOG_IPV6=3Dy=0A=
CONFIG_IP6_NF_IPTABLES=3Dy=0A=
CONFIG_IP6_NF_MATCH_AH=3Dy=0A=
CONFIG_IP6_NF_MATCH_EUI64=3Dy=0A=
CONFIG_IP6_NF_MATCH_FRAG=3Dy=0A=
CONFIG_IP6_NF_MATCH_OPTS=3Dy=0A=
CONFIG_IP6_NF_MATCH_HL=3Dy=0A=
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dy=0A=
CONFIG_IP6_NF_MATCH_MH=3Dy=0A=
CONFIG_IP6_NF_MATCH_RPFILTER=3Dy=0A=
CONFIG_IP6_NF_MATCH_RT=3Dy=0A=
CONFIG_IP6_NF_MATCH_SRH=3Dy=0A=
CONFIG_IP6_NF_TARGET_HL=3Dy=0A=
CONFIG_IP6_NF_FILTER=3Dy=0A=
CONFIG_IP6_NF_TARGET_REJECT=3Dy=0A=
CONFIG_IP6_NF_TARGET_SYNPROXY=3Dy=0A=
CONFIG_IP6_NF_MANGLE=3Dy=0A=
CONFIG_IP6_NF_RAW=3Dy=0A=
CONFIG_IP6_NF_SECURITY=3Dy=0A=
CONFIG_IP6_NF_NAT=3Dy=0A=
CONFIG_IP6_NF_TARGET_MASQUERADE=3Dy=0A=
CONFIG_IP6_NF_TARGET_NPT=3Dy=0A=
# end of IPv6: Netfilter Configuration=0A=
=0A=
CONFIG_NF_DEFRAG_IPV6=3Dy=0A=
CONFIG_NF_TABLES_BRIDGE=3Dy=0A=
CONFIG_NFT_BRIDGE_META=3Dy=0A=
CONFIG_NFT_BRIDGE_REJECT=3Dy=0A=
CONFIG_NF_CONNTRACK_BRIDGE=3Dy=0A=
CONFIG_BRIDGE_NF_EBTABLES_LEGACY=3Dy=0A=
CONFIG_BRIDGE_NF_EBTABLES=3Dy=0A=
CONFIG_BRIDGE_EBT_BROUTE=3Dy=0A=
CONFIG_BRIDGE_EBT_T_FILTER=3Dy=0A=
CONFIG_BRIDGE_EBT_T_NAT=3Dy=0A=
CONFIG_BRIDGE_EBT_802_3=3Dy=0A=
CONFIG_BRIDGE_EBT_AMONG=3Dy=0A=
CONFIG_BRIDGE_EBT_ARP=3Dy=0A=
CONFIG_BRIDGE_EBT_IP=3Dy=0A=
CONFIG_BRIDGE_EBT_IP6=3Dy=0A=
CONFIG_BRIDGE_EBT_LIMIT=3Dy=0A=
CONFIG_BRIDGE_EBT_MARK=3Dy=0A=
CONFIG_BRIDGE_EBT_PKTTYPE=3Dy=0A=
CONFIG_BRIDGE_EBT_STP=3Dy=0A=
CONFIG_BRIDGE_EBT_VLAN=3Dy=0A=
CONFIG_BRIDGE_EBT_ARPREPLY=3Dy=0A=
CONFIG_BRIDGE_EBT_DNAT=3Dy=0A=
CONFIG_BRIDGE_EBT_MARK_T=3Dy=0A=
CONFIG_BRIDGE_EBT_REDIRECT=3Dy=0A=
CONFIG_BRIDGE_EBT_SNAT=3Dy=0A=
CONFIG_BRIDGE_EBT_LOG=3Dy=0A=
CONFIG_BRIDGE_EBT_NFLOG=3Dy=0A=
CONFIG_IP_DCCP=3Dy=0A=
CONFIG_INET_DCCP_DIAG=3Dy=0A=
=0A=
#=0A=
# DCCP CCIDs Configuration=0A=
#=0A=
# CONFIG_IP_DCCP_CCID2_DEBUG is not set=0A=
CONFIG_IP_DCCP_CCID3=3Dy=0A=
# CONFIG_IP_DCCP_CCID3_DEBUG is not set=0A=
CONFIG_IP_DCCP_TFRC_LIB=3Dy=0A=
# end of DCCP CCIDs Configuration=0A=
=0A=
#=0A=
# DCCP Kernel Hacking=0A=
#=0A=
# CONFIG_IP_DCCP_DEBUG is not set=0A=
# end of DCCP Kernel Hacking=0A=
=0A=
CONFIG_IP_SCTP=3Dy=0A=
# CONFIG_SCTP_DBG_OBJCNT is not set=0A=
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=3Dy=0A=
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set=0A=
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set=0A=
CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy=0A=
CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy=0A=
CONFIG_INET_SCTP_DIAG=3Dy=0A=
CONFIG_RDS=3Dy=0A=
CONFIG_RDS_RDMA=3Dy=0A=
CONFIG_RDS_TCP=3Dy=0A=
# CONFIG_RDS_DEBUG is not set=0A=
CONFIG_TIPC=3Dy=0A=
CONFIG_TIPC_MEDIA_IB=3Dy=0A=
CONFIG_TIPC_MEDIA_UDP=3Dy=0A=
CONFIG_TIPC_CRYPTO=3Dy=0A=
CONFIG_TIPC_DIAG=3Dy=0A=
CONFIG_ATM=3Dy=0A=
CONFIG_ATM_CLIP=3Dy=0A=
# CONFIG_ATM_CLIP_NO_ICMP is not set=0A=
CONFIG_ATM_LANE=3Dy=0A=
CONFIG_ATM_MPOA=3Dy=0A=
CONFIG_ATM_BR2684=3Dy=0A=
# CONFIG_ATM_BR2684_IPFILTER is not set=0A=
CONFIG_L2TP=3Dy=0A=
# CONFIG_L2TP_DEBUGFS is not set=0A=
CONFIG_L2TP_V3=3Dy=0A=
CONFIG_L2TP_IP=3Dy=0A=
CONFIG_L2TP_ETH=3Dy=0A=
CONFIG_STP=3Dy=0A=
CONFIG_GARP=3Dy=0A=
CONFIG_MRP=3Dy=0A=
CONFIG_BRIDGE=3Dy=0A=
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy=0A=
CONFIG_BRIDGE_VLAN_FILTERING=3Dy=0A=
CONFIG_BRIDGE_MRP=3Dy=0A=
CONFIG_BRIDGE_CFM=3Dy=0A=
CONFIG_NET_DSA=3Dy=0A=
# CONFIG_NET_DSA_TAG_NONE is not set=0A=
# CONFIG_NET_DSA_TAG_AR9331 is not set=0A=
CONFIG_NET_DSA_TAG_BRCM_COMMON=3Dy=0A=
CONFIG_NET_DSA_TAG_BRCM=3Dy=0A=
# CONFIG_NET_DSA_TAG_BRCM_LEGACY is not set=0A=
CONFIG_NET_DSA_TAG_BRCM_PREPEND=3Dy=0A=
# CONFIG_NET_DSA_TAG_HELLCREEK is not set=0A=
# CONFIG_NET_DSA_TAG_GSWIP is not set=0A=
# CONFIG_NET_DSA_TAG_DSA is not set=0A=
# CONFIG_NET_DSA_TAG_EDSA is not set=0A=
CONFIG_NET_DSA_TAG_MTK=3Dy=0A=
# CONFIG_NET_DSA_TAG_KSZ is not set=0A=
# CONFIG_NET_DSA_TAG_OCELOT is not set=0A=
# CONFIG_NET_DSA_TAG_OCELOT_8021Q is not set=0A=
CONFIG_NET_DSA_TAG_QCA=3Dy=0A=
CONFIG_NET_DSA_TAG_RTL4_A=3Dy=0A=
# CONFIG_NET_DSA_TAG_RTL8_4 is not set=0A=
# CONFIG_NET_DSA_TAG_RZN1_A5PSW is not set=0A=
# CONFIG_NET_DSA_TAG_LAN9303 is not set=0A=
# CONFIG_NET_DSA_TAG_SJA1105 is not set=0A=
# CONFIG_NET_DSA_TAG_TRAILER is not set=0A=
# CONFIG_NET_DSA_TAG_VSC73XX_8021Q is not set=0A=
# CONFIG_NET_DSA_TAG_XRS700X is not set=0A=
CONFIG_VLAN_8021Q=3Dy=0A=
CONFIG_VLAN_8021Q_GVRP=3Dy=0A=
CONFIG_VLAN_8021Q_MVRP=3Dy=0A=
CONFIG_LLC=3Dy=0A=
CONFIG_LLC2=3Dy=0A=
# CONFIG_ATALK is not set=0A=
CONFIG_X25=3Dy=0A=
CONFIG_LAPB=3Dy=0A=
CONFIG_PHONET=3Dy=0A=
CONFIG_6LOWPAN=3Dy=0A=
# CONFIG_6LOWPAN_DEBUGFS is not set=0A=
CONFIG_6LOWPAN_NHC=3Dy=0A=
CONFIG_6LOWPAN_NHC_DEST=3Dy=0A=
CONFIG_6LOWPAN_NHC_FRAGMENT=3Dy=0A=
CONFIG_6LOWPAN_NHC_HOP=3Dy=0A=
CONFIG_6LOWPAN_NHC_IPV6=3Dy=0A=
CONFIG_6LOWPAN_NHC_MOBILITY=3Dy=0A=
CONFIG_6LOWPAN_NHC_ROUTING=3Dy=0A=
CONFIG_6LOWPAN_NHC_UDP=3Dy=0A=
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=3Dy=0A=
CONFIG_6LOWPAN_GHC_UDP=3Dy=0A=
CONFIG_6LOWPAN_GHC_ICMPV6=3Dy=0A=
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=3Dy=0A=
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=3Dy=0A=
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=3Dy=0A=
CONFIG_IEEE802154=3Dy=0A=
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=3Dy=0A=
CONFIG_IEEE802154_SOCKET=3Dy=0A=
CONFIG_IEEE802154_6LOWPAN=3Dy=0A=
CONFIG_MAC802154=3Dy=0A=
CONFIG_NET_SCHED=3Dy=0A=
=0A=
#=0A=
# Queueing/Scheduling=0A=
#=0A=
CONFIG_NET_SCH_HTB=3Dy=0A=
CONFIG_NET_SCH_HFSC=3Dy=0A=
CONFIG_NET_SCH_PRIO=3Dy=0A=
CONFIG_NET_SCH_MULTIQ=3Dy=0A=
CONFIG_NET_SCH_RED=3Dy=0A=
CONFIG_NET_SCH_SFB=3Dy=0A=
CONFIG_NET_SCH_SFQ=3Dy=0A=
CONFIG_NET_SCH_TEQL=3Dy=0A=
CONFIG_NET_SCH_TBF=3Dy=0A=
CONFIG_NET_SCH_CBS=3Dy=0A=
CONFIG_NET_SCH_ETF=3Dy=0A=
CONFIG_NET_SCH_MQPRIO_LIB=3Dy=0A=
CONFIG_NET_SCH_TAPRIO=3Dy=0A=
CONFIG_NET_SCH_GRED=3Dy=0A=
CONFIG_NET_SCH_NETEM=3Dy=0A=
CONFIG_NET_SCH_DRR=3Dy=0A=
CONFIG_NET_SCH_MQPRIO=3Dy=0A=
CONFIG_NET_SCH_SKBPRIO=3Dy=0A=
CONFIG_NET_SCH_CHOKE=3Dy=0A=
CONFIG_NET_SCH_QFQ=3Dy=0A=
CONFIG_NET_SCH_CODEL=3Dy=0A=
CONFIG_NET_SCH_FQ_CODEL=3Dy=0A=
CONFIG_NET_SCH_CAKE=3Dy=0A=
CONFIG_NET_SCH_FQ=3Dy=0A=
CONFIG_NET_SCH_HHF=3Dy=0A=
CONFIG_NET_SCH_PIE=3Dy=0A=
CONFIG_NET_SCH_FQ_PIE=3Dy=0A=
CONFIG_NET_SCH_INGRESS=3Dy=0A=
CONFIG_NET_SCH_PLUG=3Dy=0A=
CONFIG_NET_SCH_ETS=3Dy=0A=
CONFIG_NET_SCH_DEFAULT=3Dy=0A=
# CONFIG_DEFAULT_FQ is not set=0A=
CONFIG_DEFAULT_CODEL=3Dy=0A=
# CONFIG_DEFAULT_FQ_CODEL is not set=0A=
# CONFIG_DEFAULT_FQ_PIE is not set=0A=
# CONFIG_DEFAULT_SFQ is not set=0A=
# CONFIG_DEFAULT_PFIFO_FAST is not set=0A=
CONFIG_DEFAULT_NET_SCH=3D"pfifo_fast"=0A=
=0A=
#=0A=
# Classification=0A=
#=0A=
CONFIG_NET_CLS=3Dy=0A=
CONFIG_NET_CLS_BASIC=3Dy=0A=
CONFIG_NET_CLS_ROUTE4=3Dy=0A=
CONFIG_NET_CLS_FW=3Dy=0A=
CONFIG_NET_CLS_U32=3Dy=0A=
CONFIG_CLS_U32_PERF=3Dy=0A=
CONFIG_CLS_U32_MARK=3Dy=0A=
CONFIG_NET_CLS_FLOW=3Dy=0A=
CONFIG_NET_CLS_CGROUP=3Dy=0A=
CONFIG_NET_CLS_BPF=3Dy=0A=
CONFIG_NET_CLS_FLOWER=3Dy=0A=
CONFIG_NET_CLS_MATCHALL=3Dy=0A=
CONFIG_NET_EMATCH=3Dy=0A=
CONFIG_NET_EMATCH_STACK=3D32=0A=
CONFIG_NET_EMATCH_CMP=3Dy=0A=
CONFIG_NET_EMATCH_NBYTE=3Dy=0A=
CONFIG_NET_EMATCH_U32=3Dy=0A=
CONFIG_NET_EMATCH_META=3Dy=0A=
CONFIG_NET_EMATCH_TEXT=3Dy=0A=
CONFIG_NET_EMATCH_CANID=3Dy=0A=
CONFIG_NET_EMATCH_IPSET=3Dy=0A=
CONFIG_NET_EMATCH_IPT=3Dy=0A=
CONFIG_NET_CLS_ACT=3Dy=0A=
CONFIG_NET_ACT_POLICE=3Dy=0A=
CONFIG_NET_ACT_GACT=3Dy=0A=
CONFIG_GACT_PROB=3Dy=0A=
CONFIG_NET_ACT_MIRRED=3Dy=0A=
CONFIG_NET_ACT_SAMPLE=3Dy=0A=
CONFIG_NET_ACT_NAT=3Dy=0A=
CONFIG_NET_ACT_PEDIT=3Dy=0A=
CONFIG_NET_ACT_SIMP=3Dy=0A=
CONFIG_NET_ACT_SKBEDIT=3Dy=0A=
CONFIG_NET_ACT_CSUM=3Dy=0A=
CONFIG_NET_ACT_MPLS=3Dy=0A=
CONFIG_NET_ACT_VLAN=3Dy=0A=
CONFIG_NET_ACT_BPF=3Dy=0A=
CONFIG_NET_ACT_CONNMARK=3Dy=0A=
CONFIG_NET_ACT_CTINFO=3Dy=0A=
CONFIG_NET_ACT_SKBMOD=3Dy=0A=
CONFIG_NET_ACT_IFE=3Dy=0A=
CONFIG_NET_ACT_TUNNEL_KEY=3Dy=0A=
CONFIG_NET_ACT_CT=3Dy=0A=
CONFIG_NET_ACT_GATE=3Dy=0A=
CONFIG_NET_IFE_SKBMARK=3Dy=0A=
CONFIG_NET_IFE_SKBPRIO=3Dy=0A=
CONFIG_NET_IFE_SKBTCINDEX=3Dy=0A=
CONFIG_NET_TC_SKB_EXT=3Dy=0A=
CONFIG_NET_SCH_FIFO=3Dy=0A=
CONFIG_DCB=3Dy=0A=
CONFIG_DNS_RESOLVER=3Dy=0A=
CONFIG_BATMAN_ADV=3Dy=0A=
CONFIG_BATMAN_ADV_BATMAN_V=3Dy=0A=
CONFIG_BATMAN_ADV_BLA=3Dy=0A=
CONFIG_BATMAN_ADV_DAT=3Dy=0A=
CONFIG_BATMAN_ADV_NC=3Dy=0A=
CONFIG_BATMAN_ADV_MCAST=3Dy=0A=
# CONFIG_BATMAN_ADV_DEBUG is not set=0A=
# CONFIG_BATMAN_ADV_TRACING is not set=0A=
CONFIG_OPENVSWITCH=3Dy=0A=
CONFIG_OPENVSWITCH_GRE=3Dy=0A=
CONFIG_OPENVSWITCH_VXLAN=3Dy=0A=
CONFIG_OPENVSWITCH_GENEVE=3Dy=0A=
CONFIG_VSOCKETS=3Dy=0A=
CONFIG_VSOCKETS_DIAG=3Dy=0A=
CONFIG_VSOCKETS_LOOPBACK=3Dy=0A=
# CONFIG_VMWARE_VMCI_VSOCKETS is not set=0A=
CONFIG_VIRTIO_VSOCKETS=3Dy=0A=
CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy=0A=
CONFIG_NETLINK_DIAG=3Dy=0A=
CONFIG_MPLS=3Dy=0A=
CONFIG_NET_MPLS_GSO=3Dy=0A=
CONFIG_MPLS_ROUTING=3Dy=0A=
CONFIG_MPLS_IPTUNNEL=3Dy=0A=
CONFIG_NET_NSH=3Dy=0A=
CONFIG_HSR=3Dy=0A=
CONFIG_NET_SWITCHDEV=3Dy=0A=
CONFIG_NET_L3_MASTER_DEV=3Dy=0A=
CONFIG_QRTR=3Dy=0A=
CONFIG_QRTR_TUN=3Dy=0A=
# CONFIG_QRTR_MHI is not set=0A=
CONFIG_NET_NCSI=3Dy=0A=
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set=0A=
# CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set=0A=
# CONFIG_PCPU_DEV_REFCNT is not set=0A=
CONFIG_MAX_SKB_FRAGS=3D17=0A=
CONFIG_RPS=3Dy=0A=
CONFIG_RFS_ACCEL=3Dy=0A=
CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy=0A=
CONFIG_XPS=3Dy=0A=
CONFIG_CGROUP_NET_PRIO=3Dy=0A=
CONFIG_CGROUP_NET_CLASSID=3Dy=0A=
CONFIG_NET_RX_BUSY_POLL=3Dy=0A=
CONFIG_BQL=3Dy=0A=
CONFIG_BPF_STREAM_PARSER=3Dy=0A=
CONFIG_NET_FLOW_LIMIT=3Dy=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
CONFIG_NET_DROP_MONITOR=3Dy=0A=
# end of Network testing=0A=
# end of Networking options=0A=
=0A=
CONFIG_HAMRADIO=3Dy=0A=
=0A=
#=0A=
# Packet Radio protocols=0A=
#=0A=
CONFIG_AX25=3Dy=0A=
CONFIG_AX25_DAMA_SLAVE=3Dy=0A=
CONFIG_NETROM=3Dy=0A=
CONFIG_ROSE=3Dy=0A=
=0A=
#=0A=
# AX.25 network device drivers=0A=
#=0A=
CONFIG_MKISS=3Dy=0A=
CONFIG_6PACK=3Dy=0A=
CONFIG_BPQETHER=3Dy=0A=
# CONFIG_BAYCOM_SER_FDX is not set=0A=
# CONFIG_BAYCOM_SER_HDX is not set=0A=
# CONFIG_BAYCOM_PAR is not set=0A=
# CONFIG_YAM is not set=0A=
# end of AX.25 network device drivers=0A=
=0A=
CONFIG_CAN=3Dy=0A=
CONFIG_CAN_RAW=3Dy=0A=
CONFIG_CAN_BCM=3Dy=0A=
CONFIG_CAN_GW=3Dy=0A=
CONFIG_CAN_J1939=3Dy=0A=
CONFIG_CAN_ISOTP=3Dy=0A=
CONFIG_BT=3Dy=0A=
CONFIG_BT_BREDR=3Dy=0A=
CONFIG_BT_RFCOMM=3Dy=0A=
CONFIG_BT_RFCOMM_TTY=3Dy=0A=
CONFIG_BT_BNEP=3Dy=0A=
CONFIG_BT_BNEP_MC_FILTER=3Dy=0A=
CONFIG_BT_BNEP_PROTO_FILTER=3Dy=0A=
CONFIG_BT_HIDP=3Dy=0A=
CONFIG_BT_LE=3Dy=0A=
CONFIG_BT_LE_L2CAP_ECRED=3Dy=0A=
CONFIG_BT_6LOWPAN=3Dy=0A=
CONFIG_BT_LEDS=3Dy=0A=
CONFIG_BT_MSFTEXT=3Dy=0A=
# CONFIG_BT_AOSPEXT is not set=0A=
# CONFIG_BT_DEBUGFS is not set=0A=
# CONFIG_BT_SELFTEST is not set=0A=
=0A=
#=0A=
# Bluetooth device drivers=0A=
#=0A=
CONFIG_BT_INTEL=3Dy=0A=
CONFIG_BT_BCM=3Dy=0A=
CONFIG_BT_RTL=3Dy=0A=
CONFIG_BT_QCA=3Dy=0A=
CONFIG_BT_MTK=3Dy=0A=
CONFIG_BT_HCIBTUSB=3Dy=0A=
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy=0A=
CONFIG_BT_HCIBTUSB_POLL_SYNC=3Dy=0A=
CONFIG_BT_HCIBTUSB_BCM=3Dy=0A=
CONFIG_BT_HCIBTUSB_MTK=3Dy=0A=
CONFIG_BT_HCIBTUSB_RTL=3Dy=0A=
# CONFIG_BT_HCIBTSDIO is not set=0A=
CONFIG_BT_HCIUART=3Dy=0A=
CONFIG_BT_HCIUART_SERDEV=3Dy=0A=
CONFIG_BT_HCIUART_H4=3Dy=0A=
# CONFIG_BT_HCIUART_NOKIA is not set=0A=
CONFIG_BT_HCIUART_BCSP=3Dy=0A=
# CONFIG_BT_HCIUART_ATH3K is not set=0A=
CONFIG_BT_HCIUART_LL=3Dy=0A=
CONFIG_BT_HCIUART_3WIRE=3Dy=0A=
# CONFIG_BT_HCIUART_INTEL is not set=0A=
# CONFIG_BT_HCIUART_BCM is not set=0A=
# CONFIG_BT_HCIUART_RTL is not set=0A=
CONFIG_BT_HCIUART_QCA=3Dy=0A=
CONFIG_BT_HCIUART_AG6XX=3Dy=0A=
CONFIG_BT_HCIUART_MRVL=3Dy=0A=
# CONFIG_BT_HCIUART_AML is not set=0A=
CONFIG_BT_HCIBCM203X=3Dy=0A=
# CONFIG_BT_HCIBCM4377 is not set=0A=
CONFIG_BT_HCIBPA10X=3Dy=0A=
CONFIG_BT_HCIBFUSB=3Dy=0A=
# CONFIG_BT_HCIDTL1 is not set=0A=
# CONFIG_BT_HCIBT3C is not set=0A=
# CONFIG_BT_HCIBLUECARD is not set=0A=
CONFIG_BT_HCIVHCI=3Dy=0A=
CONFIG_BT_MRVL=3Dy=0A=
CONFIG_BT_MRVL_SDIO=3Dy=0A=
CONFIG_BT_ATH3K=3Dy=0A=
CONFIG_BT_MTKSDIO=3Dy=0A=
CONFIG_BT_MTKUART=3Dy=0A=
# CONFIG_BT_VIRTIO is not set=0A=
# CONFIG_BT_NXPUART is not set=0A=
# CONFIG_BT_INTEL_PCIE is not set=0A=
# end of Bluetooth device drivers=0A=
=0A=
CONFIG_AF_RXRPC=3Dy=0A=
CONFIG_AF_RXRPC_IPV6=3Dy=0A=
# CONFIG_AF_RXRPC_INJECT_LOSS is not set=0A=
# CONFIG_AF_RXRPC_INJECT_RX_DELAY is not set=0A=
# CONFIG_AF_RXRPC_DEBUG is not set=0A=
CONFIG_RXKAD=3Dy=0A=
# CONFIG_RXPERF is not set=0A=
CONFIG_AF_KCM=3Dy=0A=
CONFIG_STREAM_PARSER=3Dy=0A=
# CONFIG_MCTP is not set=0A=
CONFIG_FIB_RULES=3Dy=0A=
CONFIG_WIRELESS=3Dy=0A=
CONFIG_WEXT_CORE=3Dy=0A=
CONFIG_WEXT_PROC=3Dy=0A=
CONFIG_CFG80211=3Dy=0A=
# CONFIG_NL80211_TESTMODE is not set=0A=
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set=0A=
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set=0A=
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy=0A=
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy=0A=
CONFIG_CFG80211_DEFAULT_PS=3Dy=0A=
CONFIG_CFG80211_DEBUGFS=3Dy=0A=
CONFIG_CFG80211_CRDA_SUPPORT=3Dy=0A=
CONFIG_CFG80211_WEXT=3Dy=0A=
CONFIG_MAC80211=3Dy=0A=
CONFIG_MAC80211_HAS_RC=3Dy=0A=
CONFIG_MAC80211_RC_MINSTREL=3Dy=0A=
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy=0A=
CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"=0A=
CONFIG_MAC80211_MESH=3Dy=0A=
CONFIG_MAC80211_LEDS=3Dy=0A=
CONFIG_MAC80211_DEBUGFS=3Dy=0A=
# CONFIG_MAC80211_MESSAGE_TRACING is not set=0A=
# CONFIG_MAC80211_DEBUG_MENU is not set=0A=
CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0=0A=
CONFIG_RFKILL=3Dy=0A=
CONFIG_RFKILL_LEDS=3Dy=0A=
CONFIG_RFKILL_INPUT=3Dy=0A=
# CONFIG_RFKILL_GPIO is not set=0A=
CONFIG_NET_9P=3Dy=0A=
CONFIG_NET_9P_FD=3Dy=0A=
CONFIG_NET_9P_VIRTIO=3Dy=0A=
# CONFIG_NET_9P_USBG is not set=0A=
CONFIG_NET_9P_RDMA=3Dy=0A=
# CONFIG_NET_9P_DEBUG is not set=0A=
CONFIG_CAIF=3Dy=0A=
CONFIG_CAIF_DEBUG=3Dy=0A=
CONFIG_CAIF_NETDEV=3Dy=0A=
CONFIG_CAIF_USB=3Dy=0A=
CONFIG_CEPH_LIB=3Dy=0A=
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set=0A=
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy=0A=
CONFIG_NFC=3Dy=0A=
CONFIG_NFC_DIGITAL=3Dy=0A=
CONFIG_NFC_NCI=3Dy=0A=
# CONFIG_NFC_NCI_SPI is not set=0A=
CONFIG_NFC_NCI_UART=3Dy=0A=
CONFIG_NFC_HCI=3Dy=0A=
CONFIG_NFC_SHDLC=3Dy=0A=
=0A=
#=0A=
# Near Field Communication (NFC) devices=0A=
#=0A=
# CONFIG_NFC_TRF7970A is not set=0A=
# CONFIG_NFC_MEI_PHY is not set=0A=
CONFIG_NFC_SIM=3Dy=0A=
CONFIG_NFC_PORT100=3Dy=0A=
CONFIG_NFC_VIRTUAL_NCI=3Dy=0A=
CONFIG_NFC_FDP=3Dy=0A=
# CONFIG_NFC_FDP_I2C is not set=0A=
# CONFIG_NFC_PN544_I2C is not set=0A=
CONFIG_NFC_PN533=3Dy=0A=
CONFIG_NFC_PN533_USB=3Dy=0A=
# CONFIG_NFC_PN533_I2C is not set=0A=
# CONFIG_NFC_PN532_UART is not set=0A=
# CONFIG_NFC_MICROREAD_I2C is not set=0A=
CONFIG_NFC_MRVL=3Dy=0A=
CONFIG_NFC_MRVL_USB=3Dy=0A=
# CONFIG_NFC_MRVL_UART is not set=0A=
# CONFIG_NFC_MRVL_I2C is not set=0A=
# CONFIG_NFC_ST21NFCA_I2C is not set=0A=
# CONFIG_NFC_ST_NCI_I2C is not set=0A=
# CONFIG_NFC_ST_NCI_SPI is not set=0A=
# CONFIG_NFC_NXP_NCI is not set=0A=
# CONFIG_NFC_S3FWRN5_I2C is not set=0A=
# CONFIG_NFC_S3FWRN82_UART is not set=0A=
# CONFIG_NFC_ST95HF is not set=0A=
# end of Near Field Communication (NFC) devices=0A=
=0A=
CONFIG_PSAMPLE=3Dy=0A=
CONFIG_NET_IFE=3Dy=0A=
CONFIG_LWTUNNEL=3Dy=0A=
CONFIG_LWTUNNEL_BPF=3Dy=0A=
CONFIG_DST_CACHE=3Dy=0A=
CONFIG_GRO_CELLS=3Dy=0A=
CONFIG_SOCK_VALIDATE_XMIT=3Dy=0A=
CONFIG_NET_SELFTESTS=3Dy=0A=
CONFIG_NET_SOCK_MSG=3Dy=0A=
CONFIG_NET_DEVLINK=3Dy=0A=
CONFIG_PAGE_POOL=3Dy=0A=
# CONFIG_PAGE_POOL_STATS is not set=0A=
CONFIG_FAILOVER=3Dy=0A=
CONFIG_ETHTOOL_NETLINK=3Dy=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
CONFIG_HAVE_EISA=3Dy=0A=
# CONFIG_EISA is not set=0A=
CONFIG_HAVE_PCI=3Dy=0A=
CONFIG_GENERIC_PCI_IOMAP=3Dy=0A=
CONFIG_PCI=3Dy=0A=
CONFIG_PCI_DOMAINS=3Dy=0A=
CONFIG_PCIEPORTBUS=3Dy=0A=
CONFIG_HOTPLUG_PCI_PCIE=3Dy=0A=
CONFIG_PCIEAER=3Dy=0A=
# CONFIG_PCIEAER_INJECT is not set=0A=
# CONFIG_PCIE_ECRC is not set=0A=
CONFIG_PCIEASPM=3Dy=0A=
CONFIG_PCIEASPM_DEFAULT=3Dy=0A=
# CONFIG_PCIEASPM_POWERSAVE is not set=0A=
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set=0A=
# CONFIG_PCIEASPM_PERFORMANCE is not set=0A=
CONFIG_PCIE_PME=3Dy=0A=
# CONFIG_PCIE_DPC is not set=0A=
# CONFIG_PCIE_PTM is not set=0A=
CONFIG_PCI_MSI=3Dy=0A=
CONFIG_PCI_QUIRKS=3Dy=0A=
# CONFIG_PCI_DEBUG is not set=0A=
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set=0A=
# CONFIG_PCI_STUB is not set=0A=
# CONFIG_PCI_PF_STUB is not set=0A=
CONFIG_PCI_ATS=3Dy=0A=
CONFIG_PCI_ECAM=3Dy=0A=
CONFIG_PCI_LOCKLESS_CONFIG=3Dy=0A=
CONFIG_PCI_IOV=3Dy=0A=
# CONFIG_PCI_NPEM is not set=0A=
CONFIG_PCI_PRI=3Dy=0A=
CONFIG_PCI_PASID=3Dy=0A=
# CONFIG_PCIE_TPH is not set=0A=
# CONFIG_PCI_P2PDMA is not set=0A=
CONFIG_PCI_LABEL=3Dy=0A=
# CONFIG_PCI_DYNAMIC_OF_NODES is not set=0A=
# CONFIG_PCIE_BUS_TUNE_OFF is not set=0A=
CONFIG_PCIE_BUS_DEFAULT=3Dy=0A=
# CONFIG_PCIE_BUS_SAFE is not set=0A=
# CONFIG_PCIE_BUS_PERFORMANCE is not set=0A=
# CONFIG_PCIE_BUS_PEER2PEER is not set=0A=
CONFIG_VGA_ARB=3Dy=0A=
CONFIG_VGA_ARB_MAX_GPUS=3D16=0A=
CONFIG_HOTPLUG_PCI=3Dy=0A=
# CONFIG_HOTPLUG_PCI_ACPI is not set=0A=
# CONFIG_HOTPLUG_PCI_CPCI is not set=0A=
# CONFIG_HOTPLUG_PCI_OCTEONEP is not set=0A=
# CONFIG_HOTPLUG_PCI_SHPC is not set=0A=
=0A=
#=0A=
# PCI controller drivers=0A=
#=0A=
# CONFIG_PCI_FTPCI100 is not set=0A=
CONFIG_PCI_HOST_COMMON=3Dy=0A=
CONFIG_PCI_HOST_GENERIC=3Dy=0A=
# CONFIG_VMD is not set=0A=
# CONFIG_PCIE_XILINX is not set=0A=
=0A=
#=0A=
# Cadence-based PCIe controllers=0A=
#=0A=
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set=0A=
# CONFIG_PCIE_CADENCE_PLAT_EP is not set=0A=
# end of Cadence-based PCIe controllers=0A=
=0A=
#=0A=
# DesignWare-based PCIe controllers=0A=
#=0A=
# CONFIG_PCI_MESON is not set=0A=
# CONFIG_PCIE_INTEL_GW is not set=0A=
# CONFIG_PCIE_DW_PLAT_HOST is not set=0A=
# CONFIG_PCIE_DW_PLAT_EP is not set=0A=
# end of DesignWare-based PCIe controllers=0A=
=0A=
#=0A=
# Mobiveil-based PCIe controllers=0A=
#=0A=
# end of Mobiveil-based PCIe controllers=0A=
=0A=
#=0A=
# PLDA-based PCIe controllers=0A=
#=0A=
# CONFIG_PCIE_MICROCHIP_HOST is not set=0A=
# end of PLDA-based PCIe controllers=0A=
# end of PCI controller drivers=0A=
=0A=
#=0A=
# PCI Endpoint=0A=
#=0A=
CONFIG_PCI_ENDPOINT=3Dy=0A=
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set=0A=
# CONFIG_PCI_EPF_TEST is not set=0A=
# CONFIG_PCI_EPF_NTB is not set=0A=
# end of PCI Endpoint=0A=
=0A=
#=0A=
# PCI switch controller drivers=0A=
#=0A=
# CONFIG_PCI_SW_SWITCHTEC is not set=0A=
# end of PCI switch controller drivers=0A=
=0A=
# CONFIG_CXL_BUS is not set=0A=
CONFIG_PCCARD=3Dy=0A=
CONFIG_PCMCIA=3Dy=0A=
CONFIG_PCMCIA_LOAD_CIS=3Dy=0A=
CONFIG_CARDBUS=3Dy=0A=
=0A=
#=0A=
# PC-card bridges=0A=
#=0A=
CONFIG_YENTA=3Dy=0A=
CONFIG_YENTA_O2=3Dy=0A=
CONFIG_YENTA_RICOH=3Dy=0A=
CONFIG_YENTA_TI=3Dy=0A=
CONFIG_YENTA_ENE_TUNE=3Dy=0A=
CONFIG_YENTA_TOSHIBA=3Dy=0A=
# CONFIG_PD6729 is not set=0A=
# CONFIG_I82092 is not set=0A=
CONFIG_PCCARD_NONSTATIC=3Dy=0A=
# CONFIG_RAPIDIO is not set=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
CONFIG_AUXILIARY_BUS=3Dy=0A=
CONFIG_UEVENT_HELPER=3Dy=0A=
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"=0A=
CONFIG_DEVTMPFS=3Dy=0A=
CONFIG_DEVTMPFS_MOUNT=3Dy=0A=
# CONFIG_DEVTMPFS_SAFE is not set=0A=
CONFIG_STANDALONE=3Dy=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
=0A=
#=0A=
# Firmware loader=0A=
#=0A=
CONFIG_FW_LOADER=3Dy=0A=
# CONFIG_FW_LOADER_DEBUG is not set=0A=
CONFIG_FW_LOADER_PAGED_BUF=3Dy=0A=
CONFIG_FW_LOADER_SYSFS=3Dy=0A=
CONFIG_EXTRA_FIRMWARE=3D""=0A=
CONFIG_FW_LOADER_USER_HELPER=3Dy=0A=
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=3Dy=0A=
CONFIG_FW_LOADER_COMPRESS=3Dy=0A=
# CONFIG_FW_LOADER_COMPRESS_XZ is not set=0A=
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set=0A=
CONFIG_FW_CACHE=3Dy=0A=
# CONFIG_FW_UPLOAD is not set=0A=
# end of Firmware loader=0A=
=0A=
CONFIG_WANT_DEV_COREDUMP=3Dy=0A=
CONFIG_ALLOW_DEV_COREDUMP=3Dy=0A=
CONFIG_DEV_COREDUMP=3Dy=0A=
# CONFIG_DEBUG_DRIVER is not set=0A=
CONFIG_DEBUG_DEVRES=3Dy=0A=
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set=0A=
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set=0A=
CONFIG_GENERIC_CPU_DEVICES=3Dy=0A=
CONFIG_GENERIC_CPU_AUTOPROBE=3Dy=0A=
CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy=0A=
CONFIG_REGMAP=3Dy=0A=
CONFIG_REGMAP_I2C=3Dy=0A=
CONFIG_REGMAP_SPI=3Dy=0A=
CONFIG_REGMAP_MMIO=3Dy=0A=
CONFIG_REGMAP_IRQ=3Dy=0A=
CONFIG_DMA_SHARED_BUFFER=3Dy=0A=
# CONFIG_DMA_FENCE_TRACE is not set=0A=
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set=0A=
# end of Generic Driver Options=0A=
=0A=
#=0A=
# Bus devices=0A=
#=0A=
# CONFIG_MOXTET is not set=0A=
CONFIG_MHI_BUS=3Dy=0A=
# CONFIG_MHI_BUS_DEBUG is not set=0A=
# CONFIG_MHI_BUS_PCI_GENERIC is not set=0A=
# CONFIG_MHI_BUS_EP is not set=0A=
# end of Bus devices=0A=
=0A=
#=0A=
# Cache Drivers=0A=
#=0A=
# end of Cache Drivers=0A=
=0A=
CONFIG_CONNECTOR=3Dy=0A=
CONFIG_PROC_EVENTS=3Dy=0A=
=0A=
#=0A=
# Firmware Drivers=0A=
#=0A=
=0A=
#=0A=
# ARM System Control and Management Interface Protocol=0A=
#=0A=
# end of ARM System Control and Management Interface Protocol=0A=
=0A=
# CONFIG_EDD is not set=0A=
CONFIG_FIRMWARE_MEMMAP=3Dy=0A=
CONFIG_DMIID=3Dy=0A=
# CONFIG_DMI_SYSFS is not set=0A=
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy=0A=
# CONFIG_ISCSI_IBFT is not set=0A=
# CONFIG_FW_CFG_SYSFS is not set=0A=
CONFIG_SYSFB=3Dy=0A=
# CONFIG_SYSFB_SIMPLEFB is not set=0A=
CONFIG_GOOGLE_FIRMWARE=3Dy=0A=
# CONFIG_GOOGLE_SMI is not set=0A=
# CONFIG_GOOGLE_CBMEM is not set=0A=
CONFIG_GOOGLE_COREBOOT_TABLE=3Dy=0A=
CONFIG_GOOGLE_MEMCONSOLE=3Dy=0A=
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set=0A=
# CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT is not set=0A=
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=3Dy=0A=
CONFIG_GOOGLE_VPD=3Dy=0A=
CONFIG_IMX_SCMI_MISC_DRV=3Dy=0A=
=0A=
#=0A=
# Qualcomm firmware drivers=0A=
#=0A=
# end of Qualcomm firmware drivers=0A=
=0A=
#=0A=
# Tegra firmware driver=0A=
#=0A=
# end of Tegra firmware driver=0A=
# end of Firmware Drivers=0A=
=0A=
CONFIG_GNSS=3Dy=0A=
# CONFIG_GNSS_MTK_SERIAL is not set=0A=
# CONFIG_GNSS_SIRF_SERIAL is not set=0A=
# CONFIG_GNSS_UBX_SERIAL is not set=0A=
CONFIG_GNSS_USB=3Dy=0A=
CONFIG_MTD=3Dy=0A=
# CONFIG_MTD_TESTS is not set=0A=
=0A=
#=0A=
# Partition parsers=0A=
#=0A=
# CONFIG_MTD_CMDLINE_PARTS is not set=0A=
# CONFIG_MTD_OF_PARTS is not set=0A=
# CONFIG_MTD_REDBOOT_PARTS is not set=0A=
# end of Partition parsers=0A=
=0A=
#=0A=
# User Modules And Translation Layers=0A=
#=0A=
CONFIG_MTD_BLKDEVS=3Dy=0A=
CONFIG_MTD_BLOCK=3Dy=0A=
=0A=
#=0A=
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.=0A=
#=0A=
CONFIG_FTL=3Dy=0A=
# CONFIG_NFTL is not set=0A=
# CONFIG_INFTL is not set=0A=
# CONFIG_RFD_FTL is not set=0A=
# CONFIG_SSFDC is not set=0A=
# CONFIG_SM_FTL is not set=0A=
# CONFIG_MTD_OOPS is not set=0A=
# CONFIG_MTD_SWAP is not set=0A=
# CONFIG_MTD_PARTITIONED_MASTER is not set=0A=
=0A=
#=0A=
# RAM/ROM/Flash chip drivers=0A=
#=0A=
# CONFIG_MTD_CFI is not set=0A=
# CONFIG_MTD_JEDECPROBE is not set=0A=
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy=0A=
CONFIG_MTD_CFI_I1=3Dy=0A=
CONFIG_MTD_CFI_I2=3Dy=0A=
# CONFIG_MTD_RAM is not set=0A=
# CONFIG_MTD_ROM is not set=0A=
# CONFIG_MTD_ABSENT is not set=0A=
# end of RAM/ROM/Flash chip drivers=0A=
=0A=
#=0A=
# Mapping drivers for chip access=0A=
#=0A=
# CONFIG_MTD_COMPLEX_MAPPINGS is not set=0A=
# CONFIG_MTD_PLATRAM is not set=0A=
# end of Mapping drivers for chip access=0A=
=0A=
#=0A=
# Self-contained MTD device drivers=0A=
#=0A=
# CONFIG_MTD_PMC551 is not set=0A=
# CONFIG_MTD_DATAFLASH is not set=0A=
# CONFIG_MTD_MCHP23K256 is not set=0A=
# CONFIG_MTD_MCHP48L640 is not set=0A=
# CONFIG_MTD_SST25L is not set=0A=
CONFIG_MTD_SLRAM=3Dy=0A=
CONFIG_MTD_PHRAM=3Dy=0A=
CONFIG_MTD_MTDRAM=3Dy=0A=
CONFIG_MTDRAM_TOTAL_SIZE=3D128=0A=
CONFIG_MTDRAM_ERASE_SIZE=3D4=0A=
CONFIG_MTD_BLOCK2MTD=3Dy=0A=
=0A=
#=0A=
# Disk-On-Chip Device Drivers=0A=
#=0A=
# CONFIG_MTD_DOCG3 is not set=0A=
# end of Self-contained MTD device drivers=0A=
=0A=
#=0A=
# NAND=0A=
#=0A=
# CONFIG_MTD_ONENAND is not set=0A=
# CONFIG_MTD_RAW_NAND is not set=0A=
# CONFIG_MTD_SPI_NAND is not set=0A=
=0A=
#=0A=
# ECC engine support=0A=
#=0A=
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set=0A=
# CONFIG_MTD_NAND_ECC_SW_BCH is not set=0A=
# CONFIG_MTD_NAND_ECC_MXIC is not set=0A=
# end of ECC engine support=0A=
# end of NAND=0A=
=0A=
#=0A=
# LPDDR & LPDDR2 PCM memory drivers=0A=
#=0A=
# CONFIG_MTD_LPDDR is not set=0A=
# end of LPDDR & LPDDR2 PCM memory drivers=0A=
=0A=
# CONFIG_MTD_SPI_NOR is not set=0A=
CONFIG_MTD_UBI=3Dy=0A=
CONFIG_MTD_UBI_WL_THRESHOLD=3D4096=0A=
CONFIG_MTD_UBI_BEB_LIMIT=3D20=0A=
# CONFIG_MTD_UBI_FASTMAP is not set=0A=
# CONFIG_MTD_UBI_GLUEBI is not set=0A=
# CONFIG_MTD_UBI_BLOCK is not set=0A=
# CONFIG_MTD_UBI_FAULT_INJECTION is not set=0A=
# CONFIG_MTD_UBI_NVMEM is not set=0A=
# CONFIG_MTD_HYPERBUS is not set=0A=
CONFIG_DTC=3Dy=0A=
CONFIG_OF=3Dy=0A=
# CONFIG_OF_UNITTEST is not set=0A=
CONFIG_OF_FLATTREE=3Dy=0A=
CONFIG_OF_EARLY_FLATTREE=3Dy=0A=
CONFIG_OF_KOBJ=3Dy=0A=
CONFIG_OF_ADDRESS=3Dy=0A=
CONFIG_OF_IRQ=3Dy=0A=
CONFIG_OF_RESERVED_MEM=3Dy=0A=
# CONFIG_OF_OVERLAY is not set=0A=
CONFIG_OF_NUMA=3Dy=0A=
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy=0A=
CONFIG_PARPORT=3Dy=0A=
# CONFIG_PARPORT_PC is not set=0A=
# CONFIG_PARPORT_1284 is not set=0A=
CONFIG_PARPORT_NOT_PC=3Dy=0A=
CONFIG_PNP=3Dy=0A=
CONFIG_PNP_DEBUG_MESSAGES=3Dy=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
CONFIG_PNPACPI=3Dy=0A=
CONFIG_BLK_DEV=3Dy=0A=
CONFIG_BLK_DEV_NULL_BLK=3Dy=0A=
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=3Dy=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
CONFIG_CDROM=3Dy=0A=
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set=0A=
CONFIG_ZRAM=3Dy=0A=
# CONFIG_ZRAM_BACKEND_LZ4 is not set=0A=
# CONFIG_ZRAM_BACKEND_LZ4HC is not set=0A=
# CONFIG_ZRAM_BACKEND_ZSTD is not set=0A=
# CONFIG_ZRAM_BACKEND_DEFLATE is not set=0A=
# CONFIG_ZRAM_BACKEND_842 is not set=0A=
CONFIG_ZRAM_BACKEND_FORCE_LZO=3Dy=0A=
CONFIG_ZRAM_BACKEND_LZO=3Dy=0A=
# CONFIG_ZRAM_DEF_COMP_LZORLE is not set=0A=
CONFIG_ZRAM_DEF_COMP_LZO=3Dy=0A=
CONFIG_ZRAM_DEF_COMP=3D"lzo"=0A=
# CONFIG_ZRAM_WRITEBACK is not set=0A=
# CONFIG_ZRAM_TRACK_ENTRY_ACTIME is not set=0A=
# CONFIG_ZRAM_MEMORY_TRACKING is not set=0A=
# CONFIG_ZRAM_MULTI_COMP is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D16=0A=
# CONFIG_BLK_DEV_DRBD is not set=0A=
CONFIG_BLK_DEV_NBD=3Dy=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_COUNT=3D16=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
# CONFIG_CDROM_PKTCDVD is not set=0A=
CONFIG_ATA_OVER_ETH=3Dy=0A=
CONFIG_VIRTIO_BLK=3Dy=0A=
# CONFIG_BLK_DEV_RBD is not set=0A=
# CONFIG_BLK_DEV_UBLK is not set=0A=
CONFIG_BLK_DEV_RNBD=3Dy=0A=
CONFIG_BLK_DEV_RNBD_CLIENT=3Dy=0A=
=0A=
#=0A=
# NVME Support=0A=
#=0A=
CONFIG_NVME_CORE=3Dy=0A=
CONFIG_BLK_DEV_NVME=3Dy=0A=
CONFIG_NVME_MULTIPATH=3Dy=0A=
# CONFIG_NVME_VERBOSE_ERRORS is not set=0A=
# CONFIG_NVME_HWMON is not set=0A=
CONFIG_NVME_FABRICS=3Dy=0A=
CONFIG_NVME_RDMA=3Dy=0A=
CONFIG_NVME_FC=3Dy=0A=
CONFIG_NVME_TCP=3Dy=0A=
# CONFIG_NVME_TCP_TLS is not set=0A=
# CONFIG_NVME_HOST_AUTH is not set=0A=
CONFIG_NVME_TARGET=3Dy=0A=
# CONFIG_NVME_TARGET_DEBUGFS is not set=0A=
# CONFIG_NVME_TARGET_PASSTHRU is not set=0A=
CONFIG_NVME_TARGET_LOOP=3Dy=0A=
CONFIG_NVME_TARGET_RDMA=3Dy=0A=
CONFIG_NVME_TARGET_FC=3Dy=0A=
CONFIG_NVME_TARGET_FCLOOP=3Dy=0A=
CONFIG_NVME_TARGET_TCP=3Dy=0A=
# CONFIG_NVME_TARGET_TCP_TLS is not set=0A=
# CONFIG_NVME_TARGET_AUTH is not set=0A=
# end of NVME Support=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
# CONFIG_AD525X_DPOT is not set=0A=
# CONFIG_DUMMY_IRQ is not set=0A=
# CONFIG_IBM_ASM is not set=0A=
# CONFIG_PHANTOM is not set=0A=
# CONFIG_RPMB is not set=0A=
# CONFIG_TIFM_CORE is not set=0A=
# CONFIG_ICS932S401 is not set=0A=
# CONFIG_ENCLOSURE_SERVICES is not set=0A=
# CONFIG_HP_ILO is not set=0A=
# CONFIG_APDS9802ALS is not set=0A=
# CONFIG_ISL29003 is not set=0A=
# CONFIG_ISL29020 is not set=0A=
# CONFIG_SENSORS_TSL2550 is not set=0A=
# CONFIG_SENSORS_BH1770 is not set=0A=
# CONFIG_SENSORS_APDS990X is not set=0A=
# CONFIG_HMC6352 is not set=0A=
# CONFIG_DS1682 is not set=0A=
# CONFIG_VMWARE_BALLOON is not set=0A=
# CONFIG_LATTICE_ECP3_CONFIG is not set=0A=
# CONFIG_SRAM is not set=0A=
# CONFIG_DW_XDATA_PCIE is not set=0A=
# CONFIG_PCI_ENDPOINT_TEST is not set=0A=
# CONFIG_XILINX_SDFEC is not set=0A=
CONFIG_MISC_RTSX=3Dy=0A=
# CONFIG_HISI_HIKEY_USB is not set=0A=
# CONFIG_OPEN_DICE is not set=0A=
# CONFIG_VCPU_STALL_DETECTOR is not set=0A=
# CONFIG_NSM is not set=0A=
# CONFIG_MCHP_LAN966X_PCI is not set=0A=
# CONFIG_C2PORT is not set=0A=
=0A=
#=0A=
# EEPROM support=0A=
#=0A=
# CONFIG_EEPROM_AT24 is not set=0A=
# CONFIG_EEPROM_AT25 is not set=0A=
# CONFIG_EEPROM_MAX6875 is not set=0A=
CONFIG_EEPROM_93CX6=3Dy=0A=
# CONFIG_EEPROM_93XX46 is not set=0A=
# CONFIG_EEPROM_IDT_89HPESX is not set=0A=
# CONFIG_EEPROM_EE1004 is not set=0A=
# end of EEPROM support=0A=
=0A=
# CONFIG_CB710_CORE is not set=0A=
# CONFIG_SENSORS_LIS3_I2C is not set=0A=
# CONFIG_ALTERA_STAPL is not set=0A=
CONFIG_INTEL_MEI=3Dy=0A=
CONFIG_INTEL_MEI_ME=3Dy=0A=
# CONFIG_INTEL_MEI_TXE is not set=0A=
# CONFIG_INTEL_MEI_GSC is not set=0A=
# CONFIG_INTEL_MEI_VSC_HW is not set=0A=
# CONFIG_INTEL_MEI_HDCP is not set=0A=
# CONFIG_INTEL_MEI_PXP is not set=0A=
# CONFIG_INTEL_MEI_GSC_PROXY is not set=0A=
CONFIG_VMWARE_VMCI=3Dy=0A=
# CONFIG_GENWQE is not set=0A=
# CONFIG_ECHO is not set=0A=
# CONFIG_BCM_VK is not set=0A=
# CONFIG_MISC_ALCOR_PCI is not set=0A=
# CONFIG_MISC_RTSX_PCI is not set=0A=
CONFIG_MISC_RTSX_USB=3Dy=0A=
# CONFIG_UACCE is not set=0A=
# CONFIG_PVPANIC is not set=0A=
# CONFIG_GP_PCI1XXXX is not set=0A=
# CONFIG_KEBA_CP500 is not set=0A=
# end of Misc devices=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI_MOD=3Dy=0A=
CONFIG_RAID_ATTRS=3Dy=0A=
CONFIG_SCSI_COMMON=3Dy=0A=
CONFIG_SCSI=3Dy=0A=
CONFIG_SCSI_DMA=3Dy=0A=
CONFIG_SCSI_NETLINK=3Dy=0A=
CONFIG_SCSI_PROC_FS=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
CONFIG_CHR_DEV_ST=3Dy=0A=
CONFIG_BLK_DEV_SR=3Dy=0A=
CONFIG_CHR_DEV_SG=3Dy=0A=
CONFIG_BLK_DEV_BSG=3Dy=0A=
# CONFIG_CHR_DEV_SCH is not set=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
CONFIG_SCSI_LOGGING=3Dy=0A=
CONFIG_SCSI_SCAN_ASYNC=3Dy=0A=
=0A=
#=0A=
# SCSI Transports=0A=
#=0A=
CONFIG_SCSI_SPI_ATTRS=3Dy=0A=
CONFIG_SCSI_FC_ATTRS=3Dy=0A=
CONFIG_SCSI_ISCSI_ATTRS=3Dy=0A=
CONFIG_SCSI_SAS_ATTRS=3Dy=0A=
CONFIG_SCSI_SAS_LIBSAS=3Dy=0A=
CONFIG_SCSI_SAS_ATA=3Dy=0A=
# CONFIG_SCSI_SAS_HOST_SMP is not set=0A=
CONFIG_SCSI_SRP_ATTRS=3Dy=0A=
# end of SCSI Transports=0A=
=0A=
CONFIG_SCSI_LOWLEVEL=3Dy=0A=
# CONFIG_ISCSI_TCP is not set=0A=
# CONFIG_ISCSI_BOOT_SYSFS is not set=0A=
# CONFIG_SCSI_CXGB3_ISCSI is not set=0A=
# CONFIG_SCSI_CXGB4_ISCSI is not set=0A=
# CONFIG_SCSI_BNX2_ISCSI is not set=0A=
# CONFIG_BE2ISCSI is not set=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
CONFIG_SCSI_HPSA=3Dy=0A=
# CONFIG_SCSI_3W_9XXX is not set=0A=
# CONFIG_SCSI_3W_SAS is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_AIC94XX is not set=0A=
# CONFIG_SCSI_MVSAS is not set=0A=
# CONFIG_SCSI_MVUMI is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_ARCMSR is not set=0A=
# CONFIG_SCSI_ESAS2R is not set=0A=
# CONFIG_MEGARAID_NEWGEN is not set=0A=
# CONFIG_MEGARAID_LEGACY is not set=0A=
# CONFIG_MEGARAID_SAS is not set=0A=
# CONFIG_SCSI_MPT3SAS is not set=0A=
# CONFIG_SCSI_MPT2SAS is not set=0A=
# CONFIG_SCSI_MPI3MR is not set=0A=
# CONFIG_SCSI_SMARTPQI is not set=0A=
# CONFIG_SCSI_HPTIOP is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_MYRB is not set=0A=
# CONFIG_SCSI_MYRS is not set=0A=
# CONFIG_VMWARE_PVSCSI is not set=0A=
# CONFIG_LIBFC is not set=0A=
# CONFIG_SCSI_SNIC is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_FDOMAIN_PCI is not set=0A=
# CONFIG_SCSI_ISCI is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_STEX is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_IPR is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
# CONFIG_SCSI_QLA_FC is not set=0A=
# CONFIG_SCSI_QLA_ISCSI is not set=0A=
# CONFIG_SCSI_LPFC is not set=0A=
# CONFIG_SCSI_EFCT is not set=0A=
# CONFIG_SCSI_DC395x is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_WD719X is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
# CONFIG_SCSI_PMCRAID is not set=0A=
# CONFIG_SCSI_PM8001 is not set=0A=
# CONFIG_SCSI_BFA_FC is not set=0A=
CONFIG_SCSI_VIRTIO=3Dy=0A=
# CONFIG_SCSI_CHELSIO_FCOE is not set=0A=
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set=0A=
# CONFIG_SCSI_DH is not set=0A=
# end of SCSI device support=0A=
=0A=
CONFIG_ATA=3Dy=0A=
CONFIG_SATA_HOST=3Dy=0A=
CONFIG_PATA_TIMINGS=3Dy=0A=
CONFIG_ATA_VERBOSE_ERROR=3Dy=0A=
CONFIG_ATA_FORCE=3Dy=0A=
CONFIG_ATA_ACPI=3Dy=0A=
# CONFIG_SATA_ZPODD is not set=0A=
CONFIG_SATA_PMP=3Dy=0A=
=0A=
#=0A=
# Controllers with non-SFF native interface=0A=
#=0A=
CONFIG_SATA_AHCI=3Dy=0A=
CONFIG_SATA_MOBILE_LPM_POLICY=3D3=0A=
# CONFIG_SATA_AHCI_PLATFORM is not set=0A=
# CONFIG_AHCI_DWC is not set=0A=
# CONFIG_AHCI_CEVA is not set=0A=
# CONFIG_SATA_INIC162X is not set=0A=
# CONFIG_SATA_ACARD_AHCI is not set=0A=
# CONFIG_SATA_SIL24 is not set=0A=
CONFIG_ATA_SFF=3Dy=0A=
=0A=
#=0A=
# SFF controllers with custom DMA interface=0A=
#=0A=
# CONFIG_PDC_ADMA is not set=0A=
# CONFIG_SATA_QSTOR is not set=0A=
# CONFIG_SATA_SX4 is not set=0A=
CONFIG_ATA_BMDMA=3Dy=0A=
=0A=
#=0A=
# SATA SFF controllers with BMDMA=0A=
#=0A=
CONFIG_ATA_PIIX=3Dy=0A=
# CONFIG_SATA_DWC is not set=0A=
# CONFIG_SATA_MV is not set=0A=
# CONFIG_SATA_NV is not set=0A=
# CONFIG_SATA_PROMISE is not set=0A=
# CONFIG_SATA_SIL is not set=0A=
# CONFIG_SATA_SIS is not set=0A=
# CONFIG_SATA_SVW is not set=0A=
# CONFIG_SATA_ULI is not set=0A=
# CONFIG_SATA_VIA is not set=0A=
# CONFIG_SATA_VITESSE is not set=0A=
=0A=
#=0A=
# PATA SFF controllers with BMDMA=0A=
#=0A=
# CONFIG_PATA_ALI is not set=0A=
CONFIG_PATA_AMD=3Dy=0A=
# CONFIG_PATA_ARTOP is not set=0A=
# CONFIG_PATA_ATIIXP is not set=0A=
# CONFIG_PATA_ATP867X is not set=0A=
# CONFIG_PATA_CMD64X is not set=0A=
# CONFIG_PATA_CYPRESS is not set=0A=
# CONFIG_PATA_EFAR is not set=0A=
# CONFIG_PATA_HPT366 is not set=0A=
# CONFIG_PATA_HPT37X is not set=0A=
# CONFIG_PATA_HPT3X2N is not set=0A=
# CONFIG_PATA_HPT3X3 is not set=0A=
# CONFIG_PATA_IT8213 is not set=0A=
# CONFIG_PATA_IT821X is not set=0A=
# CONFIG_PATA_JMICRON is not set=0A=
# CONFIG_PATA_MARVELL is not set=0A=
# CONFIG_PATA_NETCELL is not set=0A=
# CONFIG_PATA_NINJA32 is not set=0A=
# CONFIG_PATA_NS87415 is not set=0A=
CONFIG_PATA_OLDPIIX=3Dy=0A=
# CONFIG_PATA_OPTIDMA is not set=0A=
# CONFIG_PATA_PDC2027X is not set=0A=
# CONFIG_PATA_PDC_OLD is not set=0A=
# CONFIG_PATA_RADISYS is not set=0A=
# CONFIG_PATA_RDC is not set=0A=
CONFIG_PATA_SCH=3Dy=0A=
# CONFIG_PATA_SERVERWORKS is not set=0A=
# CONFIG_PATA_SIL680 is not set=0A=
# CONFIG_PATA_SIS is not set=0A=
# CONFIG_PATA_TOSHIBA is not set=0A=
# CONFIG_PATA_TRIFLEX is not set=0A=
# CONFIG_PATA_VIA is not set=0A=
# CONFIG_PATA_WINBOND is not set=0A=
=0A=
#=0A=
# PIO-only SFF controllers=0A=
#=0A=
# CONFIG_PATA_CMD640_PCI is not set=0A=
# CONFIG_PATA_MPIIX is not set=0A=
# CONFIG_PATA_NS87410 is not set=0A=
# CONFIG_PATA_OPTI is not set=0A=
# CONFIG_PATA_PCMCIA is not set=0A=
# CONFIG_PATA_OF_PLATFORM is not set=0A=
# CONFIG_PATA_RZ1000 is not set=0A=
=0A=
#=0A=
# Generic fallback / legacy drivers=0A=
#=0A=
# CONFIG_PATA_ACPI is not set=0A=
CONFIG_ATA_GENERIC=3Dy=0A=
# CONFIG_PATA_LEGACY is not set=0A=
CONFIG_MD=3Dy=0A=
CONFIG_BLK_DEV_MD=3Dy=0A=
CONFIG_MD_AUTODETECT=3Dy=0A=
CONFIG_MD_BITMAP_FILE=3Dy=0A=
CONFIG_MD_RAID0=3Dy=0A=
CONFIG_MD_RAID1=3Dy=0A=
CONFIG_MD_RAID10=3Dy=0A=
CONFIG_MD_RAID456=3Dy=0A=
# CONFIG_MD_CLUSTER is not set=0A=
CONFIG_BCACHE=3Dy=0A=
# CONFIG_BCACHE_DEBUG is not set=0A=
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set=0A=
CONFIG_BLK_DEV_DM_BUILTIN=3Dy=0A=
CONFIG_BLK_DEV_DM=3Dy=0A=
# CONFIG_DM_DEBUG is not set=0A=
CONFIG_DM_BUFIO=3Dy=0A=
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set=0A=
CONFIG_DM_BIO_PRISON=3Dy=0A=
CONFIG_DM_PERSISTENT_DATA=3Dy=0A=
# CONFIG_DM_UNSTRIPED is not set=0A=
CONFIG_DM_CRYPT=3Dy=0A=
CONFIG_DM_SNAPSHOT=3Dy=0A=
CONFIG_DM_THIN_PROVISIONING=3Dy=0A=
CONFIG_DM_CACHE=3Dy=0A=
CONFIG_DM_CACHE_SMQ=3Dy=0A=
CONFIG_DM_WRITECACHE=3Dy=0A=
# CONFIG_DM_EBS is not set=0A=
# CONFIG_DM_ERA is not set=0A=
CONFIG_DM_CLONE=3Dy=0A=
CONFIG_DM_MIRROR=3Dy=0A=
# CONFIG_DM_LOG_USERSPACE is not set=0A=
CONFIG_DM_RAID=3Dy=0A=
CONFIG_DM_ZERO=3Dy=0A=
CONFIG_DM_MULTIPATH=3Dy=0A=
CONFIG_DM_MULTIPATH_QL=3Dy=0A=
CONFIG_DM_MULTIPATH_ST=3Dy=0A=
# CONFIG_DM_MULTIPATH_HST is not set=0A=
# CONFIG_DM_MULTIPATH_IOA is not set=0A=
# CONFIG_DM_DELAY is not set=0A=
# CONFIG_DM_DUST is not set=0A=
# CONFIG_DM_INIT is not set=0A=
CONFIG_DM_UEVENT=3Dy=0A=
CONFIG_DM_FLAKEY=3Dy=0A=
CONFIG_DM_VERITY=3Dy=0A=
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set=0A=
CONFIG_DM_VERITY_FEC=3Dy=0A=
# CONFIG_DM_SWITCH is not set=0A=
# CONFIG_DM_LOG_WRITES is not set=0A=
CONFIG_DM_INTEGRITY=3Dy=0A=
CONFIG_DM_ZONED=3Dy=0A=
CONFIG_DM_AUDIT=3Dy=0A=
# CONFIG_DM_VDO is not set=0A=
CONFIG_TARGET_CORE=3Dy=0A=
# CONFIG_TCM_IBLOCK is not set=0A=
# CONFIG_TCM_FILEIO is not set=0A=
# CONFIG_TCM_PSCSI is not set=0A=
# CONFIG_LOOPBACK_TARGET is not set=0A=
# CONFIG_ISCSI_TARGET is not set=0A=
# CONFIG_SBP_TARGET is not set=0A=
# CONFIG_REMOTE_TARGET is not set=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
CONFIG_FIREWIRE=3Dy=0A=
CONFIG_FIREWIRE_OHCI=3Dy=0A=
CONFIG_FIREWIRE_SBP2=3Dy=0A=
CONFIG_FIREWIRE_NET=3Dy=0A=
# CONFIG_FIREWIRE_NOSY is not set=0A=
# end of IEEE 1394 (FireWire) support=0A=
=0A=
# CONFIG_MACINTOSH_DRIVERS is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
CONFIG_MII=3Dy=0A=
CONFIG_NET_CORE=3Dy=0A=
CONFIG_BONDING=3Dy=0A=
CONFIG_DUMMY=3Dy=0A=
CONFIG_WIREGUARD=3Dy=0A=
# CONFIG_WIREGUARD_DEBUG is not set=0A=
CONFIG_EQUALIZER=3Dy=0A=
CONFIG_NET_FC=3Dy=0A=
CONFIG_IFB=3Dy=0A=
CONFIG_NET_TEAM=3Dy=0A=
CONFIG_NET_TEAM_MODE_BROADCAST=3Dy=0A=
CONFIG_NET_TEAM_MODE_ROUNDROBIN=3Dy=0A=
CONFIG_NET_TEAM_MODE_RANDOM=3Dy=0A=
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=3Dy=0A=
CONFIG_NET_TEAM_MODE_LOADBALANCE=3Dy=0A=
CONFIG_MACVLAN=3Dy=0A=
CONFIG_MACVTAP=3Dy=0A=
CONFIG_IPVLAN_L3S=3Dy=0A=
CONFIG_IPVLAN=3Dy=0A=
CONFIG_IPVTAP=3Dy=0A=
CONFIG_VXLAN=3Dy=0A=
CONFIG_GENEVE=3Dy=0A=
CONFIG_BAREUDP=3Dy=0A=
CONFIG_GTP=3Dy=0A=
# CONFIG_PFCP is not set=0A=
# CONFIG_AMT is not set=0A=
CONFIG_MACSEC=3Dy=0A=
CONFIG_NETCONSOLE=3Dy=0A=
# CONFIG_NETCONSOLE_DYNAMIC is not set=0A=
# CONFIG_NETCONSOLE_EXTENDED_LOG is not set=0A=
CONFIG_NETPOLL=3Dy=0A=
CONFIG_NET_POLL_CONTROLLER=3Dy=0A=
CONFIG_TUN=3Dy=0A=
CONFIG_TAP=3Dy=0A=
CONFIG_TUN_VNET_CROSS_LE=3Dy=0A=
CONFIG_VETH=3Dy=0A=
CONFIG_VIRTIO_NET=3Dy=0A=
CONFIG_NLMON=3Dy=0A=
# CONFIG_NETKIT is not set=0A=
CONFIG_NET_VRF=3Dy=0A=
CONFIG_VSOCKMON=3Dy=0A=
# CONFIG_MHI_NET is not set=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_ATM_DRIVERS=3Dy=0A=
# CONFIG_ATM_DUMMY is not set=0A=
CONFIG_ATM_TCP=3Dy=0A=
# CONFIG_ATM_LANAI is not set=0A=
# CONFIG_ATM_ENI is not set=0A=
# CONFIG_ATM_NICSTAR is not set=0A=
# CONFIG_ATM_IDT77252 is not set=0A=
# CONFIG_ATM_IA is not set=0A=
# CONFIG_ATM_FORE200E is not set=0A=
# CONFIG_ATM_HE is not set=0A=
# CONFIG_ATM_SOLOS is not set=0A=
CONFIG_CAIF_DRIVERS=3Dy=0A=
CONFIG_CAIF_TTY=3Dy=0A=
CONFIG_CAIF_VIRTIO=3Dy=0A=
=0A=
#=0A=
# Distributed Switch Architecture drivers=0A=
#=0A=
# CONFIG_B53 is not set=0A=
# CONFIG_NET_DSA_BCM_SF2 is not set=0A=
# CONFIG_NET_DSA_LOOP is not set=0A=
# CONFIG_NET_DSA_HIRSCHMANN_HELLCREEK is not set=0A=
# CONFIG_NET_DSA_LANTIQ_GSWIP is not set=0A=
# CONFIG_NET_DSA_MT7530 is not set=0A=
# CONFIG_NET_DSA_MV88E6060 is not set=0A=
# CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON is not set=0A=
# CONFIG_NET_DSA_MV88E6XXX is not set=0A=
# CONFIG_NET_DSA_AR9331 is not set=0A=
# CONFIG_NET_DSA_QCA8K is not set=0A=
# CONFIG_NET_DSA_SJA1105 is not set=0A=
# CONFIG_NET_DSA_XRS700X_I2C is not set=0A=
# CONFIG_NET_DSA_XRS700X_MDIO is not set=0A=
# CONFIG_NET_DSA_REALTEK is not set=0A=
# CONFIG_NET_DSA_SMSC_LAN9303_I2C is not set=0A=
# CONFIG_NET_DSA_SMSC_LAN9303_MDIO is not set=0A=
# CONFIG_NET_DSA_VITESSE_VSC73XX_SPI is not set=0A=
# CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set=0A=
# end of Distributed Switch Architecture drivers=0A=
=0A=
CONFIG_ETHERNET=3Dy=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_NET_VENDOR_ADAPTEC is not set=0A=
# CONFIG_NET_VENDOR_AGERE is not set=0A=
# CONFIG_NET_VENDOR_ALACRITECH is not set=0A=
CONFIG_NET_VENDOR_ALTEON=3Dy=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_ALTERA_TSE is not set=0A=
CONFIG_NET_VENDOR_AMAZON=3Dy=0A=
# CONFIG_ENA_ETHERNET is not set=0A=
# CONFIG_NET_VENDOR_AMD is not set=0A=
# CONFIG_NET_VENDOR_AQUANTIA is not set=0A=
# CONFIG_NET_VENDOR_ARC is not set=0A=
CONFIG_NET_VENDOR_ASIX=3Dy=0A=
# CONFIG_SPI_AX88796C is not set=0A=
# CONFIG_NET_VENDOR_ATHEROS is not set=0A=
# CONFIG_CX_ECAT is not set=0A=
# CONFIG_NET_VENDOR_BROADCOM is not set=0A=
# CONFIG_NET_VENDOR_CADENCE is not set=0A=
# CONFIG_NET_VENDOR_CAVIUM is not set=0A=
# CONFIG_NET_VENDOR_CHELSIO is not set=0A=
CONFIG_NET_VENDOR_CISCO=3Dy=0A=
# CONFIG_ENIC is not set=0A=
# CONFIG_NET_VENDOR_CORTINA is not set=0A=
CONFIG_NET_VENDOR_DAVICOM=3Dy=0A=
# CONFIG_DM9051 is not set=0A=
# CONFIG_DNET is not set=0A=
# CONFIG_NET_VENDOR_DEC is not set=0A=
# CONFIG_NET_VENDOR_DLINK is not set=0A=
# CONFIG_NET_VENDOR_EMULEX is not set=0A=
CONFIG_NET_VENDOR_ENGLEDER=3Dy=0A=
# CONFIG_TSNEP is not set=0A=
# CONFIG_NET_VENDOR_EZCHIP is not set=0A=
# CONFIG_NET_VENDOR_FUJITSU is not set=0A=
CONFIG_NET_VENDOR_FUNGIBLE=3Dy=0A=
# CONFIG_FUN_ETH is not set=0A=
CONFIG_NET_VENDOR_GOOGLE=3Dy=0A=
CONFIG_GVE=3Dy=0A=
CONFIG_NET_VENDOR_HISILICON=3Dy=0A=
# CONFIG_HIBMCGE is not set=0A=
# CONFIG_NET_VENDOR_HUAWEI is not set=0A=
CONFIG_NET_VENDOR_I825XX=3Dy=0A=
CONFIG_NET_VENDOR_INTEL=3Dy=0A=
CONFIG_E100=3Dy=0A=
CONFIG_E1000=3Dy=0A=
CONFIG_E1000E=3Dy=0A=
CONFIG_E1000E_HWTS=3Dy=0A=
# CONFIG_IGB is not set=0A=
# CONFIG_IGBVF is not set=0A=
# CONFIG_IXGBE is not set=0A=
# CONFIG_IXGBEVF is not set=0A=
# CONFIG_I40E is not set=0A=
# CONFIG_I40EVF is not set=0A=
# CONFIG_ICE is not set=0A=
# CONFIG_FM10K is not set=0A=
# CONFIG_IGC is not set=0A=
# CONFIG_IDPF is not set=0A=
# CONFIG_JME is not set=0A=
# CONFIG_NET_VENDOR_ADI is not set=0A=
CONFIG_NET_VENDOR_LITEX=3Dy=0A=
# CONFIG_LITEX_LITEETH is not set=0A=
# CONFIG_NET_VENDOR_MARVELL is not set=0A=
CONFIG_NET_VENDOR_MELLANOX=3Dy=0A=
# CONFIG_MLX4_EN is not set=0A=
CONFIG_MLX4_CORE=3Dy=0A=
# CONFIG_MLX4_DEBUG is not set=0A=
# CONFIG_MLX4_CORE_GEN2 is not set=0A=
# CONFIG_MLX5_CORE is not set=0A=
# CONFIG_MLXSW_CORE is not set=0A=
# CONFIG_MLXFW is not set=0A=
CONFIG_NET_VENDOR_META=3Dy=0A=
# CONFIG_FBNIC is not set=0A=
# CONFIG_NET_VENDOR_MICREL is not set=0A=
# CONFIG_NET_VENDOR_MICROCHIP is not set=0A=
# CONFIG_NET_VENDOR_MICROSEMI is not set=0A=
CONFIG_NET_VENDOR_MICROSOFT=3Dy=0A=
# CONFIG_NET_VENDOR_MYRI is not set=0A=
# CONFIG_FEALNX is not set=0A=
# CONFIG_NET_VENDOR_NI is not set=0A=
# CONFIG_NET_VENDOR_NATSEMI is not set=0A=
# CONFIG_NET_VENDOR_NETERION is not set=0A=
# CONFIG_NET_VENDOR_NETRONOME is not set=0A=
# CONFIG_NET_VENDOR_NVIDIA is not set=0A=
# CONFIG_NET_VENDOR_OKI is not set=0A=
# CONFIG_ETHOC is not set=0A=
# CONFIG_OA_TC6 is not set=0A=
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set=0A=
# CONFIG_NET_VENDOR_PENSANDO is not set=0A=
# CONFIG_NET_VENDOR_QLOGIC is not set=0A=
# CONFIG_NET_VENDOR_BROCADE is not set=0A=
# CONFIG_NET_VENDOR_QUALCOMM is not set=0A=
# CONFIG_NET_VENDOR_RDC is not set=0A=
# CONFIG_NET_VENDOR_REALTEK is not set=0A=
# CONFIG_NET_VENDOR_RENESAS is not set=0A=
# CONFIG_NET_VENDOR_ROCKER is not set=0A=
# CONFIG_NET_VENDOR_SAMSUNG is not set=0A=
# CONFIG_NET_VENDOR_SEEQ is not set=0A=
# CONFIG_NET_VENDOR_SILAN is not set=0A=
# CONFIG_NET_VENDOR_SIS is not set=0A=
# CONFIG_NET_VENDOR_SOLARFLARE is not set=0A=
# CONFIG_NET_VENDOR_SMSC is not set=0A=
# CONFIG_NET_VENDOR_SOCIONEXT is not set=0A=
# CONFIG_NET_VENDOR_STMICRO is not set=0A=
# CONFIG_NET_VENDOR_SUN is not set=0A=
# CONFIG_NET_VENDOR_SYNOPSYS is not set=0A=
# CONFIG_NET_VENDOR_TEHUTI is not set=0A=
# CONFIG_NET_VENDOR_TI is not set=0A=
CONFIG_NET_VENDOR_VERTEXCOM=3Dy=0A=
# CONFIG_MSE102X is not set=0A=
# CONFIG_NET_VENDOR_VIA is not set=0A=
CONFIG_NET_VENDOR_WANGXUN=3Dy=0A=
# CONFIG_NGBE is not set=0A=
# CONFIG_TXGBE is not set=0A=
# CONFIG_NET_VENDOR_WIZNET is not set=0A=
# CONFIG_NET_VENDOR_XILINX is not set=0A=
# CONFIG_NET_VENDOR_XIRCOM is not set=0A=
CONFIG_FDDI=3Dy=0A=
# CONFIG_DEFXX is not set=0A=
# CONFIG_SKFP is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PHYLINK=3Dy=0A=
CONFIG_PHYLIB=3Dy=0A=
CONFIG_SWPHY=3Dy=0A=
# CONFIG_LED_TRIGGER_PHY is not set=0A=
CONFIG_PHYLIB_LEDS=3Dy=0A=
CONFIG_FIXED_PHY=3Dy=0A=
# CONFIG_SFP is not set=0A=
=0A=
#=0A=
# MII PHY device drivers=0A=
#=0A=
# CONFIG_AIR_EN8811H_PHY is not set=0A=
# CONFIG_AMD_PHY is not set=0A=
# CONFIG_ADIN_PHY is not set=0A=
# CONFIG_ADIN1100_PHY is not set=0A=
# CONFIG_AQUANTIA_PHY is not set=0A=
CONFIG_AX88796B_PHY=3Dy=0A=
# CONFIG_BROADCOM_PHY is not set=0A=
# CONFIG_BCM54140_PHY is not set=0A=
# CONFIG_BCM7XXX_PHY is not set=0A=
# CONFIG_BCM84881_PHY is not set=0A=
# CONFIG_BCM87XX_PHY is not set=0A=
# CONFIG_CICADA_PHY is not set=0A=
# CONFIG_CORTINA_PHY is not set=0A=
# CONFIG_DAVICOM_PHY is not set=0A=
# CONFIG_ICPLUS_PHY is not set=0A=
# CONFIG_LXT_PHY is not set=0A=
# CONFIG_INTEL_XWAY_PHY is not set=0A=
# CONFIG_LSI_ET1011C_PHY is not set=0A=
# CONFIG_MARVELL_PHY is not set=0A=
# CONFIG_MARVELL_10G_PHY is not set=0A=
# CONFIG_MARVELL_88Q2XXX_PHY is not set=0A=
# CONFIG_MARVELL_88X2222_PHY is not set=0A=
# CONFIG_MAXLINEAR_GPHY is not set=0A=
# CONFIG_MEDIATEK_GE_PHY is not set=0A=
# CONFIG_MICREL_PHY is not set=0A=
# CONFIG_MICROCHIP_T1S_PHY is not set=0A=
CONFIG_MICROCHIP_PHY=3Dy=0A=
# CONFIG_MICROCHIP_T1_PHY is not set=0A=
# CONFIG_MICROSEMI_PHY is not set=0A=
# CONFIG_MOTORCOMM_PHY is not set=0A=
# CONFIG_NATIONAL_PHY is not set=0A=
# CONFIG_NXP_CBTX_PHY is not set=0A=
# CONFIG_NXP_C45_TJA11XX_PHY is not set=0A=
# CONFIG_NXP_TJA11XX_PHY is not set=0A=
# CONFIG_NCN26000_PHY is not set=0A=
# CONFIG_AT803X_PHY is not set=0A=
# CONFIG_QCA83XX_PHY is not set=0A=
# CONFIG_QCA808X_PHY is not set=0A=
# CONFIG_QCA807X_PHY is not set=0A=
# CONFIG_QSEMI_PHY is not set=0A=
CONFIG_REALTEK_PHY=3Dy=0A=
# CONFIG_RENESAS_PHY is not set=0A=
# CONFIG_ROCKCHIP_PHY is not set=0A=
CONFIG_SMSC_PHY=3Dy=0A=
# CONFIG_STE10XP is not set=0A=
# CONFIG_TERANETICS_PHY is not set=0A=
# CONFIG_DP83822_PHY is not set=0A=
# CONFIG_DP83TC811_PHY is not set=0A=
# CONFIG_DP83848_PHY is not set=0A=
# CONFIG_DP83867_PHY is not set=0A=
# CONFIG_DP83869_PHY is not set=0A=
# CONFIG_DP83TD510_PHY is not set=0A=
# CONFIG_DP83TG720_PHY is not set=0A=
# CONFIG_VITESSE_PHY is not set=0A=
# CONFIG_XILINX_GMII2RGMII is not set=0A=
# CONFIG_MICREL_KS8995MA is not set=0A=
# CONFIG_PSE_CONTROLLER is not set=0A=
CONFIG_CAN_DEV=3Dy=0A=
CONFIG_CAN_VCAN=3Dy=0A=
CONFIG_CAN_VXCAN=3Dy=0A=
CONFIG_CAN_NETLINK=3Dy=0A=
CONFIG_CAN_CALC_BITTIMING=3Dy=0A=
CONFIG_CAN_RX_OFFLOAD=3Dy=0A=
# CONFIG_CAN_CAN327 is not set=0A=
# CONFIG_CAN_FLEXCAN is not set=0A=
# CONFIG_CAN_GRCAN is not set=0A=
# CONFIG_CAN_KVASER_PCIEFD is not set=0A=
CONFIG_CAN_SLCAN=3Dy=0A=
# CONFIG_CAN_C_CAN is not set=0A=
# CONFIG_CAN_CC770 is not set=0A=
# CONFIG_CAN_CTUCANFD_PCI is not set=0A=
# CONFIG_CAN_CTUCANFD_PLATFORM is not set=0A=
# CONFIG_CAN_ESD_402_PCI is not set=0A=
CONFIG_CAN_IFI_CANFD=3Dy=0A=
# CONFIG_CAN_M_CAN is not set=0A=
# CONFIG_CAN_PEAK_PCIEFD is not set=0A=
# CONFIG_CAN_SJA1000 is not set=0A=
# CONFIG_CAN_SOFTING is not set=0A=
=0A=
#=0A=
# CAN SPI interfaces=0A=
#=0A=
# CONFIG_CAN_HI311X is not set=0A=
# CONFIG_CAN_MCP251X is not set=0A=
# CONFIG_CAN_MCP251XFD is not set=0A=
# end of CAN SPI interfaces=0A=
=0A=
#=0A=
# CAN USB interfaces=0A=
#=0A=
CONFIG_CAN_8DEV_USB=3Dy=0A=
CONFIG_CAN_EMS_USB=3Dy=0A=
CONFIG_CAN_ESD_USB=3Dy=0A=
CONFIG_CAN_ETAS_ES58X=3Dy=0A=
CONFIG_CAN_F81604=3Dy=0A=
CONFIG_CAN_GS_USB=3Dy=0A=
CONFIG_CAN_KVASER_USB=3Dy=0A=
CONFIG_CAN_MCBA_USB=3Dy=0A=
CONFIG_CAN_PEAK_USB=3Dy=0A=
CONFIG_CAN_UCAN=3Dy=0A=
# end of CAN USB interfaces=0A=
=0A=
# CONFIG_CAN_DEBUG_DEVICES is not set=0A=
CONFIG_MDIO_DEVICE=3Dy=0A=
CONFIG_MDIO_BUS=3Dy=0A=
CONFIG_FWNODE_MDIO=3Dy=0A=
CONFIG_OF_MDIO=3Dy=0A=
CONFIG_ACPI_MDIO=3Dy=0A=
CONFIG_MDIO_DEVRES=3Dy=0A=
# CONFIG_MDIO_BITBANG is not set=0A=
# CONFIG_MDIO_BCM_UNIMAC is not set=0A=
# CONFIG_MDIO_HISI_FEMAC is not set=0A=
CONFIG_MDIO_MVUSB=3Dy=0A=
# CONFIG_MDIO_MSCC_MIIM is not set=0A=
# CONFIG_MDIO_OCTEON is not set=0A=
# CONFIG_MDIO_IPQ4019 is not set=0A=
# CONFIG_MDIO_IPQ8064 is not set=0A=
# CONFIG_MDIO_THUNDER is not set=0A=
=0A=
#=0A=
# MDIO Multiplexers=0A=
#=0A=
# CONFIG_MDIO_BUS_MUX_GPIO is not set=0A=
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set=0A=
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set=0A=
=0A=
#=0A=
# PCS device drivers=0A=
#=0A=
# CONFIG_PCS_XPCS is not set=0A=
# end of PCS device drivers=0A=
=0A=
# CONFIG_PLIP is not set=0A=
CONFIG_PPP=3Dy=0A=
CONFIG_PPP_BSDCOMP=3Dy=0A=
CONFIG_PPP_DEFLATE=3Dy=0A=
CONFIG_PPP_FILTER=3Dy=0A=
CONFIG_PPP_MPPE=3Dy=0A=
CONFIG_PPP_MULTILINK=3Dy=0A=
CONFIG_PPPOATM=3Dy=0A=
CONFIG_PPPOE=3Dy=0A=
CONFIG_PPPOE_HASH_BITS_1=3Dy=0A=
# CONFIG_PPPOE_HASH_BITS_2 is not set=0A=
# CONFIG_PPPOE_HASH_BITS_4 is not set=0A=
# CONFIG_PPPOE_HASH_BITS_8 is not set=0A=
CONFIG_PPPOE_HASH_BITS=3D1=0A=
CONFIG_PPTP=3Dy=0A=
CONFIG_PPPOL2TP=3Dy=0A=
CONFIG_PPP_ASYNC=3Dy=0A=
CONFIG_PPP_SYNC_TTY=3Dy=0A=
CONFIG_SLIP=3Dy=0A=
CONFIG_SLHC=3Dy=0A=
CONFIG_SLIP_COMPRESSED=3Dy=0A=
CONFIG_SLIP_SMART=3Dy=0A=
CONFIG_SLIP_MODE_SLIP6=3Dy=0A=
CONFIG_USB_NET_DRIVERS=3Dy=0A=
CONFIG_USB_CATC=3Dy=0A=
CONFIG_USB_KAWETH=3Dy=0A=
CONFIG_USB_PEGASUS=3Dy=0A=
CONFIG_USB_RTL8150=3Dy=0A=
CONFIG_USB_RTL8152=3Dy=0A=
CONFIG_USB_LAN78XX=3Dy=0A=
CONFIG_USB_USBNET=3Dy=0A=
CONFIG_USB_NET_AX8817X=3Dy=0A=
CONFIG_USB_NET_AX88179_178A=3Dy=0A=
CONFIG_USB_NET_CDCETHER=3Dy=0A=
CONFIG_USB_NET_CDC_EEM=3Dy=0A=
CONFIG_USB_NET_CDC_NCM=3Dy=0A=
CONFIG_USB_NET_HUAWEI_CDC_NCM=3Dy=0A=
CONFIG_USB_NET_CDC_MBIM=3Dy=0A=
CONFIG_USB_NET_DM9601=3Dy=0A=
CONFIG_USB_NET_SR9700=3Dy=0A=
CONFIG_USB_NET_SR9800=3Dy=0A=
CONFIG_USB_NET_SMSC75XX=3Dy=0A=
CONFIG_USB_NET_SMSC95XX=3Dy=0A=
CONFIG_USB_NET_GL620A=3Dy=0A=
CONFIG_USB_NET_NET1080=3Dy=0A=
CONFIG_USB_NET_PLUSB=3Dy=0A=
CONFIG_USB_NET_MCS7830=3Dy=0A=
CONFIG_USB_NET_RNDIS_HOST=3Dy=0A=
CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dy=0A=
CONFIG_USB_NET_CDC_SUBSET=3Dy=0A=
CONFIG_USB_ALI_M5632=3Dy=0A=
CONFIG_USB_AN2720=3Dy=0A=
CONFIG_USB_BELKIN=3Dy=0A=
CONFIG_USB_ARMLINUX=3Dy=0A=
CONFIG_USB_EPSON2888=3Dy=0A=
CONFIG_USB_KC2190=3Dy=0A=
CONFIG_USB_NET_ZAURUS=3Dy=0A=
CONFIG_USB_NET_CX82310_ETH=3Dy=0A=
CONFIG_USB_NET_KALMIA=3Dy=0A=
CONFIG_USB_NET_QMI_WWAN=3Dy=0A=
CONFIG_USB_HSO=3Dy=0A=
CONFIG_USB_NET_INT51X1=3Dy=0A=
CONFIG_USB_CDC_PHONET=3Dy=0A=
CONFIG_USB_IPHETH=3Dy=0A=
CONFIG_USB_SIERRA_NET=3Dy=0A=
CONFIG_USB_VL600=3Dy=0A=
CONFIG_USB_NET_CH9200=3Dy=0A=
CONFIG_USB_NET_AQC111=3Dy=0A=
CONFIG_USB_RTL8153_ECM=3Dy=0A=
CONFIG_WLAN=3Dy=0A=
CONFIG_WLAN_VENDOR_ADMTEK=3Dy=0A=
# CONFIG_ADM8211 is not set=0A=
CONFIG_ATH_COMMON=3Dy=0A=
CONFIG_WLAN_VENDOR_ATH=3Dy=0A=
# CONFIG_ATH_DEBUG is not set=0A=
# CONFIG_ATH5K is not set=0A=
# CONFIG_ATH5K_PCI is not set=0A=
CONFIG_ATH9K_HW=3Dy=0A=
CONFIG_ATH9K_COMMON=3Dy=0A=
CONFIG_ATH9K_COMMON_DEBUG=3Dy=0A=
CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy=0A=
CONFIG_ATH9K=3Dy=0A=
CONFIG_ATH9K_PCI=3Dy=0A=
CONFIG_ATH9K_AHB=3Dy=0A=
CONFIG_ATH9K_DEBUGFS=3Dy=0A=
# CONFIG_ATH9K_STATION_STATISTICS is not set=0A=
CONFIG_ATH9K_DYNACK=3Dy=0A=
# CONFIG_ATH9K_WOW is not set=0A=
CONFIG_ATH9K_RFKILL=3Dy=0A=
CONFIG_ATH9K_CHANNEL_CONTEXT=3Dy=0A=
CONFIG_ATH9K_PCOEM=3Dy=0A=
# CONFIG_ATH9K_PCI_NO_EEPROM is not set=0A=
CONFIG_ATH9K_HTC=3Dy=0A=
CONFIG_ATH9K_HTC_DEBUGFS=3Dy=0A=
# CONFIG_ATH9K_HWRNG is not set=0A=
CONFIG_ATH9K_COMMON_SPECTRAL=3Dy=0A=
CONFIG_CARL9170=3Dy=0A=
CONFIG_CARL9170_LEDS=3Dy=0A=
# CONFIG_CARL9170_DEBUGFS is not set=0A=
CONFIG_CARL9170_WPC=3Dy=0A=
CONFIG_CARL9170_HWRNG=3Dy=0A=
CONFIG_ATH6KL=3Dy=0A=
# CONFIG_ATH6KL_SDIO is not set=0A=
CONFIG_ATH6KL_USB=3Dy=0A=
# CONFIG_ATH6KL_DEBUG is not set=0A=
# CONFIG_ATH6KL_TRACING is not set=0A=
CONFIG_AR5523=3Dy=0A=
# CONFIG_WIL6210 is not set=0A=
CONFIG_ATH10K=3Dy=0A=
CONFIG_ATH10K_CE=3Dy=0A=
CONFIG_ATH10K_PCI=3Dy=0A=
# CONFIG_ATH10K_AHB is not set=0A=
# CONFIG_ATH10K_SDIO is not set=0A=
CONFIG_ATH10K_USB=3Dy=0A=
# CONFIG_ATH10K_DEBUG is not set=0A=
# CONFIG_ATH10K_DEBUGFS is not set=0A=
CONFIG_ATH10K_LEDS=3Dy=0A=
# CONFIG_ATH10K_TRACING is not set=0A=
# CONFIG_WCN36XX is not set=0A=
CONFIG_ATH11K=3Dy=0A=
# CONFIG_ATH11K_PCI is not set=0A=
# CONFIG_ATH11K_DEBUG is not set=0A=
# CONFIG_ATH11K_DEBUGFS is not set=0A=
# CONFIG_ATH11K_TRACING is not set=0A=
# CONFIG_ATH12K is not set=0A=
# CONFIG_WLAN_VENDOR_ATMEL is not set=0A=
# CONFIG_WLAN_VENDOR_BROADCOM is not set=0A=
# CONFIG_WLAN_VENDOR_INTEL is not set=0A=
# CONFIG_WLAN_VENDOR_INTERSIL is not set=0A=
# CONFIG_WLAN_VENDOR_MARVELL is not set=0A=
# CONFIG_WLAN_VENDOR_MEDIATEK is not set=0A=
# CONFIG_WLAN_VENDOR_MICROCHIP is not set=0A=
CONFIG_WLAN_VENDOR_PURELIFI=3Dy=0A=
CONFIG_PLFXLC=3Dy=0A=
# CONFIG_WLAN_VENDOR_RALINK is not set=0A=
# CONFIG_WLAN_VENDOR_REALTEK is not set=0A=
# CONFIG_WLAN_VENDOR_RSI is not set=0A=
CONFIG_WLAN_VENDOR_SILABS=3Dy=0A=
# CONFIG_WFX is not set=0A=
# CONFIG_WLAN_VENDOR_ST is not set=0A=
# CONFIG_WLAN_VENDOR_TI is not set=0A=
# CONFIG_WLAN_VENDOR_ZYDAS is not set=0A=
# CONFIG_WLAN_VENDOR_QUANTENNA is not set=0A=
CONFIG_MAC80211_HWSIM=3Dy=0A=
CONFIG_VIRT_WIFI=3Dy=0A=
CONFIG_WAN=3Dy=0A=
CONFIG_HDLC=3Dy=0A=
CONFIG_HDLC_RAW=3Dy=0A=
CONFIG_HDLC_RAW_ETH=3Dy=0A=
CONFIG_HDLC_CISCO=3Dy=0A=
CONFIG_HDLC_FR=3Dy=0A=
CONFIG_HDLC_PPP=3Dy=0A=
CONFIG_HDLC_X25=3Dy=0A=
# CONFIG_FRAMER is not set=0A=
# CONFIG_PCI200SYN is not set=0A=
# CONFIG_WANXL is not set=0A=
# CONFIG_PC300TOO is not set=0A=
# CONFIG_FARSYNC is not set=0A=
CONFIG_LAPBETHER=3Dy=0A=
CONFIG_IEEE802154_DRIVERS=3Dy=0A=
# CONFIG_IEEE802154_FAKELB is not set=0A=
# CONFIG_IEEE802154_AT86RF230 is not set=0A=
# CONFIG_IEEE802154_MRF24J40 is not set=0A=
# CONFIG_IEEE802154_CC2520 is not set=0A=
CONFIG_IEEE802154_ATUSB=3Dy=0A=
# CONFIG_IEEE802154_ADF7242 is not set=0A=
# CONFIG_IEEE802154_CA8210 is not set=0A=
# CONFIG_IEEE802154_MCR20A is not set=0A=
CONFIG_IEEE802154_HWSIM=3Dy=0A=
=0A=
#=0A=
# Wireless WAN=0A=
#=0A=
CONFIG_WWAN=3Dy=0A=
# CONFIG_WWAN_DEBUGFS is not set=0A=
# CONFIG_WWAN_HWSIM is not set=0A=
CONFIG_MHI_WWAN_CTRL=3Dy=0A=
# CONFIG_MHI_WWAN_MBIM is not set=0A=
# CONFIG_IOSM is not set=0A=
# CONFIG_MTK_T7XX is not set=0A=
# end of Wireless WAN=0A=
=0A=
CONFIG_VMXNET3=3Dy=0A=
# CONFIG_FUJITSU_ES is not set=0A=
CONFIG_USB4_NET=3Dy=0A=
CONFIG_NETDEVSIM=3Dy=0A=
CONFIG_NET_FAILOVER=3Dy=0A=
CONFIG_ISDN=3Dy=0A=
CONFIG_ISDN_CAPI=3Dy=0A=
CONFIG_MISDN=3Dy=0A=
CONFIG_MISDN_DSP=3Dy=0A=
CONFIG_MISDN_L1OIP=3Dy=0A=
=0A=
#=0A=
# mISDN hardware drivers=0A=
#=0A=
# CONFIG_MISDN_HFCPCI is not set=0A=
# CONFIG_MISDN_HFCMULTI is not set=0A=
CONFIG_MISDN_HFCUSB=3Dy=0A=
# CONFIG_MISDN_AVMFRITZ is not set=0A=
# CONFIG_MISDN_SPEEDFAX is not set=0A=
# CONFIG_MISDN_INFINEON is not set=0A=
# CONFIG_MISDN_W6692 is not set=0A=
# CONFIG_MISDN_NETJET is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
CONFIG_INPUT_LEDS=3Dy=0A=
CONFIG_INPUT_FF_MEMLESS=3Dy=0A=
CONFIG_INPUT_SPARSEKMAP=3Dy=0A=
# CONFIG_INPUT_MATRIXKMAP is not set=0A=
CONFIG_INPUT_VIVALDIFMAP=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
CONFIG_INPUT_JOYDEV=3Dy=0A=
CONFIG_INPUT_EVDEV=3Dy=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
# CONFIG_KEYBOARD_ADC is not set=0A=
# CONFIG_KEYBOARD_ADP5588 is not set=0A=
# CONFIG_KEYBOARD_ADP5589 is not set=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_QT1050 is not set=0A=
# CONFIG_KEYBOARD_QT1070 is not set=0A=
# CONFIG_KEYBOARD_QT2160 is not set=0A=
# CONFIG_KEYBOARD_DLINK_DIR685 is not set=0A=
# CONFIG_KEYBOARD_LKKBD is not set=0A=
# CONFIG_KEYBOARD_GPIO is not set=0A=
# CONFIG_KEYBOARD_GPIO_POLLED is not set=0A=
# CONFIG_KEYBOARD_TCA6416 is not set=0A=
# CONFIG_KEYBOARD_TCA8418 is not set=0A=
# CONFIG_KEYBOARD_MATRIX is not set=0A=
# CONFIG_KEYBOARD_LM8323 is not set=0A=
# CONFIG_KEYBOARD_LM8333 is not set=0A=
# CONFIG_KEYBOARD_MAX7359 is not set=0A=
# CONFIG_KEYBOARD_MPR121 is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
# CONFIG_KEYBOARD_OPENCORES is not set=0A=
# CONFIG_KEYBOARD_PINEPHONE is not set=0A=
# CONFIG_KEYBOARD_SAMSUNG is not set=0A=
# CONFIG_KEYBOARD_STOWAWAY is not set=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_OMAP4 is not set=0A=
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set=0A=
# CONFIG_KEYBOARD_TWL4030 is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_CAP11XX is not set=0A=
# CONFIG_KEYBOARD_BCM is not set=0A=
# CONFIG_KEYBOARD_CYPRESS_SF is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dy=0A=
CONFIG_MOUSE_PS2_ALPS=3Dy=0A=
CONFIG_MOUSE_PS2_BYD=3Dy=0A=
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy=0A=
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy=0A=
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy=0A=
CONFIG_MOUSE_PS2_CYPRESS=3Dy=0A=
CONFIG_MOUSE_PS2_LIFEBOOK=3Dy=0A=
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy=0A=
# CONFIG_MOUSE_PS2_ELANTECH is not set=0A=
# CONFIG_MOUSE_PS2_SENTELIC is not set=0A=
# CONFIG_MOUSE_PS2_TOUCHKIT is not set=0A=
CONFIG_MOUSE_PS2_FOCALTECH=3Dy=0A=
# CONFIG_MOUSE_PS2_VMMOUSE is not set=0A=
CONFIG_MOUSE_PS2_SMBUS=3Dy=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
CONFIG_MOUSE_APPLETOUCH=3Dy=0A=
CONFIG_MOUSE_BCM5974=3Dy=0A=
# CONFIG_MOUSE_CYAPA is not set=0A=
# CONFIG_MOUSE_ELAN_I2C is not set=0A=
# CONFIG_MOUSE_VSXXXAA is not set=0A=
# CONFIG_MOUSE_GPIO is not set=0A=
# CONFIG_MOUSE_SYNAPTICS_I2C is not set=0A=
CONFIG_MOUSE_SYNAPTICS_USB=3Dy=0A=
CONFIG_INPUT_JOYSTICK=3Dy=0A=
# CONFIG_JOYSTICK_ANALOG is not set=0A=
# CONFIG_JOYSTICK_A3D is not set=0A=
# CONFIG_JOYSTICK_ADC is not set=0A=
# CONFIG_JOYSTICK_ADI is not set=0A=
# CONFIG_JOYSTICK_COBRA is not set=0A=
# CONFIG_JOYSTICK_GF2K is not set=0A=
# CONFIG_JOYSTICK_GRIP is not set=0A=
# CONFIG_JOYSTICK_GRIP_MP is not set=0A=
# CONFIG_JOYSTICK_GUILLEMOT is not set=0A=
# CONFIG_JOYSTICK_INTERACT is not set=0A=
# CONFIG_JOYSTICK_SIDEWINDER is not set=0A=
# CONFIG_JOYSTICK_TMDC is not set=0A=
CONFIG_JOYSTICK_IFORCE=3Dy=0A=
CONFIG_JOYSTICK_IFORCE_USB=3Dy=0A=
# CONFIG_JOYSTICK_IFORCE_232 is not set=0A=
# CONFIG_JOYSTICK_WARRIOR is not set=0A=
# CONFIG_JOYSTICK_MAGELLAN is not set=0A=
# CONFIG_JOYSTICK_SPACEORB is not set=0A=
# CONFIG_JOYSTICK_SPACEBALL is not set=0A=
# CONFIG_JOYSTICK_STINGER is not set=0A=
# CONFIG_JOYSTICK_TWIDJOY is not set=0A=
# CONFIG_JOYSTICK_ZHENHUA is not set=0A=
# CONFIG_JOYSTICK_DB9 is not set=0A=
# CONFIG_JOYSTICK_GAMECON is not set=0A=
# CONFIG_JOYSTICK_TURBOGRAFX is not set=0A=
# CONFIG_JOYSTICK_AS5011 is not set=0A=
# CONFIG_JOYSTICK_JOYDUMP is not set=0A=
CONFIG_JOYSTICK_XPAD=3Dy=0A=
CONFIG_JOYSTICK_XPAD_FF=3Dy=0A=
CONFIG_JOYSTICK_XPAD_LEDS=3Dy=0A=
# CONFIG_JOYSTICK_WALKERA0701 is not set=0A=
# CONFIG_JOYSTICK_PSXPAD_SPI is not set=0A=
CONFIG_JOYSTICK_PXRC=3Dy=0A=
# CONFIG_JOYSTICK_QWIIC is not set=0A=
# CONFIG_JOYSTICK_FSIA6B is not set=0A=
# CONFIG_JOYSTICK_SENSEHAT is not set=0A=
# CONFIG_JOYSTICK_SEESAW is not set=0A=
CONFIG_INPUT_TABLET=3Dy=0A=
CONFIG_TABLET_USB_ACECAD=3Dy=0A=
CONFIG_TABLET_USB_AIPTEK=3Dy=0A=
CONFIG_TABLET_USB_HANWANG=3Dy=0A=
CONFIG_TABLET_USB_KBTAB=3Dy=0A=
CONFIG_TABLET_USB_PEGASUS=3Dy=0A=
# CONFIG_TABLET_SERIAL_WACOM4 is not set=0A=
CONFIG_INPUT_TOUCHSCREEN=3Dy=0A=
# CONFIG_TOUCHSCREEN_ADS7846 is not set=0A=
# CONFIG_TOUCHSCREEN_AD7877 is not set=0A=
# CONFIG_TOUCHSCREEN_AD7879 is not set=0A=
# CONFIG_TOUCHSCREEN_ADC is not set=0A=
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set=0A=
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set=0A=
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set=0A=
# CONFIG_TOUCHSCREEN_BU21013 is not set=0A=
# CONFIG_TOUCHSCREEN_BU21029 is not set=0A=
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set=0A=
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set=0A=
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set=0A=
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set=0A=
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set=0A=
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set=0A=
# CONFIG_TOUCHSCREEN_DYNAPRO is not set=0A=
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set=0A=
# CONFIG_TOUCHSCREEN_EETI is not set=0A=
# CONFIG_TOUCHSCREEN_EGALAX is not set=0A=
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set=0A=
# CONFIG_TOUCHSCREEN_EXC3000 is not set=0A=
# CONFIG_TOUCHSCREEN_FUJITSU is not set=0A=
# CONFIG_TOUCHSCREEN_GOODIX is not set=0A=
# CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C is not set=0A=
# CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI is not set=0A=
# CONFIG_TOUCHSCREEN_HIDEEP is not set=0A=
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set=0A=
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set=0A=
# CONFIG_TOUCHSCREEN_ILI210X is not set=0A=
# CONFIG_TOUCHSCREEN_ILITEK is not set=0A=
# CONFIG_TOUCHSCREEN_S6SY761 is not set=0A=
# CONFIG_TOUCHSCREEN_GUNZE is not set=0A=
# CONFIG_TOUCHSCREEN_EKTF2127 is not set=0A=
# CONFIG_TOUCHSCREEN_ELAN is not set=0A=
# CONFIG_TOUCHSCREEN_ELO is not set=0A=
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set=0A=
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set=0A=
# CONFIG_TOUCHSCREEN_MAX11801 is not set=0A=
# CONFIG_TOUCHSCREEN_MMS114 is not set=0A=
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set=0A=
# CONFIG_TOUCHSCREEN_MSG2638 is not set=0A=
# CONFIG_TOUCHSCREEN_MTOUCH is not set=0A=
# CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set=0A=
# CONFIG_TOUCHSCREEN_IMAGIS is not set=0A=
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set=0A=
# CONFIG_TOUCHSCREEN_INEXIO is not set=0A=
# CONFIG_TOUCHSCREEN_PENMOUNT is not set=0A=
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set=0A=
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set=0A=
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set=0A=
# CONFIG_TOUCHSCREEN_PIXCIR is not set=0A=
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set=0A=
CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_3M=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_ITM=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_JASTEC=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_ELO=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_E2I=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy=0A=
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=3Dy=0A=
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set=0A=
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set=0A=
# CONFIG_TOUCHSCREEN_TSC2004 is not set=0A=
# CONFIG_TOUCHSCREEN_TSC2005 is not set=0A=
# CONFIG_TOUCHSCREEN_TSC2007 is not set=0A=
# CONFIG_TOUCHSCREEN_RM_TS is not set=0A=
# CONFIG_TOUCHSCREEN_SILEAD is not set=0A=
# CONFIG_TOUCHSCREEN_SIS_I2C is not set=0A=
# CONFIG_TOUCHSCREEN_ST1232 is not set=0A=
# CONFIG_TOUCHSCREEN_STMFTS is not set=0A=
CONFIG_TOUCHSCREEN_SUR40=3Dy=0A=
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set=0A=
# CONFIG_TOUCHSCREEN_SX8654 is not set=0A=
# CONFIG_TOUCHSCREEN_TPS6507X is not set=0A=
# CONFIG_TOUCHSCREEN_ZET6223 is not set=0A=
# CONFIG_TOUCHSCREEN_ZFORCE is not set=0A=
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set=0A=
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set=0A=
# CONFIG_TOUCHSCREEN_IQS5XX is not set=0A=
# CONFIG_TOUCHSCREEN_IQS7211 is not set=0A=
# CONFIG_TOUCHSCREEN_ZINITIX is not set=0A=
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set=0A=
CONFIG_INPUT_MISC=3Dy=0A=
# CONFIG_INPUT_AD714X is not set=0A=
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set=0A=
# CONFIG_INPUT_BMA150 is not set=0A=
# CONFIG_INPUT_E3X0_BUTTON is not set=0A=
# CONFIG_INPUT_PCSPKR is not set=0A=
# CONFIG_INPUT_MMA8450 is not set=0A=
# CONFIG_INPUT_APANEL is not set=0A=
# CONFIG_INPUT_GPIO_BEEPER is not set=0A=
# CONFIG_INPUT_GPIO_DECODER is not set=0A=
# CONFIG_INPUT_GPIO_VIBRA is not set=0A=
# CONFIG_INPUT_ATLAS_BTNS is not set=0A=
CONFIG_INPUT_ATI_REMOTE2=3Dy=0A=
CONFIG_INPUT_KEYSPAN_REMOTE=3Dy=0A=
# CONFIG_INPUT_KXTJ9 is not set=0A=
CONFIG_INPUT_POWERMATE=3Dy=0A=
CONFIG_INPUT_YEALINK=3Dy=0A=
CONFIG_INPUT_CM109=3Dy=0A=
# CONFIG_INPUT_REGULATOR_HAPTIC is not set=0A=
# CONFIG_INPUT_RETU_PWRBUTTON is not set=0A=
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set=0A=
# CONFIG_INPUT_TWL4030_VIBRA is not set=0A=
CONFIG_INPUT_UINPUT=3Dy=0A=
# CONFIG_INPUT_PCF8574 is not set=0A=
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set=0A=
# CONFIG_INPUT_DA7280_HAPTICS is not set=0A=
# CONFIG_INPUT_ADXL34X is not set=0A=
# CONFIG_INPUT_IBM_PANEL is not set=0A=
CONFIG_INPUT_IMS_PCU=3Dy=0A=
# CONFIG_INPUT_IQS269A is not set=0A=
# CONFIG_INPUT_IQS626A is not set=0A=
# CONFIG_INPUT_IQS7222 is not set=0A=
# CONFIG_INPUT_CMA3000 is not set=0A=
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set=0A=
# CONFIG_INPUT_DRV260X_HAPTICS is not set=0A=
# CONFIG_INPUT_DRV2665_HAPTICS is not set=0A=
# CONFIG_INPUT_DRV2667_HAPTICS is not set=0A=
CONFIG_RMI4_CORE=3Dy=0A=
# CONFIG_RMI4_I2C is not set=0A=
# CONFIG_RMI4_SPI is not set=0A=
# CONFIG_RMI4_SMB is not set=0A=
CONFIG_RMI4_F03=3Dy=0A=
CONFIG_RMI4_F03_SERIO=3Dy=0A=
CONFIG_RMI4_2D_SENSOR=3Dy=0A=
CONFIG_RMI4_F11=3Dy=0A=
CONFIG_RMI4_F12=3Dy=0A=
CONFIG_RMI4_F30=3Dy=0A=
# CONFIG_RMI4_F34 is not set=0A=
CONFIG_RMI4_F3A=3Dy=0A=
# CONFIG_RMI4_F54 is not set=0A=
# CONFIG_RMI4_F55 is not set=0A=
=0A=
#=0A=
# Hardware I/O ports=0A=
#=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
CONFIG_SERIO_SERPORT=3Dy=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PARKBD is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
CONFIG_SERIO_LIBPS2=3Dy=0A=
# CONFIG_SERIO_RAW is not set=0A=
# CONFIG_SERIO_ALTERA_PS2 is not set=0A=
# CONFIG_SERIO_PS2MULT is not set=0A=
# CONFIG_SERIO_ARC_PS2 is not set=0A=
# CONFIG_SERIO_APBPS2 is not set=0A=
# CONFIG_SERIO_GPIO_PS2 is not set=0A=
CONFIG_USERIO=3Dy=0A=
# CONFIG_GAMEPORT is not set=0A=
# end of Hardware I/O ports=0A=
# end of Input device support=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_TTY=3Dy=0A=
CONFIG_VT=3Dy=0A=
CONFIG_CONSOLE_TRANSLATIONS=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_VT_CONSOLE_SLEEP=3Dy=0A=
CONFIG_VT_HW_CONSOLE_BINDING=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_LEGACY_PTYS=3Dy=0A=
CONFIG_LEGACY_PTY_COUNT=3D256=0A=
CONFIG_LEGACY_TIOCSTI=3Dy=0A=
CONFIG_LDISC_AUTOLOAD=3Dy=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_EARLYCON=3Dy=0A=
CONFIG_SERIAL_8250=3Dy=0A=
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=3Dy=0A=
CONFIG_SERIAL_8250_PNP=3Dy=0A=
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set=0A=
# CONFIG_SERIAL_8250_FINTEK is not set=0A=
CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
CONFIG_SERIAL_8250_DMA=3Dy=0A=
CONFIG_SERIAL_8250_PCILIB=3Dy=0A=
CONFIG_SERIAL_8250_PCI=3Dy=0A=
# CONFIG_SERIAL_8250_EXAR is not set=0A=
# CONFIG_SERIAL_8250_CS is not set=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D32=0A=
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4=0A=
CONFIG_SERIAL_8250_EXTENDED=3Dy=0A=
CONFIG_SERIAL_8250_MANY_PORTS=3Dy=0A=
# CONFIG_SERIAL_8250_PCI1XXXX is not set=0A=
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy=0A=
CONFIG_SERIAL_8250_DETECT_IRQ=3Dy=0A=
CONFIG_SERIAL_8250_RSA=3Dy=0A=
CONFIG_SERIAL_8250_DWLIB=3Dy=0A=
# CONFIG_SERIAL_8250_DW is not set=0A=
# CONFIG_SERIAL_8250_RT288X is not set=0A=
CONFIG_SERIAL_8250_LPSS=3Dy=0A=
CONFIG_SERIAL_8250_MID=3Dy=0A=
CONFIG_SERIAL_8250_PERICOM=3Dy=0A=
# CONFIG_SERIAL_OF_PLATFORM is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
# CONFIG_SERIAL_MAX3100 is not set=0A=
# CONFIG_SERIAL_MAX310X is not set=0A=
# CONFIG_SERIAL_UARTLITE is not set=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_JSM is not set=0A=
# CONFIG_SERIAL_SIFIVE is not set=0A=
# CONFIG_SERIAL_LANTIQ is not set=0A=
# CONFIG_SERIAL_SCCNXP is not set=0A=
# CONFIG_SERIAL_SC16IS7XX is not set=0A=
# CONFIG_SERIAL_ALTERA_JTAGUART is not set=0A=
# CONFIG_SERIAL_ALTERA_UART is not set=0A=
# CONFIG_SERIAL_XILINX_PS_UART is not set=0A=
# CONFIG_SERIAL_ARC is not set=0A=
# CONFIG_SERIAL_RP2 is not set=0A=
# CONFIG_SERIAL_FSL_LPUART is not set=0A=
# CONFIG_SERIAL_FSL_LINFLEXUART is not set=0A=
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set=0A=
# CONFIG_SERIAL_SPRD is not set=0A=
# end of Serial drivers=0A=
=0A=
CONFIG_SERIAL_MCTRL_GPIO=3Dy=0A=
CONFIG_SERIAL_NONSTANDARD=3Dy=0A=
# CONFIG_MOXA_INTELLIO is not set=0A=
# CONFIG_MOXA_SMARTIO is not set=0A=
CONFIG_N_HDLC=3Dy=0A=
# CONFIG_IPWIRELESS is not set=0A=
CONFIG_N_GSM=3Dy=0A=
CONFIG_NOZOMI=3Dy=0A=
CONFIG_NULL_TTY=3Dy=0A=
CONFIG_HVC_DRIVER=3Dy=0A=
CONFIG_SERIAL_DEV_BUS=3Dy=0A=
CONFIG_SERIAL_DEV_CTRL_TTYPORT=3Dy=0A=
CONFIG_TTY_PRINTK=3Dy=0A=
CONFIG_TTY_PRINTK_LEVEL=3D6=0A=
# CONFIG_PRINTER is not set=0A=
# CONFIG_PPDEV is not set=0A=
CONFIG_VIRTIO_CONSOLE=3Dy=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
# CONFIG_SSIF_IPMI_BMC is not set=0A=
# CONFIG_IPMB_DEVICE_INTERFACE is not set=0A=
CONFIG_HW_RANDOM=3Dy=0A=
# CONFIG_HW_RANDOM_TIMERIOMEM is not set=0A=
# CONFIG_HW_RANDOM_INTEL is not set=0A=
# CONFIG_HW_RANDOM_AMD is not set=0A=
# CONFIG_HW_RANDOM_BA431 is not set=0A=
# CONFIG_HW_RANDOM_VIA is not set=0A=
CONFIG_HW_RANDOM_VIRTIO=3Dy=0A=
# CONFIG_HW_RANDOM_CCTRNG is not set=0A=
# CONFIG_HW_RANDOM_XIPHERA is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_DEVMEM is not set=0A=
CONFIG_NVRAM=3Dy=0A=
# CONFIG_DEVPORT is not set=0A=
CONFIG_HPET=3Dy=0A=
CONFIG_HPET_MMAP=3Dy=0A=
CONFIG_HPET_MMAP_DEFAULT=3Dy=0A=
# CONFIG_HANGCHECK_TIMER is not set=0A=
CONFIG_TCG_TPM=3Dy=0A=
# CONFIG_TCG_TPM2_HMAC is not set=0A=
# CONFIG_HW_RANDOM_TPM is not set=0A=
CONFIG_TCG_TIS_CORE=3Dy=0A=
CONFIG_TCG_TIS=3Dy=0A=
# CONFIG_TCG_TIS_SPI is not set=0A=
# CONFIG_TCG_TIS_I2C is not set=0A=
# CONFIG_TCG_TIS_I2C_CR50 is not set=0A=
# CONFIG_TCG_TIS_I2C_ATMEL is not set=0A=
# CONFIG_TCG_TIS_I2C_INFINEON is not set=0A=
# CONFIG_TCG_TIS_I2C_NUVOTON is not set=0A=
# CONFIG_TCG_NSC is not set=0A=
# CONFIG_TCG_ATMEL is not set=0A=
# CONFIG_TCG_INFINEON is not set=0A=
CONFIG_TCG_CRB=3Dy=0A=
# CONFIG_TCG_VTPM_PROXY is not set=0A=
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set=0A=
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set=0A=
# CONFIG_TELCLOCK is not set=0A=
CONFIG_XILLYBUS_CLASS=3Dy=0A=
# CONFIG_XILLYBUS is not set=0A=
CONFIG_XILLYUSB=3Dy=0A=
# end of Character devices=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
CONFIG_I2C=3Dy=0A=
CONFIG_ACPI_I2C_OPREGION=3Dy=0A=
CONFIG_I2C_BOARDINFO=3Dy=0A=
CONFIG_I2C_CHARDEV=3Dy=0A=
CONFIG_I2C_MUX=3Dy=0A=
=0A=
#=0A=
# Multiplexer I2C Chip support=0A=
#=0A=
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set=0A=
# CONFIG_I2C_MUX_GPIO is not set=0A=
# CONFIG_I2C_MUX_GPMUX is not set=0A=
# CONFIG_I2C_MUX_LTC4306 is not set=0A=
# CONFIG_I2C_MUX_PCA9541 is not set=0A=
# CONFIG_I2C_MUX_PCA954x is not set=0A=
CONFIG_I2C_MUX_REG=3Dy=0A=
# CONFIG_I2C_MUX_MLXCPLD is not set=0A=
# end of Multiplexer I2C Chip support=0A=
=0A=
CONFIG_I2C_HELPER_AUTO=3Dy=0A=
CONFIG_I2C_SMBUS=3Dy=0A=
CONFIG_I2C_ALGOBIT=3Dy=0A=
=0A=
#=0A=
# I2C Hardware Bus support=0A=
#=0A=
=0A=
#=0A=
# PC SMBus host controller drivers=0A=
#=0A=
# CONFIG_I2C_ALI1535 is not set=0A=
# CONFIG_I2C_ALI1563 is not set=0A=
# CONFIG_I2C_ALI15X3 is not set=0A=
# CONFIG_I2C_AMD756 is not set=0A=
# CONFIG_I2C_AMD8111 is not set=0A=
# CONFIG_I2C_AMD_MP2 is not set=0A=
CONFIG_I2C_I801=3Dy=0A=
# CONFIG_I2C_ISCH is not set=0A=
# CONFIG_I2C_ISMT is not set=0A=
# CONFIG_I2C_PIIX4 is not set=0A=
# CONFIG_I2C_CHT_WC is not set=0A=
# CONFIG_I2C_NFORCE2 is not set=0A=
# CONFIG_I2C_NVIDIA_GPU is not set=0A=
# CONFIG_I2C_SIS5595 is not set=0A=
# CONFIG_I2C_SIS630 is not set=0A=
# CONFIG_I2C_SIS96X is not set=0A=
# CONFIG_I2C_VIA is not set=0A=
# CONFIG_I2C_VIAPRO is not set=0A=
# CONFIG_I2C_ZHAOXIN is not set=0A=
=0A=
#=0A=
# ACPI drivers=0A=
#=0A=
# CONFIG_I2C_SCMI is not set=0A=
=0A=
#=0A=
# I2C system bus drivers (mostly embedded / system-on-chip)=0A=
#=0A=
# CONFIG_I2C_CBUS_GPIO is not set=0A=
CONFIG_I2C_DESIGNWARE_CORE=3Dy=0A=
# CONFIG_I2C_DESIGNWARE_SLAVE is not set=0A=
CONFIG_I2C_DESIGNWARE_PLATFORM=3Dy=0A=
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set=0A=
# CONFIG_I2C_DESIGNWARE_PCI is not set=0A=
# CONFIG_I2C_EMEV2 is not set=0A=
# CONFIG_I2C_GPIO is not set=0A=
# CONFIG_I2C_OCORES is not set=0A=
# CONFIG_I2C_PCA_PLATFORM is not set=0A=
# CONFIG_I2C_RK3X is not set=0A=
# CONFIG_I2C_SIMTEC is not set=0A=
# CONFIG_I2C_XILINX is not set=0A=
=0A=
#=0A=
# External I2C/SMBus adapter drivers=0A=
#=0A=
CONFIG_I2C_DIOLAN_U2C=3Dy=0A=
CONFIG_I2C_DLN2=3Dy=0A=
CONFIG_I2C_LJCA=3Dy=0A=
CONFIG_I2C_CP2615=3Dy=0A=
# CONFIG_I2C_PARPORT is not set=0A=
# CONFIG_I2C_PCI1XXXX is not set=0A=
CONFIG_I2C_ROBOTFUZZ_OSIF=3Dy=0A=
# CONFIG_I2C_TAOS_EVM is not set=0A=
CONFIG_I2C_TINY_USB=3Dy=0A=
CONFIG_I2C_VIPERBOARD=3Dy=0A=
=0A=
#=0A=
# Other I2C/SMBus bus drivers=0A=
#=0A=
# CONFIG_I2C_MLXCPLD is not set=0A=
# CONFIG_I2C_VIRTIO is not set=0A=
# end of I2C Hardware Bus support=0A=
=0A=
# CONFIG_I2C_STUB is not set=0A=
CONFIG_I2C_SLAVE=3Dy=0A=
CONFIG_I2C_SLAVE_EEPROM=3Dy=0A=
# CONFIG_I2C_SLAVE_TESTUNIT is not set=0A=
# CONFIG_I2C_DEBUG_CORE is not set=0A=
# CONFIG_I2C_DEBUG_ALGO is not set=0A=
# CONFIG_I2C_DEBUG_BUS is not set=0A=
# end of I2C support=0A=
=0A=
# CONFIG_I3C is not set=0A=
CONFIG_SPI=3Dy=0A=
# CONFIG_SPI_DEBUG is not set=0A=
CONFIG_SPI_MASTER=3Dy=0A=
# CONFIG_SPI_MEM is not set=0A=
=0A=
#=0A=
# SPI Master Controller Drivers=0A=
#=0A=
# CONFIG_SPI_ALTERA is not set=0A=
# CONFIG_SPI_AXI_SPI_ENGINE is not set=0A=
# CONFIG_SPI_BITBANG is not set=0A=
# CONFIG_SPI_BUTTERFLY is not set=0A=
# CONFIG_SPI_CADENCE is not set=0A=
# CONFIG_SPI_CADENCE_QUADSPI is not set=0A=
# CONFIG_SPI_CH341 is not set=0A=
# CONFIG_SPI_DESIGNWARE is not set=0A=
CONFIG_SPI_DLN2=3Dy=0A=
# CONFIG_SPI_GPIO is not set=0A=
# CONFIG_SPI_LM70_LLP is not set=0A=
# CONFIG_SPI_FSL_SPI is not set=0A=
CONFIG_SPI_LJCA=3Dy=0A=
# CONFIG_SPI_MICROCHIP_CORE is not set=0A=
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set=0A=
# CONFIG_SPI_LANTIQ_SSC is not set=0A=
# CONFIG_SPI_OC_TINY is not set=0A=
# CONFIG_SPI_PCI1XXXX is not set=0A=
# CONFIG_SPI_PXA2XX is not set=0A=
# CONFIG_SPI_SC18IS602 is not set=0A=
# CONFIG_SPI_SIFIVE is not set=0A=
# CONFIG_SPI_MXIC is not set=0A=
# CONFIG_SPI_XCOMM is not set=0A=
# CONFIG_SPI_XILINX is not set=0A=
# CONFIG_SPI_AMD is not set=0A=
=0A=
#=0A=
# SPI Multiplexer support=0A=
#=0A=
# CONFIG_SPI_MUX is not set=0A=
=0A=
#=0A=
# SPI Protocol Masters=0A=
#=0A=
# CONFIG_SPI_SPIDEV is not set=0A=
# CONFIG_SPI_LOOPBACK_TEST is not set=0A=
# CONFIG_SPI_TLE62X0 is not set=0A=
# CONFIG_SPI_SLAVE is not set=0A=
CONFIG_SPI_DYNAMIC=3Dy=0A=
# CONFIG_SPMI is not set=0A=
# CONFIG_HSI is not set=0A=
CONFIG_PPS=3Dy=0A=
# CONFIG_PPS_DEBUG is not set=0A=
=0A=
#=0A=
# PPS clients support=0A=
#=0A=
# CONFIG_PPS_CLIENT_KTIMER is not set=0A=
# CONFIG_PPS_CLIENT_LDISC is not set=0A=
# CONFIG_PPS_CLIENT_PARPORT is not set=0A=
# CONFIG_PPS_CLIENT_GPIO is not set=0A=
=0A=
#=0A=
# PPS generators support=0A=
#=0A=
=0A=
#=0A=
# PTP clock support=0A=
#=0A=
CONFIG_PTP_1588_CLOCK=3Dy=0A=
CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy=0A=
=0A=
#=0A=
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.=
=0A=
#=0A=
CONFIG_PTP_1588_CLOCK_KVM=3Dy=0A=
CONFIG_PTP_1588_CLOCK_VMCLOCK=3Dy=0A=
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set=0A=
# CONFIG_PTP_1588_CLOCK_IDTCM is not set=0A=
# CONFIG_PTP_1588_CLOCK_FC3W is not set=0A=
# CONFIG_PTP_1588_CLOCK_MOCK is not set=0A=
# CONFIG_PTP_1588_CLOCK_VMW is not set=0A=
# CONFIG_PTP_1588_CLOCK_OCP is not set=0A=
# end of PTP clock support=0A=
=0A=
# CONFIG_PINCTRL is not set=0A=
CONFIG_GPIOLIB=3Dy=0A=
CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512=0A=
CONFIG_OF_GPIO=3Dy=0A=
CONFIG_GPIO_ACPI=3Dy=0A=
CONFIG_GPIOLIB_IRQCHIP=3Dy=0A=
# CONFIG_DEBUG_GPIO is not set=0A=
# CONFIG_GPIO_SYSFS is not set=0A=
# CONFIG_GPIO_CDEV is not set=0A=
=0A=
#=0A=
# Memory mapped GPIO drivers=0A=
#=0A=
# CONFIG_GPIO_74XX_MMIO is not set=0A=
# CONFIG_GPIO_ALTERA is not set=0A=
# CONFIG_GPIO_AMDPT is not set=0A=
# CONFIG_GPIO_CADENCE is not set=0A=
# CONFIG_GPIO_DWAPB is not set=0A=
# CONFIG_GPIO_FTGPIO010 is not set=0A=
# CONFIG_GPIO_GENERIC_PLATFORM is not set=0A=
# CONFIG_GPIO_GRANITERAPIDS is not set=0A=
# CONFIG_GPIO_GRGPIO is not set=0A=
# CONFIG_GPIO_HLWD is not set=0A=
# CONFIG_GPIO_ICH is not set=0A=
# CONFIG_GPIO_LOGICVC is not set=0A=
# CONFIG_GPIO_MB86S7X is not set=0A=
# CONFIG_GPIO_POLARFIRE_SOC is not set=0A=
# CONFIG_GPIO_SIFIVE is not set=0A=
# CONFIG_GPIO_SYSCON is not set=0A=
# CONFIG_GPIO_XILINX is not set=0A=
# CONFIG_GPIO_AMD_FCH is not set=0A=
# end of Memory mapped GPIO drivers=0A=
=0A=
#=0A=
# Port-mapped I/O GPIO drivers=0A=
#=0A=
# CONFIG_GPIO_VX855 is not set=0A=
# CONFIG_GPIO_F7188X is not set=0A=
# CONFIG_GPIO_IT87 is not set=0A=
# CONFIG_GPIO_SCH311X is not set=0A=
# CONFIG_GPIO_WINBOND is not set=0A=
# CONFIG_GPIO_WS16C48 is not set=0A=
# end of Port-mapped I/O GPIO drivers=0A=
=0A=
#=0A=
# I2C GPIO expanders=0A=
#=0A=
# CONFIG_GPIO_ADNP is not set=0A=
# CONFIG_GPIO_FXL6408 is not set=0A=
# CONFIG_GPIO_DS4520 is not set=0A=
# CONFIG_GPIO_GW_PLD is not set=0A=
# CONFIG_GPIO_MAX7300 is not set=0A=
# CONFIG_GPIO_MAX732X is not set=0A=
# CONFIG_GPIO_PCA953X is not set=0A=
# CONFIG_GPIO_PCA9570 is not set=0A=
# CONFIG_GPIO_PCF857X is not set=0A=
# CONFIG_GPIO_TPIC2810 is not set=0A=
# end of I2C GPIO expanders=0A=
=0A=
#=0A=
# MFD GPIO expanders=0A=
#=0A=
CONFIG_GPIO_DLN2=3Dy=0A=
# CONFIG_GPIO_ELKHARTLAKE is not set=0A=
CONFIG_GPIO_LJCA=3Dy=0A=
# CONFIG_GPIO_TWL4030 is not set=0A=
# CONFIG_GPIO_WHISKEY_COVE is not set=0A=
# end of MFD GPIO expanders=0A=
=0A=
#=0A=
# PCI GPIO expanders=0A=
#=0A=
# CONFIG_GPIO_AMD8111 is not set=0A=
# CONFIG_GPIO_BT8XX is not set=0A=
# CONFIG_GPIO_ML_IOH is not set=0A=
# CONFIG_GPIO_PCI_IDIO_16 is not set=0A=
# CONFIG_GPIO_PCIE_IDIO_24 is not set=0A=
# CONFIG_GPIO_RDC321X is not set=0A=
# CONFIG_GPIO_SODAVILLE is not set=0A=
# end of PCI GPIO expanders=0A=
=0A=
#=0A=
# SPI GPIO expanders=0A=
#=0A=
# CONFIG_GPIO_74X164 is not set=0A=
# CONFIG_GPIO_MAX3191X is not set=0A=
# CONFIG_GPIO_MAX7301 is not set=0A=
# CONFIG_GPIO_MC33880 is not set=0A=
# CONFIG_GPIO_PISOSR is not set=0A=
# CONFIG_GPIO_XRA1403 is not set=0A=
# end of SPI GPIO expanders=0A=
=0A=
#=0A=
# USB GPIO expanders=0A=
#=0A=
CONFIG_GPIO_VIPERBOARD=3Dy=0A=
# CONFIG_GPIO_MPSSE is not set=0A=
# end of USB GPIO expanders=0A=
=0A=
#=0A=
# Virtual GPIO drivers=0A=
#=0A=
# CONFIG_GPIO_AGGREGATOR is not set=0A=
# CONFIG_GPIO_LATCH is not set=0A=
# CONFIG_GPIO_MOCKUP is not set=0A=
# CONFIG_GPIO_VIRTIO is not set=0A=
# CONFIG_GPIO_SIM is not set=0A=
# end of Virtual GPIO drivers=0A=
=0A=
#=0A=
# GPIO Debugging utilities=0A=
#=0A=
# CONFIG_GPIO_SLOPPY_LOGIC_ANALYZER is not set=0A=
# CONFIG_GPIO_VIRTUSER is not set=0A=
# end of GPIO Debugging utilities=0A=
=0A=
# CONFIG_W1 is not set=0A=
# CONFIG_POWER_RESET is not set=0A=
# CONFIG_POWER_SEQUENCING is not set=0A=
CONFIG_POWER_SUPPLY=3Dy=0A=
# CONFIG_POWER_SUPPLY_DEBUG is not set=0A=
CONFIG_POWER_SUPPLY_HWMON=3Dy=0A=
# CONFIG_GENERIC_ADC_BATTERY is not set=0A=
# CONFIG_IP5XXX_POWER is not set=0A=
# CONFIG_TEST_POWER is not set=0A=
# CONFIG_CHARGER_ADP5061 is not set=0A=
# CONFIG_BATTERY_CW2015 is not set=0A=
# CONFIG_BATTERY_DS2780 is not set=0A=
# CONFIG_BATTERY_DS2781 is not set=0A=
# CONFIG_BATTERY_DS2782 is not set=0A=
# CONFIG_BATTERY_SAMSUNG_SDI is not set=0A=
# CONFIG_BATTERY_SBS is not set=0A=
# CONFIG_CHARGER_SBS is not set=0A=
# CONFIG_MANAGER_SBS is not set=0A=
# CONFIG_BATTERY_BQ27XXX is not set=0A=
# CONFIG_BATTERY_MAX17040 is not set=0A=
# CONFIG_BATTERY_MAX17042 is not set=0A=
# CONFIG_BATTERY_MAX1720X is not set=0A=
CONFIG_CHARGER_ISP1704=3Dy=0A=
# CONFIG_CHARGER_MAX8903 is not set=0A=
# CONFIG_CHARGER_TWL4030 is not set=0A=
# CONFIG_CHARGER_TWL6030 is not set=0A=
# CONFIG_CHARGER_LP8727 is not set=0A=
# CONFIG_CHARGER_GPIO is not set=0A=
# CONFIG_CHARGER_MANAGER is not set=0A=
# CONFIG_CHARGER_LT3651 is not set=0A=
# CONFIG_CHARGER_LTC4162L is not set=0A=
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set=0A=
# CONFIG_CHARGER_MAX77976 is not set=0A=
# CONFIG_CHARGER_MT6360 is not set=0A=
# CONFIG_CHARGER_MT6370 is not set=0A=
# CONFIG_CHARGER_BQ2415X is not set=0A=
CONFIG_CHARGER_BQ24190=3Dy=0A=
# CONFIG_CHARGER_BQ24257 is not set=0A=
# CONFIG_CHARGER_BQ24735 is not set=0A=
# CONFIG_CHARGER_BQ2515X is not set=0A=
# CONFIG_CHARGER_BQ25890 is not set=0A=
# CONFIG_CHARGER_BQ25980 is not set=0A=
# CONFIG_CHARGER_BQ256XX is not set=0A=
# CONFIG_CHARGER_SMB347 is not set=0A=
# CONFIG_BATTERY_GAUGE_LTC2941 is not set=0A=
# CONFIG_BATTERY_GOLDFISH is not set=0A=
# CONFIG_BATTERY_RT5033 is not set=0A=
# CONFIG_CHARGER_RT9455 is not set=0A=
# CONFIG_CHARGER_RT9467 is not set=0A=
# CONFIG_CHARGER_RT9471 is not set=0A=
# CONFIG_CHARGER_UCS1002 is not set=0A=
# CONFIG_CHARGER_BD99954 is not set=0A=
# CONFIG_BATTERY_UG3105 is not set=0A=
# CONFIG_FUEL_GAUGE_MM8013 is not set=0A=
CONFIG_HWMON=3Dy=0A=
# CONFIG_HWMON_DEBUG_CHIP is not set=0A=
=0A=
#=0A=
# Native drivers=0A=
#=0A=
# CONFIG_SENSORS_ABITUGURU is not set=0A=
# CONFIG_SENSORS_ABITUGURU3 is not set=0A=
# CONFIG_SENSORS_AD7314 is not set=0A=
# CONFIG_SENSORS_AD7414 is not set=0A=
# CONFIG_SENSORS_AD7418 is not set=0A=
# CONFIG_SENSORS_ADM1025 is not set=0A=
# CONFIG_SENSORS_ADM1026 is not set=0A=
# CONFIG_SENSORS_ADM1029 is not set=0A=
# CONFIG_SENSORS_ADM1031 is not set=0A=
# CONFIG_SENSORS_ADM1177 is not set=0A=
# CONFIG_SENSORS_ADM9240 is not set=0A=
# CONFIG_SENSORS_ADT7310 is not set=0A=
# CONFIG_SENSORS_ADT7410 is not set=0A=
# CONFIG_SENSORS_ADT7411 is not set=0A=
# CONFIG_SENSORS_ADT7462 is not set=0A=
# CONFIG_SENSORS_ADT7470 is not set=0A=
# CONFIG_SENSORS_ADT7475 is not set=0A=
# CONFIG_SENSORS_AHT10 is not set=0A=
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=3Dy=0A=
# CONFIG_SENSORS_AS370 is not set=0A=
# CONFIG_SENSORS_ASC7621 is not set=0A=
# CONFIG_SENSORS_ASUS_ROG_RYUJIN is not set=0A=
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set=0A=
# CONFIG_SENSORS_K8TEMP is not set=0A=
# CONFIG_SENSORS_K10TEMP is not set=0A=
# CONFIG_SENSORS_FAM15H_POWER is not set=0A=
# CONFIG_SENSORS_APPLESMC is not set=0A=
# CONFIG_SENSORS_ASB100 is not set=0A=
# CONFIG_SENSORS_ATXP1 is not set=0A=
# CONFIG_SENSORS_CHIPCAP2 is not set=0A=
CONFIG_SENSORS_CORSAIR_CPRO=3Dy=0A=
CONFIG_SENSORS_CORSAIR_PSU=3Dy=0A=
# CONFIG_SENSORS_DRIVETEMP is not set=0A=
# CONFIG_SENSORS_DS620 is not set=0A=
# CONFIG_SENSORS_DS1621 is not set=0A=
# CONFIG_SENSORS_DELL_SMM is not set=0A=
# CONFIG_SENSORS_I5K_AMB is not set=0A=
# CONFIG_SENSORS_F71805F is not set=0A=
# CONFIG_SENSORS_F71882FG is not set=0A=
# CONFIG_SENSORS_F75375S is not set=0A=
# CONFIG_SENSORS_FSCHMD is not set=0A=
# CONFIG_SENSORS_FTSTEUTATES is not set=0A=
CONFIG_SENSORS_GIGABYTE_WATERFORCE=3Dy=0A=
# CONFIG_SENSORS_GL518SM is not set=0A=
# CONFIG_SENSORS_GL520SM is not set=0A=
# CONFIG_SENSORS_G760A is not set=0A=
# CONFIG_SENSORS_G762 is not set=0A=
# CONFIG_SENSORS_GPIO_FAN is not set=0A=
# CONFIG_SENSORS_HIH6130 is not set=0A=
# CONFIG_SENSORS_HS3001 is not set=0A=
# CONFIG_SENSORS_IIO_HWMON is not set=0A=
# CONFIG_SENSORS_I5500 is not set=0A=
# CONFIG_SENSORS_CORETEMP is not set=0A=
# CONFIG_SENSORS_ISL28022 is not set=0A=
# CONFIG_SENSORS_IT87 is not set=0A=
# CONFIG_SENSORS_JC42 is not set=0A=
CONFIG_SENSORS_POWERZ=3Dy=0A=
# CONFIG_SENSORS_POWR1220 is not set=0A=
# CONFIG_SENSORS_LENOVO_EC is not set=0A=
# CONFIG_SENSORS_LINEAGE is not set=0A=
# CONFIG_SENSORS_LTC2945 is not set=0A=
# CONFIG_SENSORS_LTC2947_I2C is not set=0A=
# CONFIG_SENSORS_LTC2947_SPI is not set=0A=
# CONFIG_SENSORS_LTC2990 is not set=0A=
# CONFIG_SENSORS_LTC2991 is not set=0A=
# CONFIG_SENSORS_LTC2992 is not set=0A=
# CONFIG_SENSORS_LTC4151 is not set=0A=
# CONFIG_SENSORS_LTC4215 is not set=0A=
# CONFIG_SENSORS_LTC4222 is not set=0A=
# CONFIG_SENSORS_LTC4245 is not set=0A=
# CONFIG_SENSORS_LTC4260 is not set=0A=
# CONFIG_SENSORS_LTC4261 is not set=0A=
# CONFIG_SENSORS_LTC4282 is not set=0A=
# CONFIG_SENSORS_MAX1111 is not set=0A=
# CONFIG_SENSORS_MAX127 is not set=0A=
# CONFIG_SENSORS_MAX16065 is not set=0A=
# CONFIG_SENSORS_MAX1619 is not set=0A=
# CONFIG_SENSORS_MAX1668 is not set=0A=
# CONFIG_SENSORS_MAX197 is not set=0A=
# CONFIG_SENSORS_MAX31722 is not set=0A=
# CONFIG_SENSORS_MAX31730 is not set=0A=
# CONFIG_SENSORS_MAX31760 is not set=0A=
# CONFIG_MAX31827 is not set=0A=
# CONFIG_SENSORS_MAX6620 is not set=0A=
# CONFIG_SENSORS_MAX6621 is not set=0A=
# CONFIG_SENSORS_MAX6639 is not set=0A=
# CONFIG_SENSORS_MAX6650 is not set=0A=
# CONFIG_SENSORS_MAX6697 is not set=0A=
# CONFIG_SENSORS_MAX31790 is not set=0A=
# CONFIG_SENSORS_MC34VR500 is not set=0A=
# CONFIG_SENSORS_MCP3021 is not set=0A=
# CONFIG_SENSORS_TC654 is not set=0A=
# CONFIG_SENSORS_TPS23861 is not set=0A=
# CONFIG_SENSORS_MR75203 is not set=0A=
# CONFIG_SENSORS_ADCXX is not set=0A=
# CONFIG_SENSORS_LM63 is not set=0A=
# CONFIG_SENSORS_LM70 is not set=0A=
# CONFIG_SENSORS_LM73 is not set=0A=
# CONFIG_SENSORS_LM75 is not set=0A=
# CONFIG_SENSORS_LM77 is not set=0A=
# CONFIG_SENSORS_LM78 is not set=0A=
# CONFIG_SENSORS_LM80 is not set=0A=
# CONFIG_SENSORS_LM83 is not set=0A=
# CONFIG_SENSORS_LM85 is not set=0A=
# CONFIG_SENSORS_LM87 is not set=0A=
# CONFIG_SENSORS_LM90 is not set=0A=
# CONFIG_SENSORS_LM92 is not set=0A=
# CONFIG_SENSORS_LM93 is not set=0A=
# CONFIG_SENSORS_LM95234 is not set=0A=
# CONFIG_SENSORS_LM95241 is not set=0A=
# CONFIG_SENSORS_LM95245 is not set=0A=
# CONFIG_SENSORS_PC87360 is not set=0A=
# CONFIG_SENSORS_PC87427 is not set=0A=
# CONFIG_SENSORS_NTC_THERMISTOR is not set=0A=
# CONFIG_SENSORS_NCT6683 is not set=0A=
# CONFIG_SENSORS_NCT6775 is not set=0A=
# CONFIG_SENSORS_NCT6775_I2C is not set=0A=
# CONFIG_SENSORS_NCT7363 is not set=0A=
# CONFIG_SENSORS_NCT7802 is not set=0A=
# CONFIG_SENSORS_NCT7904 is not set=0A=
# CONFIG_SENSORS_NPCM7XX is not set=0A=
CONFIG_SENSORS_NZXT_KRAKEN2=3Dy=0A=
# CONFIG_SENSORS_NZXT_KRAKEN3 is not set=0A=
CONFIG_SENSORS_NZXT_SMART2=3Dy=0A=
# CONFIG_SENSORS_OCC_P8_I2C is not set=0A=
# CONFIG_SENSORS_OXP is not set=0A=
# CONFIG_SENSORS_PCF8591 is not set=0A=
# CONFIG_PMBUS is not set=0A=
# CONFIG_SENSORS_PT5161L is not set=0A=
# CONFIG_SENSORS_SBTSI is not set=0A=
# CONFIG_SENSORS_SBRMI is not set=0A=
# CONFIG_SENSORS_SHT15 is not set=0A=
# CONFIG_SENSORS_SHT21 is not set=0A=
# CONFIG_SENSORS_SHT3x is not set=0A=
# CONFIG_SENSORS_SHT4x is not set=0A=
# CONFIG_SENSORS_SHTC1 is not set=0A=
# CONFIG_SENSORS_SIS5595 is not set=0A=
# CONFIG_SENSORS_DME1737 is not set=0A=
# CONFIG_SENSORS_EMC1403 is not set=0A=
# CONFIG_SENSORS_EMC2103 is not set=0A=
# CONFIG_SENSORS_EMC2305 is not set=0A=
# CONFIG_SENSORS_EMC6W201 is not set=0A=
# CONFIG_SENSORS_SMSC47M1 is not set=0A=
# CONFIG_SENSORS_SMSC47M192 is not set=0A=
# CONFIG_SENSORS_SMSC47B397 is not set=0A=
# CONFIG_SENSORS_SCH5627 is not set=0A=
# CONFIG_SENSORS_SCH5636 is not set=0A=
# CONFIG_SENSORS_STTS751 is not set=0A=
# CONFIG_SENSORS_ADC128D818 is not set=0A=
# CONFIG_SENSORS_ADS7828 is not set=0A=
# CONFIG_SENSORS_ADS7871 is not set=0A=
# CONFIG_SENSORS_AMC6821 is not set=0A=
# CONFIG_SENSORS_INA209 is not set=0A=
# CONFIG_SENSORS_INA2XX is not set=0A=
# CONFIG_SENSORS_INA238 is not set=0A=
# CONFIG_SENSORS_INA3221 is not set=0A=
# CONFIG_SENSORS_SPD5118 is not set=0A=
# CONFIG_SENSORS_TC74 is not set=0A=
# CONFIG_SENSORS_THMC50 is not set=0A=
# CONFIG_SENSORS_TMP102 is not set=0A=
# CONFIG_SENSORS_TMP103 is not set=0A=
# CONFIG_SENSORS_TMP108 is not set=0A=
# CONFIG_SENSORS_TMP401 is not set=0A=
# CONFIG_SENSORS_TMP421 is not set=0A=
# CONFIG_SENSORS_TMP464 is not set=0A=
# CONFIG_SENSORS_TMP513 is not set=0A=
# CONFIG_SENSORS_VIA_CPUTEMP is not set=0A=
# CONFIG_SENSORS_VIA686A is not set=0A=
# CONFIG_SENSORS_VT1211 is not set=0A=
# CONFIG_SENSORS_VT8231 is not set=0A=
# CONFIG_SENSORS_W83773G is not set=0A=
# CONFIG_SENSORS_W83781D is not set=0A=
# CONFIG_SENSORS_W83791D is not set=0A=
# CONFIG_SENSORS_W83792D is not set=0A=
# CONFIG_SENSORS_W83793 is not set=0A=
# CONFIG_SENSORS_W83795 is not set=0A=
# CONFIG_SENSORS_W83L785TS is not set=0A=
# CONFIG_SENSORS_W83L786NG is not set=0A=
# CONFIG_SENSORS_W83627HF is not set=0A=
# CONFIG_SENSORS_W83627EHF is not set=0A=
# CONFIG_SENSORS_XGENE is not set=0A=
=0A=
#=0A=
# ACPI drivers=0A=
#=0A=
# CONFIG_SENSORS_ACPI_POWER is not set=0A=
# CONFIG_SENSORS_ATK0110 is not set=0A=
# CONFIG_SENSORS_ASUS_WMI is not set=0A=
# CONFIG_SENSORS_ASUS_EC is not set=0A=
# CONFIG_SENSORS_HP_WMI is not set=0A=
CONFIG_THERMAL=3Dy=0A=
CONFIG_THERMAL_NETLINK=3Dy=0A=
# CONFIG_THERMAL_STATISTICS is not set=0A=
# CONFIG_THERMAL_DEBUGFS is not set=0A=
# CONFIG_THERMAL_CORE_TESTING is not set=0A=
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0=0A=
CONFIG_THERMAL_HWMON=3Dy=0A=
# CONFIG_THERMAL_OF is not set=0A=
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy=0A=
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set=0A=
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set=0A=
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set=0A=
CONFIG_THERMAL_GOV_STEP_WISE=3Dy=0A=
# CONFIG_THERMAL_GOV_BANG_BANG is not set=0A=
CONFIG_THERMAL_GOV_USER_SPACE=3Dy=0A=
# CONFIG_PCIE_THERMAL is not set=0A=
# CONFIG_THERMAL_EMULATION is not set=0A=
# CONFIG_THERMAL_MMIO is not set=0A=
=0A=
#=0A=
# Intel thermal drivers=0A=
#=0A=
# CONFIG_INTEL_POWERCLAMP is not set=0A=
CONFIG_X86_THERMAL_VECTOR=3Dy=0A=
# CONFIG_X86_PKG_TEMP_THERMAL is not set=0A=
# CONFIG_INTEL_SOC_DTS_THERMAL is not set=0A=
=0A=
#=0A=
# ACPI INT340X thermal drivers=0A=
#=0A=
# CONFIG_INT340X_THERMAL is not set=0A=
# end of ACPI INT340X thermal drivers=0A=
=0A=
# CONFIG_INTEL_BXT_PMIC_THERMAL is not set=0A=
# CONFIG_INTEL_PCH_THERMAL is not set=0A=
# CONFIG_INTEL_TCC_COOLING is not set=0A=
# CONFIG_INTEL_HFI_THERMAL is not set=0A=
# end of Intel thermal drivers=0A=
=0A=
# CONFIG_GENERIC_ADC_THERMAL is not set=0A=
CONFIG_WATCHDOG=3Dy=0A=
# CONFIG_WATCHDOG_CORE is not set=0A=
# CONFIG_WATCHDOG_NOWAYOUT is not set=0A=
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy=0A=
CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0=0A=
# CONFIG_WATCHDOG_SYSFS is not set=0A=
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set=0A=
=0A=
#=0A=
# Watchdog Pretimeout Governors=0A=
#=0A=
=0A=
#=0A=
# Watchdog Device Drivers=0A=
#=0A=
# CONFIG_SOFT_WATCHDOG is not set=0A=
# CONFIG_GPIO_WATCHDOG is not set=0A=
# CONFIG_LENOVO_SE10_WDT is not set=0A=
# CONFIG_WDAT_WDT is not set=0A=
# CONFIG_XILINX_WATCHDOG is not set=0A=
# CONFIG_ZIIRAVE_WATCHDOG is not set=0A=
# CONFIG_CADENCE_WATCHDOG is not set=0A=
# CONFIG_DW_WATCHDOG is not set=0A=
# CONFIG_TWL4030_WATCHDOG is not set=0A=
# CONFIG_MAX63XX_WATCHDOG is not set=0A=
# CONFIG_RETU_WATCHDOG is not set=0A=
# CONFIG_ACQUIRE_WDT is not set=0A=
# CONFIG_ADVANTECH_WDT is not set=0A=
# CONFIG_ADVANTECH_EC_WDT is not set=0A=
# CONFIG_ALIM1535_WDT is not set=0A=
# CONFIG_ALIM7101_WDT is not set=0A=
# CONFIG_EBC_C384_WDT is not set=0A=
# CONFIG_EXAR_WDT is not set=0A=
# CONFIG_F71808E_WDT is not set=0A=
# CONFIG_SP5100_TCO is not set=0A=
# CONFIG_SBC_FITPC2_WATCHDOG is not set=0A=
# CONFIG_EUROTECH_WDT is not set=0A=
# CONFIG_IB700_WDT is not set=0A=
# CONFIG_IBMASR is not set=0A=
# CONFIG_WAFER_WDT is not set=0A=
# CONFIG_I6300ESB_WDT is not set=0A=
# CONFIG_IE6XX_WDT is not set=0A=
# CONFIG_ITCO_WDT is not set=0A=
# CONFIG_IT8712F_WDT is not set=0A=
# CONFIG_IT87_WDT is not set=0A=
# CONFIG_HP_WATCHDOG is not set=0A=
# CONFIG_SC1200_WDT is not set=0A=
# CONFIG_PC87413_WDT is not set=0A=
# CONFIG_NV_TCO is not set=0A=
# CONFIG_60XX_WDT is not set=0A=
# CONFIG_SMSC_SCH311X_WDT is not set=0A=
# CONFIG_SMSC37B787_WDT is not set=0A=
# CONFIG_TQMX86_WDT is not set=0A=
# CONFIG_VIA_WDT is not set=0A=
# CONFIG_W83627HF_WDT is not set=0A=
# CONFIG_W83877F_WDT is not set=0A=
# CONFIG_W83977F_WDT is not set=0A=
# CONFIG_MACHZ_WDT is not set=0A=
# CONFIG_SBC_EPX_C3_WATCHDOG is not set=0A=
# CONFIG_INTEL_MEI_WDT is not set=0A=
# CONFIG_NI903X_WDT is not set=0A=
# CONFIG_NIC7018_WDT is not set=0A=
# CONFIG_MEN_A21_WDT is not set=0A=
=0A=
#=0A=
# PCI-based Watchdog Cards=0A=
#=0A=
# CONFIG_PCIPCWATCHDOG is not set=0A=
# CONFIG_WDTPCI is not set=0A=
=0A=
#=0A=
# USB-based Watchdog Cards=0A=
#=0A=
CONFIG_USBPCWATCHDOG=3Dy=0A=
CONFIG_SSB_POSSIBLE=3Dy=0A=
CONFIG_SSB=3Dy=0A=
CONFIG_SSB_PCIHOST_POSSIBLE=3Dy=0A=
# CONFIG_SSB_PCIHOST is not set=0A=
CONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy=0A=
# CONFIG_SSB_PCMCIAHOST is not set=0A=
CONFIG_SSB_SDIOHOST_POSSIBLE=3Dy=0A=
# CONFIG_SSB_SDIOHOST is not set=0A=
# CONFIG_SSB_DRIVER_GPIO is not set=0A=
CONFIG_BCMA_POSSIBLE=3Dy=0A=
CONFIG_BCMA=3Dy=0A=
CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy=0A=
# CONFIG_BCMA_HOST_PCI is not set=0A=
# CONFIG_BCMA_HOST_SOC is not set=0A=
# CONFIG_BCMA_DRIVER_PCI is not set=0A=
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set=0A=
# CONFIG_BCMA_DRIVER_GPIO is not set=0A=
# CONFIG_BCMA_DEBUG is not set=0A=
=0A=
#=0A=
# Multifunction device drivers=0A=
#=0A=
CONFIG_MFD_CORE=3Dy=0A=
# CONFIG_MFD_ADP5585 is not set=0A=
# CONFIG_MFD_ACT8945A is not set=0A=
# CONFIG_MFD_AS3711 is not set=0A=
# CONFIG_MFD_SMPRO is not set=0A=
# CONFIG_MFD_AS3722 is not set=0A=
# CONFIG_PMIC_ADP5520 is not set=0A=
# CONFIG_MFD_AAT2870_CORE is not set=0A=
# CONFIG_MFD_ATMEL_FLEXCOM is not set=0A=
# CONFIG_MFD_ATMEL_HLCDC is not set=0A=
# CONFIG_MFD_BCM590XX is not set=0A=
# CONFIG_MFD_BD9571MWV is not set=0A=
# CONFIG_MFD_AXP20X_I2C is not set=0A=
# CONFIG_MFD_CGBC is not set=0A=
# CONFIG_MFD_CS42L43_I2C is not set=0A=
# CONFIG_MFD_CS42L43_SDW is not set=0A=
# CONFIG_MFD_MADERA is not set=0A=
# CONFIG_MFD_MAX5970 is not set=0A=
# CONFIG_PMIC_DA903X is not set=0A=
# CONFIG_MFD_DA9052_SPI is not set=0A=
# CONFIG_MFD_DA9052_I2C is not set=0A=
# CONFIG_MFD_DA9055 is not set=0A=
# CONFIG_MFD_DA9062 is not set=0A=
# CONFIG_MFD_DA9063 is not set=0A=
# CONFIG_MFD_DA9150 is not set=0A=
CONFIG_MFD_DLN2=3Dy=0A=
# CONFIG_MFD_GATEWORKS_GSC is not set=0A=
# CONFIG_MFD_MC13XXX_SPI is not set=0A=
# CONFIG_MFD_MC13XXX_I2C is not set=0A=
# CONFIG_MFD_MP2629 is not set=0A=
# CONFIG_MFD_HI6421_PMIC is not set=0A=
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set=0A=
CONFIG_LPC_ICH=3Dy=0A=
# CONFIG_LPC_SCH is not set=0A=
# CONFIG_INTEL_SOC_PMIC is not set=0A=
CONFIG_INTEL_SOC_PMIC_BXTWC=3Dy=0A=
CONFIG_INTEL_SOC_PMIC_CHTWC=3Dy=0A=
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set=0A=
# CONFIG_MFD_INTEL_LPSS_ACPI is not set=0A=
# CONFIG_MFD_INTEL_LPSS_PCI is not set=0A=
CONFIG_MFD_INTEL_PMC_BXT=3Dy=0A=
# CONFIG_MFD_IQS62X is not set=0A=
# CONFIG_MFD_JANZ_CMODIO is not set=0A=
# CONFIG_MFD_KEMPLD is not set=0A=
# CONFIG_MFD_88PM800 is not set=0A=
# CONFIG_MFD_88PM805 is not set=0A=
# CONFIG_MFD_88PM860X is not set=0A=
# CONFIG_MFD_88PM886_PMIC is not set=0A=
# CONFIG_MFD_MAX14577 is not set=0A=
# CONFIG_MFD_MAX77541 is not set=0A=
# CONFIG_MFD_MAX77620 is not set=0A=
# CONFIG_MFD_MAX77650 is not set=0A=
# CONFIG_MFD_MAX77686 is not set=0A=
# CONFIG_MFD_MAX77693 is not set=0A=
# CONFIG_MFD_MAX77714 is not set=0A=
# CONFIG_MFD_MAX77843 is not set=0A=
# CONFIG_MFD_MAX8907 is not set=0A=
# CONFIG_MFD_MAX8925 is not set=0A=
# CONFIG_MFD_MAX8997 is not set=0A=
# CONFIG_MFD_MAX8998 is not set=0A=
CONFIG_MFD_MT6360=3Dy=0A=
CONFIG_MFD_MT6370=3Dy=0A=
# CONFIG_MFD_MT6397 is not set=0A=
# CONFIG_MFD_MENF21BMC is not set=0A=
# CONFIG_MFD_OCELOT is not set=0A=
# CONFIG_EZX_PCAP is not set=0A=
# CONFIG_MFD_CPCAP is not set=0A=
CONFIG_MFD_VIPERBOARD=3Dy=0A=
# CONFIG_MFD_NTXEC is not set=0A=
CONFIG_MFD_RETU=3Dy=0A=
# CONFIG_MFD_PCF50633 is not set=0A=
# CONFIG_MFD_SY7636A is not set=0A=
# CONFIG_MFD_RDC321X is not set=0A=
# CONFIG_MFD_RT4831 is not set=0A=
# CONFIG_MFD_RT5033 is not set=0A=
# CONFIG_MFD_RT5120 is not set=0A=
# CONFIG_MFD_RC5T583 is not set=0A=
# CONFIG_MFD_RK8XX_I2C is not set=0A=
# CONFIG_MFD_RK8XX_SPI is not set=0A=
# CONFIG_MFD_RN5T618 is not set=0A=
# CONFIG_MFD_SEC_CORE is not set=0A=
# CONFIG_MFD_SI476X_CORE is not set=0A=
# CONFIG_MFD_SM501 is not set=0A=
# CONFIG_MFD_SKY81452 is not set=0A=
# CONFIG_MFD_STMPE is not set=0A=
CONFIG_MFD_SYSCON=3Dy=0A=
# CONFIG_MFD_LP3943 is not set=0A=
# CONFIG_MFD_LP8788 is not set=0A=
# CONFIG_MFD_TI_LMU is not set=0A=
# CONFIG_MFD_PALMAS is not set=0A=
# CONFIG_TPS6105X is not set=0A=
# CONFIG_TPS65010 is not set=0A=
# CONFIG_TPS6507X is not set=0A=
# CONFIG_MFD_TPS65086 is not set=0A=
# CONFIG_MFD_TPS65090 is not set=0A=
# CONFIG_MFD_TPS65217 is not set=0A=
# CONFIG_MFD_TI_LP873X is not set=0A=
# CONFIG_MFD_TI_LP87565 is not set=0A=
# CONFIG_MFD_TPS65218 is not set=0A=
# CONFIG_MFD_TPS65219 is not set=0A=
# CONFIG_MFD_TPS6586X is not set=0A=
# CONFIG_MFD_TPS65910 is not set=0A=
# CONFIG_MFD_TPS65912_I2C is not set=0A=
# CONFIG_MFD_TPS65912_SPI is not set=0A=
# CONFIG_MFD_TPS6594_I2C is not set=0A=
# CONFIG_MFD_TPS6594_SPI is not set=0A=
CONFIG_TWL4030_CORE=3Dy=0A=
# CONFIG_MFD_TWL4030_AUDIO is not set=0A=
# CONFIG_TWL6040_CORE is not set=0A=
# CONFIG_MFD_WL1273_CORE is not set=0A=
# CONFIG_MFD_LM3533 is not set=0A=
# CONFIG_MFD_TC3589X is not set=0A=
# CONFIG_MFD_TQMX86 is not set=0A=
# CONFIG_MFD_VX855 is not set=0A=
# CONFIG_MFD_LOCHNAGAR is not set=0A=
# CONFIG_MFD_ARIZONA_I2C is not set=0A=
# CONFIG_MFD_ARIZONA_SPI is not set=0A=
# CONFIG_MFD_WM8400 is not set=0A=
# CONFIG_MFD_WM831X_I2C is not set=0A=
# CONFIG_MFD_WM831X_SPI is not set=0A=
# CONFIG_MFD_WM8350_I2C is not set=0A=
# CONFIG_MFD_WM8994 is not set=0A=
# CONFIG_MFD_ROHM_BD718XX is not set=0A=
# CONFIG_MFD_ROHM_BD71828 is not set=0A=
# CONFIG_MFD_ROHM_BD957XMUF is not set=0A=
# CONFIG_MFD_ROHM_BD96801 is not set=0A=
# CONFIG_MFD_STPMIC1 is not set=0A=
# CONFIG_MFD_STMFX is not set=0A=
# CONFIG_MFD_ATC260X_I2C is not set=0A=
# CONFIG_MFD_QCOM_PM8008 is not set=0A=
# CONFIG_MFD_CS40L50_I2C is not set=0A=
# CONFIG_MFD_CS40L50_SPI is not set=0A=
# CONFIG_RAVE_SP_CORE is not set=0A=
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set=0A=
# CONFIG_MFD_RSMU_I2C is not set=0A=
# CONFIG_MFD_RSMU_SPI is not set=0A=
# end of Multifunction device drivers=0A=
=0A=
CONFIG_REGULATOR=3Dy=0A=
# CONFIG_REGULATOR_DEBUG is not set=0A=
CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy=0A=
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set=0A=
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set=0A=
# CONFIG_REGULATOR_NETLINK_EVENTS is not set=0A=
# CONFIG_REGULATOR_88PG86X is not set=0A=
# CONFIG_REGULATOR_ACT8865 is not set=0A=
# CONFIG_REGULATOR_AD5398 is not set=0A=
# CONFIG_REGULATOR_AW37503 is not set=0A=
# CONFIG_REGULATOR_DA9121 is not set=0A=
# CONFIG_REGULATOR_DA9210 is not set=0A=
# CONFIG_REGULATOR_DA9211 is not set=0A=
# CONFIG_REGULATOR_FAN53555 is not set=0A=
# CONFIG_REGULATOR_FAN53880 is not set=0A=
# CONFIG_REGULATOR_GPIO is not set=0A=
# CONFIG_REGULATOR_ISL9305 is not set=0A=
# CONFIG_REGULATOR_ISL6271A is not set=0A=
# CONFIG_REGULATOR_LP3971 is not set=0A=
# CONFIG_REGULATOR_LP3972 is not set=0A=
# CONFIG_REGULATOR_LP872X is not set=0A=
# CONFIG_REGULATOR_LP8755 is not set=0A=
# CONFIG_REGULATOR_LTC3589 is not set=0A=
# CONFIG_REGULATOR_LTC3676 is not set=0A=
# CONFIG_REGULATOR_MAX1586 is not set=0A=
# CONFIG_REGULATOR_MAX77503 is not set=0A=
# CONFIG_REGULATOR_MAX77857 is not set=0A=
# CONFIG_REGULATOR_MAX8649 is not set=0A=
# CONFIG_REGULATOR_MAX8660 is not set=0A=
# CONFIG_REGULATOR_MAX8893 is not set=0A=
# CONFIG_REGULATOR_MAX8952 is not set=0A=
# CONFIG_REGULATOR_MAX20086 is not set=0A=
# CONFIG_REGULATOR_MAX20411 is not set=0A=
# CONFIG_REGULATOR_MAX77826 is not set=0A=
# CONFIG_REGULATOR_MCP16502 is not set=0A=
# CONFIG_REGULATOR_MP5416 is not set=0A=
# CONFIG_REGULATOR_MP8859 is not set=0A=
# CONFIG_REGULATOR_MP886X is not set=0A=
# CONFIG_REGULATOR_MPQ7920 is not set=0A=
# CONFIG_REGULATOR_MT6311 is not set=0A=
# CONFIG_REGULATOR_MT6360 is not set=0A=
# CONFIG_REGULATOR_MT6370 is not set=0A=
# CONFIG_REGULATOR_PCA9450 is not set=0A=
# CONFIG_REGULATOR_PF8X00 is not set=0A=
# CONFIG_REGULATOR_PFUZE100 is not set=0A=
# CONFIG_REGULATOR_PV88060 is not set=0A=
# CONFIG_REGULATOR_PV88080 is not set=0A=
# CONFIG_REGULATOR_PV88090 is not set=0A=
# CONFIG_REGULATOR_RAA215300 is not set=0A=
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set=0A=
# CONFIG_REGULATOR_RT4801 is not set=0A=
# CONFIG_REGULATOR_RT4803 is not set=0A=
# CONFIG_REGULATOR_RT5190A is not set=0A=
# CONFIG_REGULATOR_RT5739 is not set=0A=
# CONFIG_REGULATOR_RT5759 is not set=0A=
# CONFIG_REGULATOR_RT6160 is not set=0A=
# CONFIG_REGULATOR_RT6190 is not set=0A=
# CONFIG_REGULATOR_RT6245 is not set=0A=
# CONFIG_REGULATOR_RTQ2134 is not set=0A=
# CONFIG_REGULATOR_RTMV20 is not set=0A=
# CONFIG_REGULATOR_RTQ6752 is not set=0A=
# CONFIG_REGULATOR_RTQ2208 is not set=0A=
# CONFIG_REGULATOR_SLG51000 is not set=0A=
# CONFIG_REGULATOR_SY8106A is not set=0A=
# CONFIG_REGULATOR_SY8824X is not set=0A=
# CONFIG_REGULATOR_SY8827N is not set=0A=
# CONFIG_REGULATOR_TPS51632 is not set=0A=
# CONFIG_REGULATOR_TPS62360 is not set=0A=
# CONFIG_REGULATOR_TPS6286X is not set=0A=
# CONFIG_REGULATOR_TPS6287X is not set=0A=
# CONFIG_REGULATOR_TPS65023 is not set=0A=
# CONFIG_REGULATOR_TPS6507X is not set=0A=
# CONFIG_REGULATOR_TPS65132 is not set=0A=
# CONFIG_REGULATOR_TPS6524X is not set=0A=
CONFIG_REGULATOR_TWL4030=3Dy=0A=
# CONFIG_REGULATOR_VCTRL is not set=0A=
CONFIG_RC_CORE=3Dy=0A=
# CONFIG_LIRC is not set=0A=
# CONFIG_RC_MAP is not set=0A=
# CONFIG_RC_DECODERS is not set=0A=
CONFIG_RC_DEVICES=3Dy=0A=
# CONFIG_IR_ENE is not set=0A=
# CONFIG_IR_FINTEK is not set=0A=
# CONFIG_IR_GPIO_CIR is not set=0A=
# CONFIG_IR_HIX5HD2 is not set=0A=
CONFIG_IR_IGORPLUGUSB=3Dy=0A=
CONFIG_IR_IGUANA=3Dy=0A=
CONFIG_IR_IMON=3Dy=0A=
CONFIG_IR_IMON_RAW=3Dy=0A=
# CONFIG_IR_ITE_CIR is not set=0A=
CONFIG_IR_MCEUSB=3Dy=0A=
# CONFIG_IR_NUVOTON is not set=0A=
CONFIG_IR_REDRAT3=3Dy=0A=
# CONFIG_IR_SERIAL is not set=0A=
CONFIG_IR_STREAMZAP=3Dy=0A=
CONFIG_IR_TOY=3Dy=0A=
CONFIG_IR_TTUSBIR=3Dy=0A=
# CONFIG_IR_WINBOND_CIR is not set=0A=
CONFIG_RC_ATI_REMOTE=3Dy=0A=
# CONFIG_RC_LOOPBACK is not set=0A=
CONFIG_RC_XBOX_DVD=3Dy=0A=
CONFIG_CEC_CORE=3Dy=0A=
=0A=
#=0A=
# CEC support=0A=
#=0A=
# CONFIG_MEDIA_CEC_RC is not set=0A=
CONFIG_MEDIA_CEC_SUPPORT=3Dy=0A=
# CONFIG_CEC_CH7322 is not set=0A=
# CONFIG_CEC_GPIO is not set=0A=
# CONFIG_CEC_SECO is not set=0A=
# CONFIG_USB_EXTRON_DA_HD_4K_PLUS_CEC is not set=0A=
CONFIG_USB_PULSE8_CEC=3Dy=0A=
CONFIG_USB_RAINSHADOW_CEC=3Dy=0A=
# end of CEC support=0A=
=0A=
CONFIG_MEDIA_SUPPORT=3Dy=0A=
CONFIG_MEDIA_SUPPORT_FILTER=3Dy=0A=
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set=0A=
=0A=
#=0A=
# Media device types=0A=
#=0A=
CONFIG_MEDIA_CAMERA_SUPPORT=3Dy=0A=
CONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy=0A=
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy=0A=
CONFIG_MEDIA_RADIO_SUPPORT=3Dy=0A=
CONFIG_MEDIA_SDR_SUPPORT=3Dy=0A=
CONFIG_MEDIA_PLATFORM_SUPPORT=3Dy=0A=
CONFIG_MEDIA_TEST_SUPPORT=3Dy=0A=
# end of Media device types=0A=
=0A=
CONFIG_VIDEO_DEV=3Dy=0A=
CONFIG_MEDIA_CONTROLLER=3Dy=0A=
CONFIG_DVB_CORE=3Dy=0A=
=0A=
#=0A=
# Video4Linux options=0A=
#=0A=
CONFIG_VIDEO_V4L2_I2C=3Dy=0A=
CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy=0A=
# CONFIG_VIDEO_ADV_DEBUG is not set=0A=
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set=0A=
CONFIG_VIDEO_TUNER=3Dy=0A=
CONFIG_V4L2_MEM2MEM_DEV=3Dy=0A=
# end of Video4Linux options=0A=
=0A=
#=0A=
# Media controller options=0A=
#=0A=
CONFIG_MEDIA_CONTROLLER_DVB=3Dy=0A=
# end of Media controller options=0A=
=0A=
#=0A=
# Digital TV options=0A=
#=0A=
# CONFIG_DVB_MMAP is not set=0A=
# CONFIG_DVB_NET is not set=0A=
CONFIG_DVB_MAX_ADAPTERS=3D16=0A=
# CONFIG_DVB_DYNAMIC_MINORS is not set=0A=
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set=0A=
# CONFIG_DVB_ULE_DEBUG is not set=0A=
# end of Digital TV options=0A=
=0A=
#=0A=
# Media drivers=0A=
#=0A=
=0A=
#=0A=
# Drivers filtered as selected at 'Filter media drivers'=0A=
#=0A=
=0A=
#=0A=
# Media drivers=0A=
#=0A=
CONFIG_MEDIA_USB_SUPPORT=3Dy=0A=
=0A=
#=0A=
# Webcam devices=0A=
#=0A=
CONFIG_USB_GSPCA=3Dy=0A=
CONFIG_USB_GSPCA_BENQ=3Dy=0A=
CONFIG_USB_GSPCA_CONEX=3Dy=0A=
CONFIG_USB_GSPCA_CPIA1=3Dy=0A=
CONFIG_USB_GSPCA_DTCS033=3Dy=0A=
CONFIG_USB_GSPCA_ETOMS=3Dy=0A=
CONFIG_USB_GSPCA_FINEPIX=3Dy=0A=
CONFIG_USB_GSPCA_JEILINJ=3Dy=0A=
CONFIG_USB_GSPCA_JL2005BCD=3Dy=0A=
CONFIG_USB_GSPCA_KINECT=3Dy=0A=
CONFIG_USB_GSPCA_KONICA=3Dy=0A=
CONFIG_USB_GSPCA_MARS=3Dy=0A=
CONFIG_USB_GSPCA_MR97310A=3Dy=0A=
CONFIG_USB_GSPCA_NW80X=3Dy=0A=
CONFIG_USB_GSPCA_OV519=3Dy=0A=
CONFIG_USB_GSPCA_OV534=3Dy=0A=
CONFIG_USB_GSPCA_OV534_9=3Dy=0A=
CONFIG_USB_GSPCA_PAC207=3Dy=0A=
CONFIG_USB_GSPCA_PAC7302=3Dy=0A=
CONFIG_USB_GSPCA_PAC7311=3Dy=0A=
CONFIG_USB_GSPCA_SE401=3Dy=0A=
CONFIG_USB_GSPCA_SN9C2028=3Dy=0A=
CONFIG_USB_GSPCA_SN9C20X=3Dy=0A=
CONFIG_USB_GSPCA_SONIXB=3Dy=0A=
CONFIG_USB_GSPCA_SONIXJ=3Dy=0A=
CONFIG_USB_GSPCA_SPCA1528=3Dy=0A=
CONFIG_USB_GSPCA_SPCA500=3Dy=0A=
CONFIG_USB_GSPCA_SPCA501=3Dy=0A=
CONFIG_USB_GSPCA_SPCA505=3Dy=0A=
CONFIG_USB_GSPCA_SPCA506=3Dy=0A=
CONFIG_USB_GSPCA_SPCA508=3Dy=0A=
CONFIG_USB_GSPCA_SPCA561=3Dy=0A=
CONFIG_USB_GSPCA_SQ905=3Dy=0A=
CONFIG_USB_GSPCA_SQ905C=3Dy=0A=
CONFIG_USB_GSPCA_SQ930X=3Dy=0A=
CONFIG_USB_GSPCA_STK014=3Dy=0A=
CONFIG_USB_GSPCA_STK1135=3Dy=0A=
CONFIG_USB_GSPCA_STV0680=3Dy=0A=
CONFIG_USB_GSPCA_SUNPLUS=3Dy=0A=
CONFIG_USB_GSPCA_T613=3Dy=0A=
CONFIG_USB_GSPCA_TOPRO=3Dy=0A=
CONFIG_USB_GSPCA_TOUPTEK=3Dy=0A=
CONFIG_USB_GSPCA_TV8532=3Dy=0A=
CONFIG_USB_GSPCA_VC032X=3Dy=0A=
CONFIG_USB_GSPCA_VICAM=3Dy=0A=
CONFIG_USB_GSPCA_XIRLINK_CIT=3Dy=0A=
CONFIG_USB_GSPCA_ZC3XX=3Dy=0A=
CONFIG_USB_GL860=3Dy=0A=
CONFIG_USB_M5602=3Dy=0A=
CONFIG_USB_STV06XX=3Dy=0A=
CONFIG_USB_PWC=3Dy=0A=
# CONFIG_USB_PWC_DEBUG is not set=0A=
CONFIG_USB_PWC_INPUT_EVDEV=3Dy=0A=
CONFIG_USB_S2255=3Dy=0A=
CONFIG_VIDEO_USBTV=3Dy=0A=
CONFIG_USB_VIDEO_CLASS=3Dy=0A=
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy=0A=
=0A=
#=0A=
# Analog TV USB devices=0A=
#=0A=
CONFIG_VIDEO_GO7007=3Dy=0A=
CONFIG_VIDEO_GO7007_USB=3Dy=0A=
CONFIG_VIDEO_GO7007_LOADER=3Dy=0A=
CONFIG_VIDEO_GO7007_USB_S2250_BOARD=3Dy=0A=
CONFIG_VIDEO_HDPVR=3Dy=0A=
CONFIG_VIDEO_PVRUSB2=3Dy=0A=
CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy=0A=
CONFIG_VIDEO_PVRUSB2_DVB=3Dy=0A=
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set=0A=
CONFIG_VIDEO_STK1160=3Dy=0A=
=0A=
#=0A=
# Analog/digital TV USB devices=0A=
#=0A=
CONFIG_VIDEO_AU0828=3Dy=0A=
CONFIG_VIDEO_AU0828_V4L2=3Dy=0A=
CONFIG_VIDEO_AU0828_RC=3Dy=0A=
CONFIG_VIDEO_CX231XX=3Dy=0A=
CONFIG_VIDEO_CX231XX_RC=3Dy=0A=
CONFIG_VIDEO_CX231XX_ALSA=3Dy=0A=
CONFIG_VIDEO_CX231XX_DVB=3Dy=0A=
=0A=
#=0A=
# Digital TV USB devices=0A=
#=0A=
CONFIG_DVB_AS102=3Dy=0A=
CONFIG_DVB_B2C2_FLEXCOP_USB=3Dy=0A=
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set=0A=
CONFIG_DVB_USB_V2=3Dy=0A=
CONFIG_DVB_USB_AF9015=3Dy=0A=
CONFIG_DVB_USB_AF9035=3Dy=0A=
CONFIG_DVB_USB_ANYSEE=3Dy=0A=
CONFIG_DVB_USB_AU6610=3Dy=0A=
CONFIG_DVB_USB_AZ6007=3Dy=0A=
CONFIG_DVB_USB_CE6230=3Dy=0A=
CONFIG_DVB_USB_DVBSKY=3Dy=0A=
CONFIG_DVB_USB_EC168=3Dy=0A=
CONFIG_DVB_USB_GL861=3Dy=0A=
CONFIG_DVB_USB_LME2510=3Dy=0A=
CONFIG_DVB_USB_MXL111SF=3Dy=0A=
CONFIG_DVB_USB_RTL28XXU=3Dy=0A=
CONFIG_DVB_USB_ZD1301=3Dy=0A=
CONFIG_DVB_USB=3Dy=0A=
# CONFIG_DVB_USB_DEBUG is not set=0A=
CONFIG_DVB_USB_A800=3Dy=0A=
CONFIG_DVB_USB_AF9005=3Dy=0A=
CONFIG_DVB_USB_AF9005_REMOTE=3Dy=0A=
CONFIG_DVB_USB_AZ6027=3Dy=0A=
CONFIG_DVB_USB_CINERGY_T2=3Dy=0A=
CONFIG_DVB_USB_CXUSB=3Dy=0A=
CONFIG_DVB_USB_CXUSB_ANALOG=3Dy=0A=
CONFIG_DVB_USB_DIB0700=3Dy=0A=
CONFIG_DVB_USB_DIB3000MC=3Dy=0A=
CONFIG_DVB_USB_DIBUSB_MB=3Dy=0A=
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set=0A=
CONFIG_DVB_USB_DIBUSB_MC=3Dy=0A=
CONFIG_DVB_USB_DIGITV=3Dy=0A=
CONFIG_DVB_USB_DTT200U=3Dy=0A=
CONFIG_DVB_USB_DTV5100=3Dy=0A=
CONFIG_DVB_USB_DW2102=3Dy=0A=
CONFIG_DVB_USB_GP8PSK=3Dy=0A=
CONFIG_DVB_USB_M920X=3Dy=0A=
CONFIG_DVB_USB_NOVA_T_USB2=3Dy=0A=
CONFIG_DVB_USB_OPERA1=3Dy=0A=
CONFIG_DVB_USB_PCTV452E=3Dy=0A=
CONFIG_DVB_USB_TECHNISAT_USB2=3Dy=0A=
CONFIG_DVB_USB_TTUSB2=3Dy=0A=
CONFIG_DVB_USB_UMT_010=3Dy=0A=
CONFIG_DVB_USB_VP702X=3Dy=0A=
CONFIG_DVB_USB_VP7045=3Dy=0A=
CONFIG_SMS_USB_DRV=3Dy=0A=
CONFIG_DVB_TTUSB_BUDGET=3Dy=0A=
CONFIG_DVB_TTUSB_DEC=3Dy=0A=
=0A=
#=0A=
# Webcam, TV (analog/digital) USB devices=0A=
#=0A=
CONFIG_VIDEO_EM28XX=3Dy=0A=
CONFIG_VIDEO_EM28XX_V4L2=3Dy=0A=
CONFIG_VIDEO_EM28XX_ALSA=3Dy=0A=
CONFIG_VIDEO_EM28XX_DVB=3Dy=0A=
CONFIG_VIDEO_EM28XX_RC=3Dy=0A=
=0A=
#=0A=
# Software defined radio USB devices=0A=
#=0A=
CONFIG_USB_AIRSPY=3Dy=0A=
CONFIG_USB_HACKRF=3Dy=0A=
CONFIG_USB_MSI2500=3Dy=0A=
# CONFIG_MEDIA_PCI_SUPPORT is not set=0A=
CONFIG_RADIO_ADAPTERS=3Dy=0A=
# CONFIG_RADIO_MAXIRADIO is not set=0A=
# CONFIG_RADIO_SAA7706H is not set=0A=
CONFIG_RADIO_SHARK=3Dy=0A=
CONFIG_RADIO_SHARK2=3Dy=0A=
CONFIG_RADIO_SI4713=3Dy=0A=
CONFIG_RADIO_TEA575X=3Dy=0A=
# CONFIG_RADIO_TEA5764 is not set=0A=
# CONFIG_RADIO_TEF6862 is not set=0A=
# CONFIG_RADIO_WL1273 is not set=0A=
CONFIG_USB_DSBR=3Dy=0A=
CONFIG_USB_KEENE=3Dy=0A=
CONFIG_USB_MA901=3Dy=0A=
CONFIG_USB_MR800=3Dy=0A=
CONFIG_USB_RAREMONO=3Dy=0A=
CONFIG_RADIO_SI470X=3Dy=0A=
CONFIG_USB_SI470X=3Dy=0A=
# CONFIG_I2C_SI470X is not set=0A=
CONFIG_USB_SI4713=3Dy=0A=
# CONFIG_PLATFORM_SI4713 is not set=0A=
CONFIG_I2C_SI4713=3Dy=0A=
# CONFIG_MEDIA_PLATFORM_DRIVERS is not set=0A=
=0A=
#=0A=
# MMC/SDIO DVB adapters=0A=
#=0A=
CONFIG_SMS_SDIO_DRV=3Dy=0A=
CONFIG_V4L_TEST_DRIVERS=3Dy=0A=
CONFIG_VIDEO_VIM2M=3Dy=0A=
CONFIG_VIDEO_VICODEC=3Dy=0A=
CONFIG_VIDEO_VIMC=3Dy=0A=
CONFIG_VIDEO_VIVID=3Dy=0A=
CONFIG_VIDEO_VIVID_CEC=3Dy=0A=
CONFIG_VIDEO_VIVID_MAX_DEVS=3D64=0A=
# CONFIG_VIDEO_VISL is not set=0A=
CONFIG_DVB_TEST_DRIVERS=3Dy=0A=
CONFIG_DVB_VIDTV=3Dy=0A=
=0A=
#=0A=
# FireWire (IEEE 1394) Adapters=0A=
#=0A=
# CONFIG_DVB_FIREDTV is not set=0A=
CONFIG_MEDIA_COMMON_OPTIONS=3Dy=0A=
=0A=
#=0A=
# common driver options=0A=
#=0A=
CONFIG_CYPRESS_FIRMWARE=3Dy=0A=
CONFIG_TTPCI_EEPROM=3Dy=0A=
CONFIG_UVC_COMMON=3Dy=0A=
CONFIG_VIDEO_CX2341X=3Dy=0A=
CONFIG_VIDEO_TVEEPROM=3Dy=0A=
CONFIG_DVB_B2C2_FLEXCOP=3Dy=0A=
CONFIG_SMS_SIANO_MDTV=3Dy=0A=
CONFIG_SMS_SIANO_RC=3Dy=0A=
CONFIG_SMS_SIANO_DEBUGFS=3Dy=0A=
CONFIG_VIDEO_V4L2_TPG=3Dy=0A=
CONFIG_VIDEOBUF2_CORE=3Dy=0A=
CONFIG_VIDEOBUF2_V4L2=3Dy=0A=
CONFIG_VIDEOBUF2_MEMOPS=3Dy=0A=
CONFIG_VIDEOBUF2_DMA_CONTIG=3Dy=0A=
CONFIG_VIDEOBUF2_VMALLOC=3Dy=0A=
CONFIG_VIDEOBUF2_DMA_SG=3Dy=0A=
# end of Media drivers=0A=
=0A=
#=0A=
# Media ancillary drivers=0A=
#=0A=
CONFIG_MEDIA_ATTACH=3Dy=0A=
# CONFIG_VIDEO_IR_I2C is not set=0A=
# CONFIG_VIDEO_CAMERA_SENSOR is not set=0A=
=0A=
#=0A=
# Camera ISPs=0A=
#=0A=
# CONFIG_VIDEO_THP7312 is not set=0A=
# end of Camera ISPs=0A=
=0A=
#=0A=
# Lens drivers=0A=
#=0A=
# CONFIG_VIDEO_AD5820 is not set=0A=
# CONFIG_VIDEO_AK7375 is not set=0A=
# CONFIG_VIDEO_DW9714 is not set=0A=
# CONFIG_VIDEO_DW9719 is not set=0A=
# CONFIG_VIDEO_DW9768 is not set=0A=
# CONFIG_VIDEO_DW9807_VCM is not set=0A=
# end of Lens drivers=0A=
=0A=
#=0A=
# Flash devices=0A=
#=0A=
# CONFIG_VIDEO_ADP1653 is not set=0A=
# CONFIG_VIDEO_LM3560 is not set=0A=
# CONFIG_VIDEO_LM3646 is not set=0A=
# end of Flash devices=0A=
=0A=
#=0A=
# Audio decoders, processors and mixers=0A=
#=0A=
# CONFIG_VIDEO_CS3308 is not set=0A=
# CONFIG_VIDEO_CS5345 is not set=0A=
CONFIG_VIDEO_CS53L32A=3Dy=0A=
CONFIG_VIDEO_MSP3400=3Dy=0A=
# CONFIG_VIDEO_SONY_BTF_MPX is not set=0A=
# CONFIG_VIDEO_TDA1997X is not set=0A=
# CONFIG_VIDEO_TDA7432 is not set=0A=
# CONFIG_VIDEO_TDA9840 is not set=0A=
# CONFIG_VIDEO_TEA6415C is not set=0A=
# CONFIG_VIDEO_TEA6420 is not set=0A=
# CONFIG_VIDEO_TLV320AIC23B is not set=0A=
# CONFIG_VIDEO_TVAUDIO is not set=0A=
# CONFIG_VIDEO_UDA1342 is not set=0A=
# CONFIG_VIDEO_VP27SMPX is not set=0A=
# CONFIG_VIDEO_WM8739 is not set=0A=
CONFIG_VIDEO_WM8775=3Dy=0A=
# end of Audio decoders, processors and mixers=0A=
=0A=
#=0A=
# RDS decoders=0A=
#=0A=
# CONFIG_VIDEO_SAA6588 is not set=0A=
# end of RDS decoders=0A=
=0A=
#=0A=
# Video decoders=0A=
#=0A=
# CONFIG_VIDEO_ADV7180 is not set=0A=
# CONFIG_VIDEO_ADV7183 is not set=0A=
# CONFIG_VIDEO_ADV748X is not set=0A=
# CONFIG_VIDEO_ADV7604 is not set=0A=
# CONFIG_VIDEO_ADV7842 is not set=0A=
# CONFIG_VIDEO_BT819 is not set=0A=
# CONFIG_VIDEO_BT856 is not set=0A=
# CONFIG_VIDEO_BT866 is not set=0A=
# CONFIG_VIDEO_ISL7998X is not set=0A=
# CONFIG_VIDEO_KS0127 is not set=0A=
# CONFIG_VIDEO_MAX9286 is not set=0A=
# CONFIG_VIDEO_ML86V7667 is not set=0A=
# CONFIG_VIDEO_SAA7110 is not set=0A=
CONFIG_VIDEO_SAA711X=3Dy=0A=
# CONFIG_VIDEO_TC358743 is not set=0A=
# CONFIG_VIDEO_TC358746 is not set=0A=
# CONFIG_VIDEO_TVP514X is not set=0A=
# CONFIG_VIDEO_TVP5150 is not set=0A=
# CONFIG_VIDEO_TVP7002 is not set=0A=
# CONFIG_VIDEO_TW2804 is not set=0A=
# CONFIG_VIDEO_TW9900 is not set=0A=
# CONFIG_VIDEO_TW9903 is not set=0A=
# CONFIG_VIDEO_TW9906 is not set=0A=
# CONFIG_VIDEO_TW9910 is not set=0A=
# CONFIG_VIDEO_VPX3220 is not set=0A=
=0A=
#=0A=
# Video and audio decoders=0A=
#=0A=
# CONFIG_VIDEO_SAA717X is not set=0A=
CONFIG_VIDEO_CX25840=3Dy=0A=
# end of Video decoders=0A=
=0A=
#=0A=
# Video encoders=0A=
#=0A=
# CONFIG_VIDEO_ADV7170 is not set=0A=
# CONFIG_VIDEO_ADV7175 is not set=0A=
# CONFIG_VIDEO_ADV7343 is not set=0A=
# CONFIG_VIDEO_ADV7393 is not set=0A=
# CONFIG_VIDEO_ADV7511 is not set=0A=
# CONFIG_VIDEO_AK881X is not set=0A=
# CONFIG_VIDEO_SAA7127 is not set=0A=
# CONFIG_VIDEO_SAA7185 is not set=0A=
# CONFIG_VIDEO_THS8200 is not set=0A=
# end of Video encoders=0A=
=0A=
#=0A=
# Video improvement chips=0A=
#=0A=
# CONFIG_VIDEO_UPD64031A is not set=0A=
# CONFIG_VIDEO_UPD64083 is not set=0A=
# end of Video improvement chips=0A=
=0A=
#=0A=
# Audio/Video compression chips=0A=
#=0A=
# CONFIG_VIDEO_SAA6752HS is not set=0A=
# end of Audio/Video compression chips=0A=
=0A=
#=0A=
# SDR tuner chips=0A=
#=0A=
# CONFIG_SDR_MAX2175 is not set=0A=
# end of SDR tuner chips=0A=
=0A=
#=0A=
# Miscellaneous helper chips=0A=
#=0A=
# CONFIG_VIDEO_I2C is not set=0A=
# CONFIG_VIDEO_M52790 is not set=0A=
# CONFIG_VIDEO_ST_MIPID02 is not set=0A=
# CONFIG_VIDEO_THS7303 is not set=0A=
# end of Miscellaneous helper chips=0A=
=0A=
#=0A=
# Video serializers and deserializers=0A=
#=0A=
# CONFIG_VIDEO_DS90UB913 is not set=0A=
# CONFIG_VIDEO_DS90UB953 is not set=0A=
# CONFIG_VIDEO_DS90UB960 is not set=0A=
# CONFIG_VIDEO_MAX96714 is not set=0A=
# CONFIG_VIDEO_MAX96717 is not set=0A=
# end of Video serializers and deserializers=0A=
=0A=
#=0A=
# Media SPI Adapters=0A=
#=0A=
# CONFIG_CXD2880_SPI_DRV is not set=0A=
# CONFIG_VIDEO_GS1662 is not set=0A=
# end of Media SPI Adapters=0A=
=0A=
CONFIG_MEDIA_TUNER=3Dy=0A=
=0A=
#=0A=
# Customize TV tuners=0A=
#=0A=
# CONFIG_MEDIA_TUNER_E4000 is not set=0A=
# CONFIG_MEDIA_TUNER_FC0011 is not set=0A=
# CONFIG_MEDIA_TUNER_FC0012 is not set=0A=
# CONFIG_MEDIA_TUNER_FC0013 is not set=0A=
# CONFIG_MEDIA_TUNER_FC2580 is not set=0A=
# CONFIG_MEDIA_TUNER_IT913X is not set=0A=
# CONFIG_MEDIA_TUNER_M88RS6000T is not set=0A=
# CONFIG_MEDIA_TUNER_MAX2165 is not set=0A=
# CONFIG_MEDIA_TUNER_MC44S803 is not set=0A=
CONFIG_MEDIA_TUNER_MSI001=3Dy=0A=
# CONFIG_MEDIA_TUNER_MT2060 is not set=0A=
# CONFIG_MEDIA_TUNER_MT2063 is not set=0A=
# CONFIG_MEDIA_TUNER_MT20XX is not set=0A=
# CONFIG_MEDIA_TUNER_MT2131 is not set=0A=
# CONFIG_MEDIA_TUNER_MT2266 is not set=0A=
# CONFIG_MEDIA_TUNER_MXL301RF is not set=0A=
# CONFIG_MEDIA_TUNER_MXL5005S is not set=0A=
# CONFIG_MEDIA_TUNER_MXL5007T is not set=0A=
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set=0A=
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set=0A=
# CONFIG_MEDIA_TUNER_QT1010 is not set=0A=
# CONFIG_MEDIA_TUNER_R820T is not set=0A=
# CONFIG_MEDIA_TUNER_SI2157 is not set=0A=
# CONFIG_MEDIA_TUNER_SIMPLE is not set=0A=
# CONFIG_MEDIA_TUNER_TDA18212 is not set=0A=
# CONFIG_MEDIA_TUNER_TDA18218 is not set=0A=
# CONFIG_MEDIA_TUNER_TDA18250 is not set=0A=
# CONFIG_MEDIA_TUNER_TDA18271 is not set=0A=
# CONFIG_MEDIA_TUNER_TDA827X is not set=0A=
# CONFIG_MEDIA_TUNER_TDA8290 is not set=0A=
# CONFIG_MEDIA_TUNER_TDA9887 is not set=0A=
# CONFIG_MEDIA_TUNER_TEA5761 is not set=0A=
# CONFIG_MEDIA_TUNER_TEA5767 is not set=0A=
# CONFIG_MEDIA_TUNER_TUA9001 is not set=0A=
# CONFIG_MEDIA_TUNER_XC2028 is not set=0A=
# CONFIG_MEDIA_TUNER_XC4000 is not set=0A=
# CONFIG_MEDIA_TUNER_XC5000 is not set=0A=
# end of Customize TV tuners=0A=
=0A=
#=0A=
# Customise DVB Frontends=0A=
#=0A=
=0A=
#=0A=
# Multistandard (satellite) frontends=0A=
#=0A=
# CONFIG_DVB_M88DS3103 is not set=0A=
# CONFIG_DVB_MXL5XX is not set=0A=
# CONFIG_DVB_STB0899 is not set=0A=
# CONFIG_DVB_STB6100 is not set=0A=
# CONFIG_DVB_STV090x is not set=0A=
# CONFIG_DVB_STV0910 is not set=0A=
# CONFIG_DVB_STV6110x is not set=0A=
# CONFIG_DVB_STV6111 is not set=0A=
=0A=
#=0A=
# Multistandard (cable + terrestrial) frontends=0A=
#=0A=
# CONFIG_DVB_DRXK is not set=0A=
# CONFIG_DVB_MN88472 is not set=0A=
# CONFIG_DVB_MN88473 is not set=0A=
# CONFIG_DVB_SI2165 is not set=0A=
# CONFIG_DVB_TDA18271C2DD is not set=0A=
=0A=
#=0A=
# DVB-S (satellite) frontends=0A=
#=0A=
# CONFIG_DVB_CX24110 is not set=0A=
# CONFIG_DVB_CX24116 is not set=0A=
# CONFIG_DVB_CX24117 is not set=0A=
# CONFIG_DVB_CX24120 is not set=0A=
# CONFIG_DVB_CX24123 is not set=0A=
# CONFIG_DVB_DS3000 is not set=0A=
# CONFIG_DVB_MB86A16 is not set=0A=
# CONFIG_DVB_MT312 is not set=0A=
# CONFIG_DVB_S5H1420 is not set=0A=
# CONFIG_DVB_SI21XX is not set=0A=
# CONFIG_DVB_STB6000 is not set=0A=
# CONFIG_DVB_STV0288 is not set=0A=
# CONFIG_DVB_STV0299 is not set=0A=
# CONFIG_DVB_STV0900 is not set=0A=
# CONFIG_DVB_STV6110 is not set=0A=
# CONFIG_DVB_TDA10071 is not set=0A=
# CONFIG_DVB_TDA10086 is not set=0A=
# CONFIG_DVB_TDA8083 is not set=0A=
# CONFIG_DVB_TDA8261 is not set=0A=
# CONFIG_DVB_TDA826X is not set=0A=
# CONFIG_DVB_TS2020 is not set=0A=
# CONFIG_DVB_TUA6100 is not set=0A=
# CONFIG_DVB_TUNER_CX24113 is not set=0A=
# CONFIG_DVB_TUNER_ITD1000 is not set=0A=
# CONFIG_DVB_VES1X93 is not set=0A=
# CONFIG_DVB_ZL10036 is not set=0A=
# CONFIG_DVB_ZL10039 is not set=0A=
=0A=
#=0A=
# DVB-T (terrestrial) frontends=0A=
#=0A=
CONFIG_DVB_AF9013=3Dy=0A=
CONFIG_DVB_AS102_FE=3Dy=0A=
# CONFIG_DVB_CX22700 is not set=0A=
# CONFIG_DVB_CX22702 is not set=0A=
# CONFIG_DVB_CXD2820R is not set=0A=
# CONFIG_DVB_CXD2841ER is not set=0A=
CONFIG_DVB_DIB3000MB=3Dy=0A=
CONFIG_DVB_DIB3000MC=3Dy=0A=
# CONFIG_DVB_DIB7000M is not set=0A=
# CONFIG_DVB_DIB7000P is not set=0A=
# CONFIG_DVB_DIB9000 is not set=0A=
# CONFIG_DVB_DRXD is not set=0A=
CONFIG_DVB_EC100=3Dy=0A=
CONFIG_DVB_GP8PSK_FE=3Dy=0A=
# CONFIG_DVB_L64781 is not set=0A=
# CONFIG_DVB_MT352 is not set=0A=
# CONFIG_DVB_NXT6000 is not set=0A=
CONFIG_DVB_RTL2830=3Dy=0A=
CONFIG_DVB_RTL2832=3Dy=0A=
CONFIG_DVB_RTL2832_SDR=3Dy=0A=
# CONFIG_DVB_S5H1432 is not set=0A=
# CONFIG_DVB_SI2168 is not set=0A=
# CONFIG_DVB_SP887X is not set=0A=
# CONFIG_DVB_STV0367 is not set=0A=
# CONFIG_DVB_TDA10048 is not set=0A=
# CONFIG_DVB_TDA1004X is not set=0A=
# CONFIG_DVB_ZD1301_DEMOD is not set=0A=
CONFIG_DVB_ZL10353=3Dy=0A=
# CONFIG_DVB_CXD2880 is not set=0A=
=0A=
#=0A=
# DVB-C (cable) frontends=0A=
#=0A=
# CONFIG_DVB_STV0297 is not set=0A=
# CONFIG_DVB_TDA10021 is not set=0A=
# CONFIG_DVB_TDA10023 is not set=0A=
# CONFIG_DVB_VES1820 is not set=0A=
=0A=
#=0A=
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends=0A=
#=0A=
# CONFIG_DVB_AU8522_DTV is not set=0A=
# CONFIG_DVB_AU8522_V4L is not set=0A=
# CONFIG_DVB_BCM3510 is not set=0A=
# CONFIG_DVB_LG2160 is not set=0A=
# CONFIG_DVB_LGDT3305 is not set=0A=
# CONFIG_DVB_LGDT3306A is not set=0A=
# CONFIG_DVB_LGDT330X is not set=0A=
# CONFIG_DVB_MXL692 is not set=0A=
# CONFIG_DVB_NXT200X is not set=0A=
# CONFIG_DVB_OR51132 is not set=0A=
# CONFIG_DVB_OR51211 is not set=0A=
# CONFIG_DVB_S5H1409 is not set=0A=
# CONFIG_DVB_S5H1411 is not set=0A=
=0A=
#=0A=
# ISDB-T (terrestrial) frontends=0A=
#=0A=
# CONFIG_DVB_DIB8000 is not set=0A=
# CONFIG_DVB_MB86A20S is not set=0A=
# CONFIG_DVB_S921 is not set=0A=
=0A=
#=0A=
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends=0A=
#=0A=
# CONFIG_DVB_MN88443X is not set=0A=
# CONFIG_DVB_TC90522 is not set=0A=
=0A=
#=0A=
# Digital terrestrial only tuners/PLL=0A=
#=0A=
# CONFIG_DVB_PLL is not set=0A=
# CONFIG_DVB_TUNER_DIB0070 is not set=0A=
# CONFIG_DVB_TUNER_DIB0090 is not set=0A=
=0A=
#=0A=
# SEC control devices for DVB-S=0A=
#=0A=
# CONFIG_DVB_A8293 is not set=0A=
CONFIG_DVB_AF9033=3Dy=0A=
# CONFIG_DVB_ASCOT2E is not set=0A=
# CONFIG_DVB_ATBM8830 is not set=0A=
# CONFIG_DVB_HELENE is not set=0A=
# CONFIG_DVB_HORUS3A is not set=0A=
# CONFIG_DVB_ISL6405 is not set=0A=
# CONFIG_DVB_ISL6421 is not set=0A=
# CONFIG_DVB_ISL6423 is not set=0A=
# CONFIG_DVB_IX2505V is not set=0A=
# CONFIG_DVB_LGS8GL5 is not set=0A=
# CONFIG_DVB_LGS8GXX is not set=0A=
# CONFIG_DVB_LNBH25 is not set=0A=
# CONFIG_DVB_LNBH29 is not set=0A=
# CONFIG_DVB_LNBP21 is not set=0A=
# CONFIG_DVB_LNBP22 is not set=0A=
# CONFIG_DVB_M88RS2000 is not set=0A=
# CONFIG_DVB_TDA665x is not set=0A=
# CONFIG_DVB_DRX39XYJ is not set=0A=
=0A=
#=0A=
# Common Interface (EN50221) controller drivers=0A=
#=0A=
# CONFIG_DVB_CXD2099 is not set=0A=
# CONFIG_DVB_SP2 is not set=0A=
# end of Customise DVB Frontends=0A=
=0A=
#=0A=
# Tools to develop new frontends=0A=
#=0A=
# CONFIG_DVB_DUMMY_FE is not set=0A=
# end of Media ancillary drivers=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
CONFIG_APERTURE_HELPERS=3Dy=0A=
CONFIG_SCREEN_INFO=3Dy=0A=
CONFIG_VIDEO=3Dy=0A=
# CONFIG_AUXDISPLAY is not set=0A=
# CONFIG_PANEL is not set=0A=
CONFIG_AGP=3Dy=0A=
CONFIG_AGP_AMD64=3Dy=0A=
CONFIG_AGP_INTEL=3Dy=0A=
# CONFIG_AGP_SIS is not set=0A=
# CONFIG_AGP_VIA is not set=0A=
CONFIG_INTEL_GTT=3Dy=0A=
# CONFIG_VGA_SWITCHEROO is not set=0A=
CONFIG_DRM=3Dy=0A=
CONFIG_DRM_MIPI_DSI=3Dy=0A=
CONFIG_DRM_DEBUG_MM=3Dy=0A=
CONFIG_DRM_KMS_HELPER=3Dy=0A=
# CONFIG_DRM_PANIC is not set=0A=
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set=0A=
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set=0A=
CONFIG_DRM_CLIENT=3Dy=0A=
CONFIG_DRM_CLIENT_LIB=3Dy=0A=
CONFIG_DRM_CLIENT_SELECTION=3Dy=0A=
CONFIG_DRM_CLIENT_SETUP=3Dy=0A=
=0A=
#=0A=
# Supported DRM clients=0A=
#=0A=
CONFIG_DRM_FBDEV_EMULATION=3Dy=0A=
CONFIG_DRM_FBDEV_OVERALLOC=3D100=0A=
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set=0A=
# end of Supported DRM clients=0A=
=0A=
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set=0A=
CONFIG_DRM_DISPLAY_DP_AUX_BUS=3Dy=0A=
CONFIG_DRM_DISPLAY_HELPER=3Dy=0A=
# CONFIG_DRM_DISPLAY_DP_AUX_CEC is not set=0A=
# CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV is not set=0A=
CONFIG_DRM_DISPLAY_DP_HELPER=3Dy=0A=
CONFIG_DRM_DISPLAY_DSC_HELPER=3Dy=0A=
CONFIG_DRM_DISPLAY_HDCP_HELPER=3Dy=0A=
CONFIG_DRM_DISPLAY_HDMI_HELPER=3Dy=0A=
CONFIG_DRM_TTM=3Dy=0A=
CONFIG_DRM_BUDDY=3Dy=0A=
CONFIG_DRM_TTM_HELPER=3Dy=0A=
CONFIG_DRM_GEM_SHMEM_HELPER=3Dy=0A=
=0A=
#=0A=
# I2C encoder or helper chips=0A=
#=0A=
# CONFIG_DRM_I2C_CH7006 is not set=0A=
# CONFIG_DRM_I2C_SIL164 is not set=0A=
# CONFIG_DRM_I2C_NXP_TDA998X is not set=0A=
# CONFIG_DRM_I2C_NXP_TDA9950 is not set=0A=
# end of I2C encoder or helper chips=0A=
=0A=
#=0A=
# ARM devices=0A=
#=0A=
# CONFIG_DRM_KOMEDA is not set=0A=
# end of ARM devices=0A=
=0A=
# CONFIG_DRM_RADEON is not set=0A=
# CONFIG_DRM_AMDGPU is not set=0A=
# CONFIG_DRM_NOUVEAU is not set=0A=
CONFIG_DRM_I915=3Dy=0A=
CONFIG_DRM_I915_FORCE_PROBE=3D""=0A=
CONFIG_DRM_I915_CAPTURE_ERROR=3Dy=0A=
CONFIG_DRM_I915_COMPRESS_ERROR=3Dy=0A=
CONFIG_DRM_I915_USERPTR=3Dy=0A=
# CONFIG_DRM_I915_GVT_KVMGT is not set=0A=
# CONFIG_DRM_I915_DP_TUNNEL is not set=0A=
=0A=
#=0A=
# drm/i915 Debugging=0A=
#=0A=
# CONFIG_DRM_I915_WERROR is not set=0A=
# CONFIG_DRM_I915_REPLAY_GPU_HANGS_API is not set=0A=
# CONFIG_DRM_I915_DEBUG is not set=0A=
# CONFIG_DRM_I915_DEBUG_MMIO is not set=0A=
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set=0A=
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set=0A=
# CONFIG_DRM_I915_DEBUG_GUC is not set=0A=
# CONFIG_DRM_I915_SELFTEST is not set=0A=
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set=0A=
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set=0A=
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set=0A=
# CONFIG_DRM_I915_DEBUG_WAKEREF is not set=0A=
# end of drm/i915 Debugging=0A=
=0A=
#=0A=
# drm/i915 Profile Guided Optimisation=0A=
#=0A=
CONFIG_DRM_I915_REQUEST_TIMEOUT=3D20000=0A=
CONFIG_DRM_I915_FENCE_TIMEOUT=3D10000=0A=
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250=0A=
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500=0A=
CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640=0A=
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=3D7500=0A=
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D8000=0A=
CONFIG_DRM_I915_STOP_TIMEOUT=3D100=0A=
CONFIG_DRM_I915_TIMESLICE_DURATION=3D1=0A=
# end of drm/i915 Profile Guided Optimisation=0A=
=0A=
# CONFIG_DRM_XE is not set=0A=
CONFIG_DRM_VGEM=3Dy=0A=
CONFIG_DRM_VKMS=3Dy=0A=
CONFIG_DRM_VMWGFX=3Dy=0A=
# CONFIG_DRM_VMWGFX_MKSSTATS is not set=0A=
# CONFIG_DRM_GMA500 is not set=0A=
CONFIG_DRM_UDL=3Dy=0A=
# CONFIG_DRM_AST is not set=0A=
# CONFIG_DRM_MGAG200 is not set=0A=
# CONFIG_DRM_QXL is not set=0A=
CONFIG_DRM_VIRTIO_GPU=3Dy=0A=
CONFIG_DRM_VIRTIO_GPU_KMS=3Dy=0A=
CONFIG_DRM_PANEL=3Dy=0A=
=0A=
#=0A=
# Display Panels=0A=
#=0A=
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set=0A=
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set=0A=
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set=0A=
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set=0A=
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set=0A=
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set=0A=
# CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A is not set=0A=
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set=0A=
# CONFIG_DRM_PANEL_BOE_TV101WUM_LL2 is not set=0A=
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set=0A=
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set=0A=
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set=0A=
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set=0A=
# CONFIG_DRM_PANEL_DSI_CM is not set=0A=
# CONFIG_DRM_PANEL_LVDS is not set=0A=
# CONFIG_DRM_PANEL_HIMAX_HX83102 is not set=0A=
# CONFIG_DRM_PANEL_HIMAX_HX83112A is not set=0A=
# CONFIG_DRM_PANEL_HIMAX_HX8394 is not set=0A=
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set=0A=
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set=0A=
# CONFIG_DRM_PANEL_ILITEK_ILI9805 is not set=0A=
# CONFIG_DRM_PANEL_ILITEK_ILI9806E is not set=0A=
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set=0A=
# CONFIG_DRM_PANEL_ILITEK_ILI9882T is not set=0A=
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set=0A=
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set=0A=
# CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set=0A=
# CONFIG_DRM_PANEL_JDI_LPM102A188A is not set=0A=
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set=0A=
# CONFIG_DRM_PANEL_JDI_R63452 is not set=0A=
# CONFIG_DRM_PANEL_KHADAS_TS050 is not set=0A=
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set=0A=
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set=0A=
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set=0A=
# CONFIG_DRM_PANEL_LINCOLNTECH_LCD197 is not set=0A=
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set=0A=
# CONFIG_DRM_PANEL_LG_LG4573 is not set=0A=
# CONFIG_DRM_PANEL_LG_SW43408 is not set=0A=
# CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966 is not set=0A=
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set=0A=
# CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set=0A=
# CONFIG_DRM_PANEL_NEWVISION_NV3051D is not set=0A=
# CONFIG_DRM_PANEL_NEWVISION_NV3052C is not set=0A=
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set=0A=
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set=0A=
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set=0A=
# CONFIG_DRM_PANEL_NOVATEK_NT36523 is not set=0A=
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set=0A=
# CONFIG_DRM_PANEL_NOVATEK_NT36672E is not set=0A=
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set=0A=
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set=0A=
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set=0A=
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set=0A=
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set=0A=
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set=0A=
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set=0A=
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set=0A=
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set=0A=
# CONFIG_DRM_PANEL_RAYDIUM_RM692E5 is not set=0A=
# CONFIG_DRM_PANEL_RAYDIUM_RM69380 is not set=0A=
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_AMS581VF01 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_AMS639RQ08 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS427AP24 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6E3FA7 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA8 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set=0A=
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set=0A=
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set=0A=
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set=0A=
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set=0A=
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set=0A=
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set=0A=
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set=0A=
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set=0A=
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set=0A=
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set=0A=
# CONFIG_DRM_PANEL_SONY_TD4353_JDI is not set=0A=
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set=0A=
# CONFIG_DRM_PANEL_STARTEK_KD070FHFID015 is not set=0A=
CONFIG_DRM_PANEL_EDP=3Dy=0A=
# CONFIG_DRM_PANEL_SIMPLE is not set=0A=
# CONFIG_DRM_PANEL_SYNAPTICS_R63353 is not set=0A=
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set=0A=
# CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set=0A=
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set=0A=
# CONFIG_DRM_PANEL_TPO_TPG110 is not set=0A=
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set=0A=
# CONFIG_DRM_PANEL_VISIONOX_R66451 is not set=0A=
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set=0A=
# CONFIG_DRM_PANEL_VISIONOX_VTDR6130 is not set=0A=
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set=0A=
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set=0A=
# end of Display Panels=0A=
=0A=
CONFIG_DRM_BRIDGE=3Dy=0A=
CONFIG_DRM_PANEL_BRIDGE=3Dy=0A=
CONFIG_DRM_AUX_BRIDGE=3Dy=0A=
=0A=
#=0A=
# Display Interface Bridges=0A=
#=0A=
# CONFIG_DRM_CHIPONE_ICN6211 is not set=0A=
# CONFIG_DRM_CHRONTEL_CH7033 is not set=0A=
# CONFIG_DRM_DISPLAY_CONNECTOR is not set=0A=
# CONFIG_DRM_ITE_IT6263 is not set=0A=
# CONFIG_DRM_ITE_IT6505 is not set=0A=
# CONFIG_DRM_LONTIUM_LT8912B is not set=0A=
# CONFIG_DRM_LONTIUM_LT9211 is not set=0A=
# CONFIG_DRM_LONTIUM_LT9611 is not set=0A=
# CONFIG_DRM_LONTIUM_LT9611UXC is not set=0A=
# CONFIG_DRM_ITE_IT66121 is not set=0A=
# CONFIG_DRM_LVDS_CODEC is not set=0A=
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set=0A=
# CONFIG_DRM_NWL_MIPI_DSI is not set=0A=
# CONFIG_DRM_NXP_PTN3460 is not set=0A=
# CONFIG_DRM_PARADE_PS8622 is not set=0A=
# CONFIG_DRM_PARADE_PS8640 is not set=0A=
# CONFIG_DRM_SAMSUNG_DSIM is not set=0A=
# CONFIG_DRM_SIL_SII8620 is not set=0A=
# CONFIG_DRM_SII902X is not set=0A=
# CONFIG_DRM_SII9234 is not set=0A=
# CONFIG_DRM_SIMPLE_BRIDGE is not set=0A=
# CONFIG_DRM_THINE_THC63LVD1024 is not set=0A=
# CONFIG_DRM_TOSHIBA_TC358762 is not set=0A=
# CONFIG_DRM_TOSHIBA_TC358764 is not set=0A=
# CONFIG_DRM_TOSHIBA_TC358767 is not set=0A=
# CONFIG_DRM_TOSHIBA_TC358768 is not set=0A=
# CONFIG_DRM_TOSHIBA_TC358775 is not set=0A=
# CONFIG_DRM_TI_DLPC3433 is not set=0A=
# CONFIG_DRM_TI_TDP158 is not set=0A=
# CONFIG_DRM_TI_TFP410 is not set=0A=
# CONFIG_DRM_TI_SN65DSI83 is not set=0A=
# CONFIG_DRM_TI_SN65DSI86 is not set=0A=
# CONFIG_DRM_TI_TPD12S015 is not set=0A=
# CONFIG_DRM_ANALOGIX_ANX6345 is not set=0A=
# CONFIG_DRM_ANALOGIX_ANX78XX is not set=0A=
# CONFIG_DRM_ANALOGIX_ANX7625 is not set=0A=
# CONFIG_DRM_I2C_ADV7511 is not set=0A=
# CONFIG_DRM_CDNS_DSI is not set=0A=
# CONFIG_DRM_CDNS_MHDP8546 is not set=0A=
# end of Display Interface Bridges=0A=
=0A=
# CONFIG_DRM_ETNAVIV is not set=0A=
# CONFIG_DRM_LOGICVC is not set=0A=
# CONFIG_DRM_ARCPGU is not set=0A=
CONFIG_DRM_BOCHS=3Dy=0A=
CONFIG_DRM_CIRRUS_QEMU=3Dy=0A=
CONFIG_DRM_GM12U320=3Dy=0A=
# CONFIG_DRM_PANEL_MIPI_DBI is not set=0A=
CONFIG_DRM_SIMPLEDRM=3Dy=0A=
# CONFIG_TINYDRM_HX8357D is not set=0A=
# CONFIG_TINYDRM_ILI9163 is not set=0A=
# CONFIG_TINYDRM_ILI9225 is not set=0A=
# CONFIG_TINYDRM_ILI9341 is not set=0A=
# CONFIG_TINYDRM_ILI9486 is not set=0A=
# CONFIG_TINYDRM_MI0283QT is not set=0A=
# CONFIG_TINYDRM_REPAPER is not set=0A=
# CONFIG_TINYDRM_SHARP_MEMORY is not set=0A=
# CONFIG_TINYDRM_ST7586 is not set=0A=
# CONFIG_TINYDRM_ST7735R is not set=0A=
# CONFIG_DRM_VBOXVIDEO is not set=0A=
CONFIG_DRM_GUD=3Dy=0A=
# CONFIG_DRM_SSD130X is not set=0A=
# CONFIG_DRM_WERROR is not set=0A=
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy=0A=
=0A=
#=0A=
# Frame buffer Devices=0A=
#=0A=
CONFIG_FB=3Dy=0A=
# CONFIG_FB_CIRRUS is not set=0A=
# CONFIG_FB_PM2 is not set=0A=
# CONFIG_FB_CYBER2000 is not set=0A=
# CONFIG_FB_ARC is not set=0A=
# CONFIG_FB_ASILIANT is not set=0A=
# CONFIG_FB_IMSTT is not set=0A=
CONFIG_FB_VGA16=3Dy=0A=
# CONFIG_FB_UVESA is not set=0A=
CONFIG_FB_VESA=3Dy=0A=
# CONFIG_FB_N411 is not set=0A=
# CONFIG_FB_HGA is not set=0A=
# CONFIG_FB_OPENCORES is not set=0A=
# CONFIG_FB_S1D13XXX is not set=0A=
# CONFIG_FB_NVIDIA is not set=0A=
# CONFIG_FB_RIVA is not set=0A=
# CONFIG_FB_I740 is not set=0A=
# CONFIG_FB_MATROX is not set=0A=
# CONFIG_FB_RADEON is not set=0A=
# CONFIG_FB_ATY128 is not set=0A=
# CONFIG_FB_ATY is not set=0A=
# CONFIG_FB_S3 is not set=0A=
# CONFIG_FB_SAVAGE is not set=0A=
# CONFIG_FB_SIS is not set=0A=
# CONFIG_FB_VIA is not set=0A=
# CONFIG_FB_NEOMAGIC is not set=0A=
# CONFIG_FB_KYRO is not set=0A=
# CONFIG_FB_3DFX is not set=0A=
# CONFIG_FB_VOODOO1 is not set=0A=
# CONFIG_FB_VT8623 is not set=0A=
# CONFIG_FB_TRIDENT is not set=0A=
# CONFIG_FB_ARK is not set=0A=
# CONFIG_FB_PM3 is not set=0A=
# CONFIG_FB_CARMINE is not set=0A=
# CONFIG_FB_SMSCUFX is not set=0A=
# CONFIG_FB_UDL is not set=0A=
# CONFIG_FB_IBM_GXT4500 is not set=0A=
CONFIG_FB_VIRTUAL=3Dy=0A=
# CONFIG_FB_METRONOME is not set=0A=
# CONFIG_FB_MB862XX is not set=0A=
# CONFIG_FB_SSD1307 is not set=0A=
# CONFIG_FB_SM712 is not set=0A=
CONFIG_FB_CORE=3Dy=0A=
CONFIG_FB_NOTIFY=3Dy=0A=
# CONFIG_FIRMWARE_EDID is not set=0A=
CONFIG_FB_DEVICE=3Dy=0A=
CONFIG_FB_CFB_FILLRECT=3Dy=0A=
CONFIG_FB_CFB_COPYAREA=3Dy=0A=
CONFIG_FB_CFB_IMAGEBLIT=3Dy=0A=
CONFIG_FB_SYS_FILLRECT=3Dy=0A=
CONFIG_FB_SYS_COPYAREA=3Dy=0A=
CONFIG_FB_SYS_IMAGEBLIT=3Dy=0A=
# CONFIG_FB_FOREIGN_ENDIAN is not set=0A=
CONFIG_FB_SYSMEM_FOPS=3Dy=0A=
CONFIG_FB_DEFERRED_IO=3Dy=0A=
CONFIG_FB_IOMEM_FOPS=3Dy=0A=
CONFIG_FB_IOMEM_HELPERS=3Dy=0A=
CONFIG_FB_SYSMEM_HELPERS=3Dy=0A=
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=3Dy=0A=
# CONFIG_FB_MODE_HELPERS is not set=0A=
CONFIG_FB_TILEBLITTING=3Dy=0A=
# end of Frame buffer Devices=0A=
=0A=
#=0A=
# Backlight & LCD device support=0A=
#=0A=
CONFIG_LCD_CLASS_DEVICE=3Dy=0A=
# CONFIG_LCD_L4F00242T03 is not set=0A=
# CONFIG_LCD_LMS283GF05 is not set=0A=
# CONFIG_LCD_LTV350QV is not set=0A=
# CONFIG_LCD_ILI922X is not set=0A=
# CONFIG_LCD_ILI9320 is not set=0A=
# CONFIG_LCD_TDO24M is not set=0A=
# CONFIG_LCD_VGG2432A4 is not set=0A=
# CONFIG_LCD_PLATFORM is not set=0A=
# CONFIG_LCD_AMS369FG06 is not set=0A=
# CONFIG_LCD_LMS501KF03 is not set=0A=
# CONFIG_LCD_HX8357 is not set=0A=
# CONFIG_LCD_OTM3225A is not set=0A=
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy=0A=
# CONFIG_BACKLIGHT_KTD253 is not set=0A=
# CONFIG_BACKLIGHT_KTD2801 is not set=0A=
# CONFIG_BACKLIGHT_KTZ8866 is not set=0A=
# CONFIG_BACKLIGHT_MT6370 is not set=0A=
# CONFIG_BACKLIGHT_APPLE is not set=0A=
# CONFIG_BACKLIGHT_QCOM_WLED is not set=0A=
# CONFIG_BACKLIGHT_SAHARA is not set=0A=
# CONFIG_BACKLIGHT_ADP8860 is not set=0A=
# CONFIG_BACKLIGHT_ADP8870 is not set=0A=
# CONFIG_BACKLIGHT_LM3509 is not set=0A=
# CONFIG_BACKLIGHT_LM3639 is not set=0A=
# CONFIG_BACKLIGHT_PANDORA is not set=0A=
# CONFIG_BACKLIGHT_GPIO is not set=0A=
# CONFIG_BACKLIGHT_LV5207LP is not set=0A=
# CONFIG_BACKLIGHT_BD6107 is not set=0A=
# CONFIG_BACKLIGHT_ARCXCNN is not set=0A=
# CONFIG_BACKLIGHT_LED is not set=0A=
# end of Backlight & LCD device support=0A=
=0A=
CONFIG_VGASTATE=3Dy=0A=
CONFIG_VIDEOMODE_HELPERS=3Dy=0A=
CONFIG_HDMI=3Dy=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
CONFIG_DUMMY_CONSOLE_COLUMNS=3D80=0A=
CONFIG_DUMMY_CONSOLE_ROWS=3D25=0A=
CONFIG_FRAMEBUFFER_CONSOLE=3Dy=0A=
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set=0A=
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy=0A=
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy=0A=
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set=0A=
# end of Console display driver support=0A=
=0A=
CONFIG_LOGO=3Dy=0A=
CONFIG_LOGO_LINUX_MONO=3Dy=0A=
CONFIG_LOGO_LINUX_VGA16=3Dy=0A=
# CONFIG_LOGO_LINUX_CLUT224 is not set=0A=
# end of Graphics support=0A=
=0A=
# CONFIG_DRM_ACCEL is not set=0A=
CONFIG_SOUND=3Dy=0A=
CONFIG_SOUND_OSS_CORE=3Dy=0A=
CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy=0A=
CONFIG_SND=3Dy=0A=
CONFIG_SND_TIMER=3Dy=0A=
CONFIG_SND_PCM=3Dy=0A=
CONFIG_SND_HWDEP=3Dy=0A=
CONFIG_SND_SEQ_DEVICE=3Dy=0A=
CONFIG_SND_RAWMIDI=3Dy=0A=
CONFIG_SND_UMP=3Dy=0A=
CONFIG_SND_UMP_LEGACY_RAWMIDI=3Dy=0A=
CONFIG_SND_JACK=3Dy=0A=
CONFIG_SND_JACK_INPUT_DEV=3Dy=0A=
CONFIG_SND_OSSEMUL=3Dy=0A=
CONFIG_SND_MIXER_OSS=3Dy=0A=
CONFIG_SND_PCM_OSS=3Dy=0A=
CONFIG_SND_PCM_OSS_PLUGINS=3Dy=0A=
CONFIG_SND_PCM_TIMER=3Dy=0A=
CONFIG_SND_HRTIMER=3Dy=0A=
CONFIG_SND_DYNAMIC_MINORS=3Dy=0A=
CONFIG_SND_MAX_CARDS=3D32=0A=
CONFIG_SND_SUPPORT_OLD_API=3Dy=0A=
CONFIG_SND_PROC_FS=3Dy=0A=
CONFIG_SND_VERBOSE_PROCFS=3Dy=0A=
CONFIG_SND_CTL_FAST_LOOKUP=3Dy=0A=
CONFIG_SND_DEBUG=3Dy=0A=
# CONFIG_SND_DEBUG_VERBOSE is not set=0A=
CONFIG_SND_PCM_XRUN_DEBUG=3Dy=0A=
# CONFIG_SND_CTL_INPUT_VALIDATION is not set=0A=
# CONFIG_SND_CTL_DEBUG is not set=0A=
# CONFIG_SND_JACK_INJECTION_DEBUG is not set=0A=
# CONFIG_SND_UTIMER is not set=0A=
CONFIG_SND_VMASTER=3Dy=0A=
CONFIG_SND_DMA_SGBUF=3Dy=0A=
CONFIG_SND_CTL_LED=3Dy=0A=
CONFIG_SND_SEQUENCER=3Dy=0A=
CONFIG_SND_SEQ_DUMMY=3Dy=0A=
CONFIG_SND_SEQUENCER_OSS=3Dy=0A=
CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy=0A=
CONFIG_SND_SEQ_MIDI_EVENT=3Dy=0A=
CONFIG_SND_SEQ_MIDI=3Dy=0A=
CONFIG_SND_SEQ_VIRMIDI=3Dy=0A=
# CONFIG_SND_SEQ_UMP is not set=0A=
CONFIG_SND_SEQ_UMP_CLIENT=3Dy=0A=
CONFIG_SND_DRIVERS=3Dy=0A=
# CONFIG_SND_PCSP is not set=0A=
CONFIG_SND_DUMMY=3Dy=0A=
CONFIG_SND_ALOOP=3Dy=0A=
# CONFIG_SND_PCMTEST is not set=0A=
CONFIG_SND_VIRMIDI=3Dy=0A=
# CONFIG_SND_MTPAV is not set=0A=
# CONFIG_SND_MTS64 is not set=0A=
# CONFIG_SND_SERIAL_U16550 is not set=0A=
# CONFIG_SND_SERIAL_GENERIC is not set=0A=
# CONFIG_SND_MPU401 is not set=0A=
# CONFIG_SND_PORTMAN2X4 is not set=0A=
CONFIG_SND_PCI=3Dy=0A=
# CONFIG_SND_AD1889 is not set=0A=
# CONFIG_SND_ALS300 is not set=0A=
# CONFIG_SND_ALS4000 is not set=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_ASIHPI is not set=0A=
# CONFIG_SND_ATIIXP is not set=0A=
# CONFIG_SND_ATIIXP_MODEM is not set=0A=
# CONFIG_SND_AU8810 is not set=0A=
# CONFIG_SND_AU8820 is not set=0A=
# CONFIG_SND_AU8830 is not set=0A=
# CONFIG_SND_AW2 is not set=0A=
# CONFIG_SND_AZT3328 is not set=0A=
# CONFIG_SND_BT87X is not set=0A=
# CONFIG_SND_CA0106 is not set=0A=
# CONFIG_SND_CMIPCI is not set=0A=
# CONFIG_SND_OXYGEN is not set=0A=
# CONFIG_SND_CS4281 is not set=0A=
# CONFIG_SND_CS46XX is not set=0A=
# CONFIG_SND_CTXFI is not set=0A=
# CONFIG_SND_DARLA20 is not set=0A=
# CONFIG_SND_GINA20 is not set=0A=
# CONFIG_SND_LAYLA20 is not set=0A=
# CONFIG_SND_DARLA24 is not set=0A=
# CONFIG_SND_GINA24 is not set=0A=
# CONFIG_SND_LAYLA24 is not set=0A=
# CONFIG_SND_MONA is not set=0A=
# CONFIG_SND_MIA is not set=0A=
# CONFIG_SND_ECHO3G is not set=0A=
# CONFIG_SND_INDIGO is not set=0A=
# CONFIG_SND_INDIGOIO is not set=0A=
# CONFIG_SND_INDIGODJ is not set=0A=
# CONFIG_SND_INDIGOIOX is not set=0A=
# CONFIG_SND_INDIGODJX is not set=0A=
# CONFIG_SND_EMU10K1 is not set=0A=
# CONFIG_SND_EMU10K1X is not set=0A=
# CONFIG_SND_ENS1370 is not set=0A=
# CONFIG_SND_ENS1371 is not set=0A=
# CONFIG_SND_ES1938 is not set=0A=
# CONFIG_SND_ES1968 is not set=0A=
# CONFIG_SND_FM801 is not set=0A=
# CONFIG_SND_HDSP is not set=0A=
# CONFIG_SND_HDSPM is not set=0A=
# CONFIG_SND_ICE1712 is not set=0A=
# CONFIG_SND_ICE1724 is not set=0A=
# CONFIG_SND_INTEL8X0 is not set=0A=
# CONFIG_SND_INTEL8X0M is not set=0A=
# CONFIG_SND_KORG1212 is not set=0A=
# CONFIG_SND_LOLA is not set=0A=
# CONFIG_SND_LX6464ES is not set=0A=
# CONFIG_SND_MAESTRO3 is not set=0A=
# CONFIG_SND_MIXART is not set=0A=
# CONFIG_SND_NM256 is not set=0A=
# CONFIG_SND_PCXHR is not set=0A=
# CONFIG_SND_RIPTIDE is not set=0A=
# CONFIG_SND_RME32 is not set=0A=
# CONFIG_SND_RME96 is not set=0A=
# CONFIG_SND_RME9652 is not set=0A=
# CONFIG_SND_SE6X is not set=0A=
# CONFIG_SND_SONICVIBES is not set=0A=
# CONFIG_SND_TRIDENT is not set=0A=
# CONFIG_SND_VIA82XX is not set=0A=
# CONFIG_SND_VIA82XX_MODEM is not set=0A=
# CONFIG_SND_VIRTUOSO is not set=0A=
# CONFIG_SND_VX222 is not set=0A=
# CONFIG_SND_YMFPCI is not set=0A=
=0A=
#=0A=
# HD-Audio=0A=
#=0A=
CONFIG_SND_HDA=3Dy=0A=
CONFIG_SND_HDA_GENERIC_LEDS=3Dy=0A=
CONFIG_SND_HDA_INTEL=3Dy=0A=
CONFIG_SND_HDA_HWDEP=3Dy=0A=
CONFIG_SND_HDA_RECONFIG=3Dy=0A=
CONFIG_SND_HDA_INPUT_BEEP=3Dy=0A=
CONFIG_SND_HDA_INPUT_BEEP_MODE=3D1=0A=
CONFIG_SND_HDA_PATCH_LOADER=3Dy=0A=
CONFIG_SND_HDA_SCODEC_COMPONENT=3Dy=0A=
# CONFIG_SND_HDA_SCODEC_CS35L56_I2C is not set=0A=
# CONFIG_SND_HDA_SCODEC_CS35L56_SPI is not set=0A=
CONFIG_SND_HDA_CODEC_REALTEK=3Dy=0A=
CONFIG_SND_HDA_CODEC_ANALOG=3Dy=0A=
CONFIG_SND_HDA_CODEC_SIGMATEL=3Dy=0A=
CONFIG_SND_HDA_CODEC_VIA=3Dy=0A=
CONFIG_SND_HDA_CODEC_HDMI=3Dy=0A=
CONFIG_SND_HDA_CODEC_CIRRUS=3Dy=0A=
# CONFIG_SND_HDA_CODEC_CS8409 is not set=0A=
CONFIG_SND_HDA_CODEC_CONEXANT=3Dy=0A=
# CONFIG_SND_HDA_CODEC_SENARYTECH is not set=0A=
CONFIG_SND_HDA_CODEC_CA0110=3Dy=0A=
CONFIG_SND_HDA_CODEC_CA0132=3Dy=0A=
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set=0A=
CONFIG_SND_HDA_CODEC_CMEDIA=3Dy=0A=
CONFIG_SND_HDA_CODEC_SI3054=3Dy=0A=
CONFIG_SND_HDA_GENERIC=3Dy=0A=
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0=0A=
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set=0A=
# CONFIG_SND_HDA_CTL_DEV_ID is not set=0A=
# end of HD-Audio=0A=
=0A=
CONFIG_SND_HDA_CORE=3Dy=0A=
CONFIG_SND_HDA_COMPONENT=3Dy=0A=
CONFIG_SND_HDA_I915=3Dy=0A=
CONFIG_SND_HDA_PREALLOC_SIZE=3D0=0A=
CONFIG_SND_INTEL_NHLT=3Dy=0A=
CONFIG_SND_INTEL_DSP_CONFIG=3Dy=0A=
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=3Dy=0A=
# CONFIG_SND_SPI is not set=0A=
CONFIG_SND_USB=3Dy=0A=
CONFIG_SND_USB_AUDIO=3Dy=0A=
CONFIG_SND_USB_AUDIO_MIDI_V2=3Dy=0A=
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=3Dy=0A=
CONFIG_SND_USB_UA101=3Dy=0A=
CONFIG_SND_USB_USX2Y=3Dy=0A=
CONFIG_SND_USB_CAIAQ=3Dy=0A=
CONFIG_SND_USB_CAIAQ_INPUT=3Dy=0A=
CONFIG_SND_USB_US122L=3Dy=0A=
CONFIG_SND_USB_6FIRE=3Dy=0A=
CONFIG_SND_USB_HIFACE=3Dy=0A=
CONFIG_SND_BCD2000=3Dy=0A=
CONFIG_SND_USB_LINE6=3Dy=0A=
CONFIG_SND_USB_POD=3Dy=0A=
CONFIG_SND_USB_PODHD=3Dy=0A=
CONFIG_SND_USB_TONEPORT=3Dy=0A=
CONFIG_SND_USB_VARIAX=3Dy=0A=
# CONFIG_SND_FIREWIRE is not set=0A=
CONFIG_SND_PCMCIA=3Dy=0A=
# CONFIG_SND_VXPOCKET is not set=0A=
# CONFIG_SND_PDAUDIOCF is not set=0A=
CONFIG_SND_SOC=3Dy=0A=
# CONFIG_SND_SOC_ADI is not set=0A=
# CONFIG_SND_SOC_AMD_ACP is not set=0A=
# CONFIG_SND_SOC_AMD_ACP3x is not set=0A=
# CONFIG_SND_SOC_AMD_RENOIR is not set=0A=
# CONFIG_SND_SOC_AMD_ACP5x is not set=0A=
# CONFIG_SND_SOC_AMD_ACP6x is not set=0A=
# CONFIG_SND_AMD_ACP_CONFIG is not set=0A=
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set=0A=
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set=0A=
# CONFIG_SND_ATMEL_SOC is not set=0A=
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set=0A=
# CONFIG_SND_DESIGNWARE_I2S is not set=0A=
=0A=
#=0A=
# SoC Audio for Freescale CPUs=0A=
#=0A=
=0A=
#=0A=
# Common SoC Audio options for Freescale CPUs:=0A=
#=0A=
# CONFIG_SND_SOC_FSL_ASRC is not set=0A=
# CONFIG_SND_SOC_FSL_SAI is not set=0A=
# CONFIG_SND_SOC_FSL_AUDMIX is not set=0A=
# CONFIG_SND_SOC_FSL_SSI is not set=0A=
# CONFIG_SND_SOC_FSL_SPDIF is not set=0A=
# CONFIG_SND_SOC_FSL_ESAI is not set=0A=
# CONFIG_SND_SOC_FSL_MICFIL is not set=0A=
# CONFIG_SND_SOC_FSL_XCVR is not set=0A=
# CONFIG_SND_SOC_IMX_AUDMUX is not set=0A=
# end of SoC Audio for Freescale CPUs=0A=
=0A=
# CONFIG_SND_SOC_CHV3_I2S is not set=0A=
# CONFIG_SND_I2S_HI6210_I2S is not set=0A=
=0A=
#=0A=
# SoC Audio for Loongson CPUs=0A=
#=0A=
# end of SoC Audio for Loongson CPUs=0A=
=0A=
# CONFIG_SND_SOC_IMG is not set=0A=
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set=0A=
# CONFIG_SND_SOC_INTEL_AVS is not set=0A=
# CONFIG_SND_SOC_MTK_BTCVSD is not set=0A=
CONFIG_SND_SOC_SDCA_OPTIONAL=3Dy=0A=
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set=0A=
=0A=
#=0A=
# STMicroelectronics STM32 SOC audio support=0A=
#=0A=
# end of STMicroelectronics STM32 SOC audio support=0A=
=0A=
# CONFIG_SND_SOC_XILINX_I2S is not set=0A=
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set=0A=
# CONFIG_SND_SOC_XILINX_SPDIF is not set=0A=
# CONFIG_SND_SOC_XTFPGA_I2S is not set=0A=
CONFIG_SND_SOC_I2C_AND_SPI=3Dy=0A=
=0A=
#=0A=
# CODEC drivers=0A=
#=0A=
# CONFIG_SND_SOC_AC97_CODEC is not set=0A=
# CONFIG_SND_SOC_ADAU1372_I2C is not set=0A=
# CONFIG_SND_SOC_ADAU1372_SPI is not set=0A=
# CONFIG_SND_SOC_ADAU1373 is not set=0A=
# CONFIG_SND_SOC_ADAU1701 is not set=0A=
# CONFIG_SND_SOC_ADAU1761_I2C is not set=0A=
# CONFIG_SND_SOC_ADAU1761_SPI is not set=0A=
# CONFIG_SND_SOC_ADAU7002 is not set=0A=
# CONFIG_SND_SOC_ADAU7118_HW is not set=0A=
# CONFIG_SND_SOC_ADAU7118_I2C is not set=0A=
# CONFIG_SND_SOC_AK4104 is not set=0A=
# CONFIG_SND_SOC_AK4118 is not set=0A=
# CONFIG_SND_SOC_AK4375 is not set=0A=
# CONFIG_SND_SOC_AK4458 is not set=0A=
# CONFIG_SND_SOC_AK4554 is not set=0A=
# CONFIG_SND_SOC_AK4613 is not set=0A=
# CONFIG_SND_SOC_AK4619 is not set=0A=
# CONFIG_SND_SOC_AK4642 is not set=0A=
# CONFIG_SND_SOC_AK5386 is not set=0A=
# CONFIG_SND_SOC_AK5558 is not set=0A=
# CONFIG_SND_SOC_ALC5623 is not set=0A=
# CONFIG_SND_SOC_AUDIO_IIO_AUX is not set=0A=
# CONFIG_SND_SOC_AW8738 is not set=0A=
# CONFIG_SND_SOC_AW88395 is not set=0A=
# CONFIG_SND_SOC_AW88261 is not set=0A=
# CONFIG_SND_SOC_AW88081 is not set=0A=
# CONFIG_SND_SOC_AW87390 is not set=0A=
# CONFIG_SND_SOC_AW88399 is not set=0A=
# CONFIG_SND_SOC_BD28623 is not set=0A=
# CONFIG_SND_SOC_BT_SCO is not set=0A=
# CONFIG_SND_SOC_CHV3_CODEC is not set=0A=
# CONFIG_SND_SOC_CS35L32 is not set=0A=
# CONFIG_SND_SOC_CS35L33 is not set=0A=
# CONFIG_SND_SOC_CS35L34 is not set=0A=
# CONFIG_SND_SOC_CS35L35 is not set=0A=
# CONFIG_SND_SOC_CS35L36 is not set=0A=
# CONFIG_SND_SOC_CS35L41_SPI is not set=0A=
# CONFIG_SND_SOC_CS35L41_I2C is not set=0A=
# CONFIG_SND_SOC_CS35L45_SPI is not set=0A=
# CONFIG_SND_SOC_CS35L45_I2C is not set=0A=
# CONFIG_SND_SOC_CS35L56_I2C is not set=0A=
# CONFIG_SND_SOC_CS35L56_SPI is not set=0A=
# CONFIG_SND_SOC_CS35L56_SDW is not set=0A=
# CONFIG_SND_SOC_CS42L42 is not set=0A=
# CONFIG_SND_SOC_CS42L42_SDW is not set=0A=
# CONFIG_SND_SOC_CS42L51_I2C is not set=0A=
# CONFIG_SND_SOC_CS42L52 is not set=0A=
# CONFIG_SND_SOC_CS42L56 is not set=0A=
# CONFIG_SND_SOC_CS42L73 is not set=0A=
# CONFIG_SND_SOC_CS42L83 is not set=0A=
# CONFIG_SND_SOC_CS42L84 is not set=0A=
# CONFIG_SND_SOC_CS4234 is not set=0A=
# CONFIG_SND_SOC_CS4265 is not set=0A=
# CONFIG_SND_SOC_CS4270 is not set=0A=
# CONFIG_SND_SOC_CS4271_I2C is not set=0A=
# CONFIG_SND_SOC_CS4271_SPI is not set=0A=
# CONFIG_SND_SOC_CS42XX8_I2C is not set=0A=
# CONFIG_SND_SOC_CS43130 is not set=0A=
# CONFIG_SND_SOC_CS4341 is not set=0A=
# CONFIG_SND_SOC_CS4349 is not set=0A=
# CONFIG_SND_SOC_CS53L30 is not set=0A=
# CONFIG_SND_SOC_CS530X_I2C is not set=0A=
# CONFIG_SND_SOC_CX2072X is not set=0A=
# CONFIG_SND_SOC_DA7213 is not set=0A=
# CONFIG_SND_SOC_DMIC is not set=0A=
# CONFIG_SND_SOC_ES7134 is not set=0A=
# CONFIG_SND_SOC_ES7241 is not set=0A=
# CONFIG_SND_SOC_ES8311 is not set=0A=
# CONFIG_SND_SOC_ES8316 is not set=0A=
# CONFIG_SND_SOC_ES8323 is not set=0A=
# CONFIG_SND_SOC_ES8326 is not set=0A=
# CONFIG_SND_SOC_ES8328_I2C is not set=0A=
# CONFIG_SND_SOC_ES8328_SPI is not set=0A=
# CONFIG_SND_SOC_GTM601 is not set=0A=
# CONFIG_SND_SOC_HDA is not set=0A=
# CONFIG_SND_SOC_ICS43432 is not set=0A=
# CONFIG_SND_SOC_IDT821034 is not set=0A=
# CONFIG_SND_SOC_MAX98088 is not set=0A=
# CONFIG_SND_SOC_MAX98090 is not set=0A=
# CONFIG_SND_SOC_MAX98357A is not set=0A=
# CONFIG_SND_SOC_MAX98504 is not set=0A=
# CONFIG_SND_SOC_MAX9867 is not set=0A=
# CONFIG_SND_SOC_MAX98927 is not set=0A=
# CONFIG_SND_SOC_MAX98520 is not set=0A=
# CONFIG_SND_SOC_MAX98363 is not set=0A=
# CONFIG_SND_SOC_MAX98373_I2C is not set=0A=
# CONFIG_SND_SOC_MAX98373_SDW is not set=0A=
# CONFIG_SND_SOC_MAX98388 is not set=0A=
# CONFIG_SND_SOC_MAX98390 is not set=0A=
# CONFIG_SND_SOC_MAX98396 is not set=0A=
# CONFIG_SND_SOC_MAX9860 is not set=0A=
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set=0A=
# CONFIG_SND_SOC_PCM1681 is not set=0A=
# CONFIG_SND_SOC_PCM1789_I2C is not set=0A=
# CONFIG_SND_SOC_PCM179X_I2C is not set=0A=
# CONFIG_SND_SOC_PCM179X_SPI is not set=0A=
# CONFIG_SND_SOC_PCM186X_I2C is not set=0A=
# CONFIG_SND_SOC_PCM186X_SPI is not set=0A=
# CONFIG_SND_SOC_PCM3060_I2C is not set=0A=
# CONFIG_SND_SOC_PCM3060_SPI is not set=0A=
# CONFIG_SND_SOC_PCM3168A_I2C is not set=0A=
# CONFIG_SND_SOC_PCM3168A_SPI is not set=0A=
# CONFIG_SND_SOC_PCM5102A is not set=0A=
# CONFIG_SND_SOC_PCM512x_I2C is not set=0A=
# CONFIG_SND_SOC_PCM512x_SPI is not set=0A=
# CONFIG_SND_SOC_PCM6240 is not set=0A=
# CONFIG_SND_SOC_PEB2466 is not set=0A=
# CONFIG_SND_SOC_RT1017_SDCA_SDW is not set=0A=
# CONFIG_SND_SOC_RT1308_SDW is not set=0A=
# CONFIG_SND_SOC_RT1316_SDW is not set=0A=
# CONFIG_SND_SOC_RT1318_SDW is not set=0A=
# CONFIG_SND_SOC_RT1320_SDW is not set=0A=
# CONFIG_SND_SOC_RT5616 is not set=0A=
# CONFIG_SND_SOC_RT5631 is not set=0A=
# CONFIG_SND_SOC_RT5640 is not set=0A=
# CONFIG_SND_SOC_RT5659 is not set=0A=
# CONFIG_SND_SOC_RT5682_SDW is not set=0A=
# CONFIG_SND_SOC_RT700_SDW is not set=0A=
# CONFIG_SND_SOC_RT711_SDW is not set=0A=
# CONFIG_SND_SOC_RT711_SDCA_SDW is not set=0A=
# CONFIG_SND_SOC_RT712_SDCA_SDW is not set=0A=
# CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW is not set=0A=
# CONFIG_SND_SOC_RT721_SDCA_SDW is not set=0A=
# CONFIG_SND_SOC_RT722_SDCA_SDW is not set=0A=
# CONFIG_SND_SOC_RT715_SDW is not set=0A=
# CONFIG_SND_SOC_RT715_SDCA_SDW is not set=0A=
# CONFIG_SND_SOC_RT9120 is not set=0A=
# CONFIG_SND_SOC_RTQ9128 is not set=0A=
# CONFIG_SND_SOC_SDW_MOCKUP is not set=0A=
# CONFIG_SND_SOC_SGTL5000 is not set=0A=
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set=0A=
# CONFIG_SND_SOC_SIMPLE_MUX is not set=0A=
# CONFIG_SND_SOC_SMA1303 is not set=0A=
# CONFIG_SND_SOC_SMA1307 is not set=0A=
# CONFIG_SND_SOC_SPDIF is not set=0A=
# CONFIG_SND_SOC_SRC4XXX_I2C is not set=0A=
# CONFIG_SND_SOC_SSM2305 is not set=0A=
# CONFIG_SND_SOC_SSM2518 is not set=0A=
# CONFIG_SND_SOC_SSM2602_SPI is not set=0A=
# CONFIG_SND_SOC_SSM2602_I2C is not set=0A=
# CONFIG_SND_SOC_SSM3515 is not set=0A=
# CONFIG_SND_SOC_SSM4567 is not set=0A=
# CONFIG_SND_SOC_STA32X is not set=0A=
# CONFIG_SND_SOC_STA350 is not set=0A=
# CONFIG_SND_SOC_STI_SAS is not set=0A=
# CONFIG_SND_SOC_TAS2552 is not set=0A=
# CONFIG_SND_SOC_TAS2562 is not set=0A=
# CONFIG_SND_SOC_TAS2764 is not set=0A=
# CONFIG_SND_SOC_TAS2770 is not set=0A=
# CONFIG_SND_SOC_TAS2780 is not set=0A=
# CONFIG_SND_SOC_TAS2781_I2C is not set=0A=
# CONFIG_SND_SOC_TAS5086 is not set=0A=
# CONFIG_SND_SOC_TAS571X is not set=0A=
# CONFIG_SND_SOC_TAS5720 is not set=0A=
# CONFIG_SND_SOC_TAS5805M is not set=0A=
# CONFIG_SND_SOC_TAS6424 is not set=0A=
# CONFIG_SND_SOC_TDA7419 is not set=0A=
# CONFIG_SND_SOC_TFA9879 is not set=0A=
# CONFIG_SND_SOC_TFA989X is not set=0A=
# CONFIG_SND_SOC_TLV320ADC3XXX is not set=0A=
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set=0A=
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set=0A=
# CONFIG_SND_SOC_TLV320AIC31XX is not set=0A=
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set=0A=
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set=0A=
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set=0A=
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set=0A=
# CONFIG_SND_SOC_TLV320ADCX140 is not set=0A=
# CONFIG_SND_SOC_TS3A227E is not set=0A=
# CONFIG_SND_SOC_TSCS42XX is not set=0A=
# CONFIG_SND_SOC_TSCS454 is not set=0A=
# CONFIG_SND_SOC_UDA1334 is not set=0A=
# CONFIG_SND_SOC_UDA1342 is not set=0A=
# CONFIG_SND_SOC_WCD937X_SDW is not set=0A=
# CONFIG_SND_SOC_WCD938X_SDW is not set=0A=
# CONFIG_SND_SOC_WCD939X_SDW is not set=0A=
# CONFIG_SND_SOC_WM8510 is not set=0A=
# CONFIG_SND_SOC_WM8523 is not set=0A=
# CONFIG_SND_SOC_WM8524 is not set=0A=
# CONFIG_SND_SOC_WM8580 is not set=0A=
# CONFIG_SND_SOC_WM8711 is not set=0A=
# CONFIG_SND_SOC_WM8728 is not set=0A=
# CONFIG_SND_SOC_WM8731_I2C is not set=0A=
# CONFIG_SND_SOC_WM8731_SPI is not set=0A=
# CONFIG_SND_SOC_WM8737 is not set=0A=
# CONFIG_SND_SOC_WM8741 is not set=0A=
# CONFIG_SND_SOC_WM8750 is not set=0A=
# CONFIG_SND_SOC_WM8753 is not set=0A=
# CONFIG_SND_SOC_WM8770 is not set=0A=
# CONFIG_SND_SOC_WM8776 is not set=0A=
# CONFIG_SND_SOC_WM8782 is not set=0A=
# CONFIG_SND_SOC_WM8804_I2C is not set=0A=
# CONFIG_SND_SOC_WM8804_SPI is not set=0A=
# CONFIG_SND_SOC_WM8903 is not set=0A=
# CONFIG_SND_SOC_WM8904 is not set=0A=
# CONFIG_SND_SOC_WM8940 is not set=0A=
# CONFIG_SND_SOC_WM8960 is not set=0A=
# CONFIG_SND_SOC_WM8961 is not set=0A=
# CONFIG_SND_SOC_WM8962 is not set=0A=
# CONFIG_SND_SOC_WM8974 is not set=0A=
# CONFIG_SND_SOC_WM8978 is not set=0A=
# CONFIG_SND_SOC_WM8985 is not set=0A=
# CONFIG_SND_SOC_WSA881X is not set=0A=
# CONFIG_SND_SOC_WSA883X is not set=0A=
# CONFIG_SND_SOC_WSA884X is not set=0A=
# CONFIG_SND_SOC_ZL38060 is not set=0A=
# CONFIG_SND_SOC_MAX9759 is not set=0A=
# CONFIG_SND_SOC_MT6351 is not set=0A=
# CONFIG_SND_SOC_MT6357 is not set=0A=
# CONFIG_SND_SOC_MT6358 is not set=0A=
# CONFIG_SND_SOC_MT6660 is not set=0A=
# CONFIG_SND_SOC_NAU8315 is not set=0A=
# CONFIG_SND_SOC_NAU8540 is not set=0A=
# CONFIG_SND_SOC_NAU8810 is not set=0A=
# CONFIG_SND_SOC_NAU8821 is not set=0A=
# CONFIG_SND_SOC_NAU8822 is not set=0A=
# CONFIG_SND_SOC_NAU8824 is not set=0A=
# CONFIG_SND_SOC_NTP8918 is not set=0A=
# CONFIG_SND_SOC_NTP8835 is not set=0A=
# CONFIG_SND_SOC_TPA6130A2 is not set=0A=
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set=0A=
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set=0A=
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set=0A=
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set=0A=
# end of CODEC drivers=0A=
=0A=
# CONFIG_SND_SIMPLE_CARD is not set=0A=
# CONFIG_SND_AUDIO_GRAPH_CARD is not set=0A=
# CONFIG_SND_AUDIO_GRAPH_CARD2 is not set=0A=
# CONFIG_SND_TEST_COMPONENT is not set=0A=
CONFIG_SND_X86=3Dy=0A=
# CONFIG_HDMI_LPE_AUDIO is not set=0A=
CONFIG_SND_VIRTIO=3Dy=0A=
CONFIG_HID_SUPPORT=3Dy=0A=
CONFIG_HID=3Dy=0A=
CONFIG_HID_BATTERY_STRENGTH=3Dy=0A=
CONFIG_HIDRAW=3Dy=0A=
CONFIG_UHID=3Dy=0A=
CONFIG_HID_GENERIC=3Dy=0A=
=0A=
#=0A=
# Special HID drivers=0A=
#=0A=
CONFIG_HID_A4TECH=3Dy=0A=
CONFIG_HID_ACCUTOUCH=3Dy=0A=
CONFIG_HID_ACRUX=3Dy=0A=
CONFIG_HID_ACRUX_FF=3Dy=0A=
CONFIG_HID_APPLE=3Dy=0A=
CONFIG_HID_APPLEIR=3Dy=0A=
CONFIG_HID_ASUS=3Dy=0A=
CONFIG_HID_AUREAL=3Dy=0A=
CONFIG_HID_BELKIN=3Dy=0A=
CONFIG_HID_BETOP_FF=3Dy=0A=
CONFIG_HID_BIGBEN_FF=3Dy=0A=
CONFIG_HID_CHERRY=3Dy=0A=
CONFIG_HID_CHICONY=3Dy=0A=
CONFIG_HID_CORSAIR=3Dy=0A=
CONFIG_HID_COUGAR=3Dy=0A=
CONFIG_HID_MACALLY=3Dy=0A=
CONFIG_HID_PRODIKEYS=3Dy=0A=
CONFIG_HID_CMEDIA=3Dy=0A=
CONFIG_HID_CP2112=3Dy=0A=
CONFIG_HID_CREATIVE_SB0540=3Dy=0A=
CONFIG_HID_CYPRESS=3Dy=0A=
CONFIG_HID_DRAGONRISE=3Dy=0A=
CONFIG_DRAGONRISE_FF=3Dy=0A=
CONFIG_HID_EMS_FF=3Dy=0A=
CONFIG_HID_ELAN=3Dy=0A=
CONFIG_HID_ELECOM=3Dy=0A=
CONFIG_HID_ELO=3Dy=0A=
CONFIG_HID_EVISION=3Dy=0A=
CONFIG_HID_EZKEY=3Dy=0A=
CONFIG_HID_FT260=3Dy=0A=
CONFIG_HID_GEMBIRD=3Dy=0A=
CONFIG_HID_GFRM=3Dy=0A=
CONFIG_HID_GLORIOUS=3Dy=0A=
CONFIG_HID_HOLTEK=3Dy=0A=
CONFIG_HOLTEK_FF=3Dy=0A=
CONFIG_HID_VIVALDI_COMMON=3Dy=0A=
# CONFIG_HID_GOODIX_SPI is not set=0A=
CONFIG_HID_GOOGLE_STADIA_FF=3Dy=0A=
CONFIG_HID_VIVALDI=3Dy=0A=
CONFIG_HID_GT683R=3Dy=0A=
CONFIG_HID_KEYTOUCH=3Dy=0A=
CONFIG_HID_KYE=3Dy=0A=
# CONFIG_HID_KYSONA is not set=0A=
CONFIG_HID_UCLOGIC=3Dy=0A=
CONFIG_HID_WALTOP=3Dy=0A=
CONFIG_HID_VIEWSONIC=3Dy=0A=
CONFIG_HID_VRC2=3Dy=0A=
CONFIG_HID_XIAOMI=3Dy=0A=
CONFIG_HID_GYRATION=3Dy=0A=
CONFIG_HID_ICADE=3Dy=0A=
CONFIG_HID_ITE=3Dy=0A=
CONFIG_HID_JABRA=3Dy=0A=
CONFIG_HID_TWINHAN=3Dy=0A=
CONFIG_HID_KENSINGTON=3Dy=0A=
CONFIG_HID_LCPOWER=3Dy=0A=
CONFIG_HID_LED=3Dy=0A=
CONFIG_HID_LENOVO=3Dy=0A=
CONFIG_HID_LETSKETCH=3Dy=0A=
CONFIG_HID_LOGITECH=3Dy=0A=
CONFIG_HID_LOGITECH_DJ=3Dy=0A=
CONFIG_HID_LOGITECH_HIDPP=3Dy=0A=
CONFIG_LOGITECH_FF=3Dy=0A=
CONFIG_LOGIRUMBLEPAD2_FF=3Dy=0A=
CONFIG_LOGIG940_FF=3Dy=0A=
CONFIG_LOGIWHEELS_FF=3Dy=0A=
CONFIG_HID_MAGICMOUSE=3Dy=0A=
CONFIG_HID_MALTRON=3Dy=0A=
CONFIG_HID_MAYFLASH=3Dy=0A=
CONFIG_HID_MEGAWORLD_FF=3Dy=0A=
CONFIG_HID_REDRAGON=3Dy=0A=
CONFIG_HID_MICROSOFT=3Dy=0A=
CONFIG_HID_MONTEREY=3Dy=0A=
CONFIG_HID_MULTITOUCH=3Dy=0A=
CONFIG_HID_NINTENDO=3Dy=0A=
CONFIG_NINTENDO_FF=3Dy=0A=
CONFIG_HID_NTI=3Dy=0A=
CONFIG_HID_NTRIG=3Dy=0A=
CONFIG_HID_NVIDIA_SHIELD=3Dy=0A=
CONFIG_NVIDIA_SHIELD_FF=3Dy=0A=
CONFIG_HID_ORTEK=3Dy=0A=
CONFIG_HID_PANTHERLORD=3Dy=0A=
CONFIG_PANTHERLORD_FF=3Dy=0A=
CONFIG_HID_PENMOUNT=3Dy=0A=
CONFIG_HID_PETALYNX=3Dy=0A=
CONFIG_HID_PICOLCD=3Dy=0A=
CONFIG_HID_PICOLCD_FB=3Dy=0A=
CONFIG_HID_PICOLCD_BACKLIGHT=3Dy=0A=
CONFIG_HID_PICOLCD_LCD=3Dy=0A=
CONFIG_HID_PICOLCD_LEDS=3Dy=0A=
CONFIG_HID_PICOLCD_CIR=3Dy=0A=
CONFIG_HID_PLANTRONICS=3Dy=0A=
CONFIG_HID_PLAYSTATION=3Dy=0A=
CONFIG_PLAYSTATION_FF=3Dy=0A=
CONFIG_HID_PXRC=3Dy=0A=
CONFIG_HID_RAZER=3Dy=0A=
CONFIG_HID_PRIMAX=3Dy=0A=
CONFIG_HID_RETRODE=3Dy=0A=
CONFIG_HID_ROCCAT=3Dy=0A=
CONFIG_HID_SAITEK=3Dy=0A=
CONFIG_HID_SAMSUNG=3Dy=0A=
CONFIG_HID_SEMITEK=3Dy=0A=
CONFIG_HID_SIGMAMICRO=3Dy=0A=
CONFIG_HID_SONY=3Dy=0A=
CONFIG_SONY_FF=3Dy=0A=
CONFIG_HID_SPEEDLINK=3Dy=0A=
CONFIG_HID_STEAM=3Dy=0A=
CONFIG_STEAM_FF=3Dy=0A=
CONFIG_HID_STEELSERIES=3Dy=0A=
CONFIG_HID_SUNPLUS=3Dy=0A=
CONFIG_HID_RMI=3Dy=0A=
CONFIG_HID_GREENASIA=3Dy=0A=
CONFIG_GREENASIA_FF=3Dy=0A=
CONFIG_HID_SMARTJOYPLUS=3Dy=0A=
CONFIG_SMARTJOYPLUS_FF=3Dy=0A=
CONFIG_HID_TIVO=3Dy=0A=
CONFIG_HID_TOPSEED=3Dy=0A=
CONFIG_HID_TOPRE=3Dy=0A=
CONFIG_HID_THINGM=3Dy=0A=
CONFIG_HID_THRUSTMASTER=3Dy=0A=
CONFIG_THRUSTMASTER_FF=3Dy=0A=
CONFIG_HID_UDRAW_PS3=3Dy=0A=
CONFIG_HID_U2FZERO=3Dy=0A=
CONFIG_HID_WACOM=3Dy=0A=
CONFIG_HID_WIIMOTE=3Dy=0A=
# CONFIG_HID_WINWING is not set=0A=
CONFIG_HID_XINMO=3Dy=0A=
CONFIG_HID_ZEROPLUS=3Dy=0A=
CONFIG_ZEROPLUS_FF=3Dy=0A=
CONFIG_HID_ZYDACRON=3Dy=0A=
CONFIG_HID_SENSOR_HUB=3Dy=0A=
CONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dy=0A=
CONFIG_HID_ALPS=3Dy=0A=
CONFIG_HID_MCP2200=3Dy=0A=
CONFIG_HID_MCP2221=3Dy=0A=
# end of Special HID drivers=0A=
=0A=
#=0A=
# HID-BPF support=0A=
#=0A=
# end of HID-BPF support=0A=
=0A=
#=0A=
# USB HID support=0A=
#=0A=
CONFIG_USB_HID=3Dy=0A=
CONFIG_HID_PID=3Dy=0A=
CONFIG_USB_HIDDEV=3Dy=0A=
# end of USB HID support=0A=
=0A=
CONFIG_I2C_HID=3Dy=0A=
CONFIG_I2C_HID_ACPI=3Dy=0A=
CONFIG_I2C_HID_OF=3Dy=0A=
# CONFIG_I2C_HID_OF_ELAN is not set=0A=
# CONFIG_I2C_HID_OF_GOODIX is not set=0A=
CONFIG_I2C_HID_CORE=3Dy=0A=
=0A=
#=0A=
# Intel ISH HID support=0A=
#=0A=
CONFIG_INTEL_ISH_HID=3Dy=0A=
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=3Dy=0A=
# end of Intel ISH HID support=0A=
=0A=
#=0A=
# AMD SFH HID Support=0A=
#=0A=
CONFIG_AMD_SFH_HID=3Dy=0A=
# end of AMD SFH HID Support=0A=
=0A=
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy=0A=
CONFIG_USB_SUPPORT=3Dy=0A=
CONFIG_USB_COMMON=3Dy=0A=
CONFIG_USB_LED_TRIG=3Dy=0A=
CONFIG_USB_ULPI_BUS=3Dy=0A=
CONFIG_USB_CONN_GPIO=3Dy=0A=
CONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
CONFIG_USB=3Dy=0A=
CONFIG_USB_PCI=3Dy=0A=
CONFIG_USB_PCI_AMD=3Dy=0A=
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEFAULT_PERSIST=3Dy=0A=
CONFIG_USB_FEW_INIT_RETRIES=3Dy=0A=
CONFIG_USB_DYNAMIC_MINORS=3Dy=0A=
CONFIG_USB_OTG=3Dy=0A=
# CONFIG_USB_OTG_PRODUCTLIST is not set=0A=
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set=0A=
CONFIG_USB_OTG_FSM=3Dy=0A=
CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dy=0A=
CONFIG_USB_AUTOSUSPEND_DELAY=3D2=0A=
CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=3D1=0A=
CONFIG_USB_MON=3Dy=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
CONFIG_USB_C67X00_HCD=3Dy=0A=
CONFIG_USB_XHCI_HCD=3Dy=0A=
CONFIG_USB_XHCI_DBGCAP=3Dy=0A=
CONFIG_USB_XHCI_PCI=3Dy=0A=
CONFIG_USB_XHCI_PCI_RENESAS=3Dy=0A=
CONFIG_USB_XHCI_PLATFORM=3Dy=0A=
CONFIG_USB_EHCI_HCD=3Dy=0A=
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy=0A=
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy=0A=
CONFIG_USB_EHCI_PCI=3Dy=0A=
CONFIG_USB_EHCI_FSL=3Dy=0A=
CONFIG_USB_EHCI_HCD_PLATFORM=3Dy=0A=
CONFIG_USB_OXU210HP_HCD=3Dy=0A=
CONFIG_USB_ISP116X_HCD=3Dy=0A=
CONFIG_USB_MAX3421_HCD=3Dy=0A=
CONFIG_USB_OHCI_HCD=3Dy=0A=
CONFIG_USB_OHCI_HCD_PCI=3Dy=0A=
# CONFIG_USB_OHCI_HCD_SSB is not set=0A=
CONFIG_USB_OHCI_HCD_PLATFORM=3Dy=0A=
CONFIG_USB_UHCI_HCD=3Dy=0A=
CONFIG_USB_SL811_HCD=3Dy=0A=
CONFIG_USB_SL811_HCD_ISO=3Dy=0A=
CONFIG_USB_SL811_CS=3Dy=0A=
CONFIG_USB_R8A66597_HCD=3Dy=0A=
CONFIG_USB_HCD_BCMA=3Dy=0A=
CONFIG_USB_HCD_SSB=3Dy=0A=
# CONFIG_USB_HCD_TEST_MODE is not set=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
CONFIG_USB_ACM=3Dy=0A=
CONFIG_USB_PRINTER=3Dy=0A=
CONFIG_USB_WDM=3Dy=0A=
CONFIG_USB_TMC=3Dy=0A=
=0A=
#=0A=
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may=0A=
#=0A=
=0A=
#=0A=
# also be needed; see USB_STORAGE Help for more info=0A=
#=0A=
CONFIG_USB_STORAGE=3Dy=0A=
# CONFIG_USB_STORAGE_DEBUG is not set=0A=
CONFIG_USB_STORAGE_REALTEK=3Dy=0A=
CONFIG_REALTEK_AUTOPM=3Dy=0A=
CONFIG_USB_STORAGE_DATAFAB=3Dy=0A=
CONFIG_USB_STORAGE_FREECOM=3Dy=0A=
CONFIG_USB_STORAGE_ISD200=3Dy=0A=
CONFIG_USB_STORAGE_USBAT=3Dy=0A=
CONFIG_USB_STORAGE_SDDR09=3Dy=0A=
CONFIG_USB_STORAGE_SDDR55=3Dy=0A=
CONFIG_USB_STORAGE_JUMPSHOT=3Dy=0A=
CONFIG_USB_STORAGE_ALAUDA=3Dy=0A=
CONFIG_USB_STORAGE_ONETOUCH=3Dy=0A=
CONFIG_USB_STORAGE_KARMA=3Dy=0A=
CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dy=0A=
CONFIG_USB_STORAGE_ENE_UB6250=3Dy=0A=
CONFIG_USB_UAS=3Dy=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
CONFIG_USB_MDC800=3Dy=0A=
CONFIG_USB_MICROTEK=3Dy=0A=
CONFIG_USBIP_CORE=3Dy=0A=
CONFIG_USBIP_VHCI_HCD=3Dy=0A=
CONFIG_USBIP_VHCI_HC_PORTS=3D8=0A=
CONFIG_USBIP_VHCI_NR_HCS=3D16=0A=
CONFIG_USBIP_HOST=3Dy=0A=
CONFIG_USBIP_VUDC=3Dy=0A=
# CONFIG_USBIP_DEBUG is not set=0A=
=0A=
#=0A=
# USB dual-mode controller drivers=0A=
#=0A=
CONFIG_USB_CDNS_SUPPORT=3Dy=0A=
CONFIG_USB_CDNS_HOST=3Dy=0A=
CONFIG_USB_CDNS3=3Dy=0A=
CONFIG_USB_CDNS3_GADGET=3Dy=0A=
CONFIG_USB_CDNS3_HOST=3Dy=0A=
CONFIG_USB_CDNS3_PCI_WRAP=3Dy=0A=
CONFIG_USB_CDNSP_PCI=3Dy=0A=
CONFIG_USB_CDNSP_GADGET=3Dy=0A=
CONFIG_USB_CDNSP_HOST=3Dy=0A=
CONFIG_USB_MUSB_HDRC=3Dy=0A=
# CONFIG_USB_MUSB_HOST is not set=0A=
# CONFIG_USB_MUSB_GADGET is not set=0A=
CONFIG_USB_MUSB_DUAL_ROLE=3Dy=0A=
=0A=
#=0A=
# Platform Glue Layer=0A=
#=0A=
=0A=
#=0A=
# MUSB DMA mode=0A=
#=0A=
CONFIG_MUSB_PIO_ONLY=3Dy=0A=
CONFIG_USB_DWC3=3Dy=0A=
CONFIG_USB_DWC3_ULPI=3Dy=0A=
# CONFIG_USB_DWC3_HOST is not set=0A=
CONFIG_USB_DWC3_GADGET=3Dy=0A=
# CONFIG_USB_DWC3_DUAL_ROLE is not set=0A=
=0A=
#=0A=
# Platform Glue Driver Support=0A=
#=0A=
CONFIG_USB_DWC3_PCI=3Dy=0A=
CONFIG_USB_DWC3_HAPS=3Dy=0A=
CONFIG_USB_DWC3_OF_SIMPLE=3Dy=0A=
CONFIG_USB_DWC2=3Dy=0A=
CONFIG_USB_DWC2_HOST=3Dy=0A=
=0A=
#=0A=
# Gadget/Dual-role mode requires USB Gadget support to be enabled=0A=
#=0A=
# CONFIG_USB_DWC2_PERIPHERAL is not set=0A=
# CONFIG_USB_DWC2_DUAL_ROLE is not set=0A=
CONFIG_USB_DWC2_PCI=3Dy=0A=
# CONFIG_USB_DWC2_DEBUG is not set=0A=
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set=0A=
CONFIG_USB_CHIPIDEA=3Dy=0A=
CONFIG_USB_CHIPIDEA_UDC=3Dy=0A=
CONFIG_USB_CHIPIDEA_HOST=3Dy=0A=
CONFIG_USB_CHIPIDEA_PCI=3Dy=0A=
CONFIG_USB_CHIPIDEA_MSM=3Dy=0A=
CONFIG_USB_CHIPIDEA_NPCM=3Dy=0A=
# CONFIG_USB_CHIPIDEA_IMX is not set=0A=
CONFIG_USB_CHIPIDEA_GENERIC=3Dy=0A=
# CONFIG_USB_CHIPIDEA_TEGRA is not set=0A=
CONFIG_USB_ISP1760=3Dy=0A=
CONFIG_USB_ISP1760_HCD=3Dy=0A=
CONFIG_USB_ISP1761_UDC=3Dy=0A=
# CONFIG_USB_ISP1760_HOST_ROLE is not set=0A=
# CONFIG_USB_ISP1760_GADGET_ROLE is not set=0A=
CONFIG_USB_ISP1760_DUAL_ROLE=3Dy=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
CONFIG_USB_SERIAL=3Dy=0A=
CONFIG_USB_SERIAL_CONSOLE=3Dy=0A=
CONFIG_USB_SERIAL_GENERIC=3Dy=0A=
CONFIG_USB_SERIAL_SIMPLE=3Dy=0A=
CONFIG_USB_SERIAL_AIRCABLE=3Dy=0A=
CONFIG_USB_SERIAL_ARK3116=3Dy=0A=
CONFIG_USB_SERIAL_BELKIN=3Dy=0A=
CONFIG_USB_SERIAL_CH341=3Dy=0A=
CONFIG_USB_SERIAL_WHITEHEAT=3Dy=0A=
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dy=0A=
CONFIG_USB_SERIAL_CP210X=3Dy=0A=
CONFIG_USB_SERIAL_CYPRESS_M8=3Dy=0A=
CONFIG_USB_SERIAL_EMPEG=3Dy=0A=
CONFIG_USB_SERIAL_FTDI_SIO=3Dy=0A=
CONFIG_USB_SERIAL_VISOR=3Dy=0A=
CONFIG_USB_SERIAL_IPAQ=3Dy=0A=
CONFIG_USB_SERIAL_IR=3Dy=0A=
CONFIG_USB_SERIAL_EDGEPORT=3Dy=0A=
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dy=0A=
CONFIG_USB_SERIAL_F81232=3Dy=0A=
CONFIG_USB_SERIAL_F8153X=3Dy=0A=
CONFIG_USB_SERIAL_GARMIN=3Dy=0A=
CONFIG_USB_SERIAL_IPW=3Dy=0A=
CONFIG_USB_SERIAL_IUU=3Dy=0A=
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dy=0A=
CONFIG_USB_SERIAL_KEYSPAN=3Dy=0A=
CONFIG_USB_SERIAL_KLSI=3Dy=0A=
CONFIG_USB_SERIAL_KOBIL_SCT=3Dy=0A=
CONFIG_USB_SERIAL_MCT_U232=3Dy=0A=
CONFIG_USB_SERIAL_METRO=3Dy=0A=
CONFIG_USB_SERIAL_MOS7720=3Dy=0A=
CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy=0A=
CONFIG_USB_SERIAL_MOS7840=3Dy=0A=
CONFIG_USB_SERIAL_MXUPORT=3Dy=0A=
CONFIG_USB_SERIAL_NAVMAN=3Dy=0A=
CONFIG_USB_SERIAL_PL2303=3Dy=0A=
CONFIG_USB_SERIAL_OTI6858=3Dy=0A=
CONFIG_USB_SERIAL_QCAUX=3Dy=0A=
CONFIG_USB_SERIAL_QUALCOMM=3Dy=0A=
CONFIG_USB_SERIAL_SPCP8X5=3Dy=0A=
CONFIG_USB_SERIAL_SAFE=3Dy=0A=
# CONFIG_USB_SERIAL_SAFE_PADDED is not set=0A=
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dy=0A=
CONFIG_USB_SERIAL_SYMBOL=3Dy=0A=
CONFIG_USB_SERIAL_TI=3Dy=0A=
CONFIG_USB_SERIAL_CYBERJACK=3Dy=0A=
CONFIG_USB_SERIAL_WWAN=3Dy=0A=
CONFIG_USB_SERIAL_OPTION=3Dy=0A=
CONFIG_USB_SERIAL_OMNINET=3Dy=0A=
CONFIG_USB_SERIAL_OPTICON=3Dy=0A=
CONFIG_USB_SERIAL_XSENS_MT=3Dy=0A=
CONFIG_USB_SERIAL_WISHBONE=3Dy=0A=
CONFIG_USB_SERIAL_SSU100=3Dy=0A=
CONFIG_USB_SERIAL_QT2=3Dy=0A=
CONFIG_USB_SERIAL_UPD78F0730=3Dy=0A=
CONFIG_USB_SERIAL_XR=3Dy=0A=
CONFIG_USB_SERIAL_DEBUG=3Dy=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
CONFIG_USB_USS720=3Dy=0A=
CONFIG_USB_EMI62=3Dy=0A=
CONFIG_USB_EMI26=3Dy=0A=
CONFIG_USB_ADUTUX=3Dy=0A=
CONFIG_USB_SEVSEG=3Dy=0A=
CONFIG_USB_LEGOTOWER=3Dy=0A=
CONFIG_USB_LCD=3Dy=0A=
CONFIG_USB_CYPRESS_CY7C63=3Dy=0A=
CONFIG_USB_CYTHERM=3Dy=0A=
CONFIG_USB_IDMOUSE=3Dy=0A=
CONFIG_USB_APPLEDISPLAY=3Dy=0A=
CONFIG_APPLE_MFI_FASTCHARGE=3Dy=0A=
CONFIG_USB_LJCA=3Dy=0A=
CONFIG_USB_SISUSBVGA=3Dy=0A=
CONFIG_USB_LD=3Dy=0A=
CONFIG_USB_TRANCEVIBRATOR=3Dy=0A=
CONFIG_USB_IOWARRIOR=3Dy=0A=
CONFIG_USB_TEST=3Dy=0A=
CONFIG_USB_EHSET_TEST_FIXTURE=3Dy=0A=
CONFIG_USB_ISIGHTFW=3Dy=0A=
CONFIG_USB_YUREX=3Dy=0A=
CONFIG_USB_EZUSB_FX2=3Dy=0A=
CONFIG_USB_HUB_USB251XB=3Dy=0A=
CONFIG_USB_HSIC_USB3503=3Dy=0A=
CONFIG_USB_HSIC_USB4604=3Dy=0A=
CONFIG_USB_LINK_LAYER_TEST=3Dy=0A=
CONFIG_USB_CHAOSKEY=3Dy=0A=
# CONFIG_USB_ONBOARD_DEV is not set=0A=
CONFIG_USB_ATM=3Dy=0A=
CONFIG_USB_SPEEDTOUCH=3Dy=0A=
CONFIG_USB_CXACRU=3Dy=0A=
CONFIG_USB_UEAGLEATM=3Dy=0A=
CONFIG_USB_XUSBATM=3Dy=0A=
=0A=
#=0A=
# USB Physical Layer drivers=0A=
#=0A=
CONFIG_USB_PHY=3Dy=0A=
CONFIG_NOP_USB_XCEIV=3Dy=0A=
CONFIG_TAHVO_USB=3Dy=0A=
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=3Dy=0A=
CONFIG_USB_ISP1301=3Dy=0A=
# end of USB Physical Layer drivers=0A=
=0A=
CONFIG_USB_GADGET=3Dy=0A=
# CONFIG_USB_GADGET_DEBUG is not set=0A=
CONFIG_USB_GADGET_DEBUG_FILES=3Dy=0A=
CONFIG_USB_GADGET_DEBUG_FS=3Dy=0A=
CONFIG_USB_GADGET_VBUS_DRAW=3D2=0A=
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=3D2=0A=
CONFIG_U_SERIAL_CONSOLE=3Dy=0A=
=0A=
#=0A=
# USB Peripheral Controller=0A=
#=0A=
CONFIG_USB_GR_UDC=3Dy=0A=
CONFIG_USB_R8A66597=3Dy=0A=
CONFIG_USB_PXA27X=3Dy=0A=
CONFIG_USB_MV_UDC=3Dy=0A=
CONFIG_USB_MV_U3D=3Dy=0A=
CONFIG_USB_SNP_CORE=3Dy=0A=
# CONFIG_USB_SNP_UDC_PLAT is not set=0A=
# CONFIG_USB_M66592 is not set=0A=
CONFIG_USB_BDC_UDC=3Dy=0A=
CONFIG_USB_AMD5536UDC=3Dy=0A=
CONFIG_USB_NET2272=3Dy=0A=
CONFIG_USB_NET2272_DMA=3Dy=0A=
CONFIG_USB_NET2280=3Dy=0A=
CONFIG_USB_GOKU=3Dy=0A=
CONFIG_USB_EG20T=3Dy=0A=
# CONFIG_USB_GADGET_XILINX is not set=0A=
CONFIG_USB_MAX3420_UDC=3Dy=0A=
CONFIG_USB_CDNS2_UDC=3Dy=0A=
CONFIG_USB_DUMMY_HCD=3Dy=0A=
# end of USB Peripheral Controller=0A=
=0A=
CONFIG_USB_LIBCOMPOSITE=3Dy=0A=
CONFIG_USB_F_ACM=3Dy=0A=
CONFIG_USB_F_SS_LB=3Dy=0A=
CONFIG_USB_U_SERIAL=3Dy=0A=
CONFIG_USB_U_ETHER=3Dy=0A=
CONFIG_USB_U_AUDIO=3Dy=0A=
CONFIG_USB_F_SERIAL=3Dy=0A=
CONFIG_USB_F_OBEX=3Dy=0A=
CONFIG_USB_F_NCM=3Dy=0A=
CONFIG_USB_F_ECM=3Dy=0A=
CONFIG_USB_F_PHONET=3Dy=0A=
CONFIG_USB_F_EEM=3Dy=0A=
CONFIG_USB_F_SUBSET=3Dy=0A=
CONFIG_USB_F_RNDIS=3Dy=0A=
CONFIG_USB_F_MASS_STORAGE=3Dy=0A=
CONFIG_USB_F_FS=3Dy=0A=
CONFIG_USB_F_UAC1=3Dy=0A=
CONFIG_USB_F_UAC1_LEGACY=3Dy=0A=
CONFIG_USB_F_UAC2=3Dy=0A=
CONFIG_USB_F_UVC=3Dy=0A=
CONFIG_USB_F_MIDI=3Dy=0A=
CONFIG_USB_F_MIDI2=3Dy=0A=
CONFIG_USB_F_HID=3Dy=0A=
CONFIG_USB_F_PRINTER=3Dy=0A=
CONFIG_USB_F_TCM=3Dy=0A=
CONFIG_USB_CONFIGFS=3Dy=0A=
CONFIG_USB_CONFIGFS_SERIAL=3Dy=0A=
CONFIG_USB_CONFIGFS_ACM=3Dy=0A=
CONFIG_USB_CONFIGFS_OBEX=3Dy=0A=
CONFIG_USB_CONFIGFS_NCM=3Dy=0A=
CONFIG_USB_CONFIGFS_ECM=3Dy=0A=
CONFIG_USB_CONFIGFS_ECM_SUBSET=3Dy=0A=
CONFIG_USB_CONFIGFS_RNDIS=3Dy=0A=
CONFIG_USB_CONFIGFS_EEM=3Dy=0A=
CONFIG_USB_CONFIGFS_PHONET=3Dy=0A=
CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy=0A=
CONFIG_USB_CONFIGFS_F_LB_SS=3Dy=0A=
CONFIG_USB_CONFIGFS_F_FS=3Dy=0A=
CONFIG_USB_CONFIGFS_F_UAC1=3Dy=0A=
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=3Dy=0A=
CONFIG_USB_CONFIGFS_F_UAC2=3Dy=0A=
CONFIG_USB_CONFIGFS_F_MIDI=3Dy=0A=
CONFIG_USB_CONFIGFS_F_MIDI2=3Dy=0A=
CONFIG_USB_CONFIGFS_F_HID=3Dy=0A=
CONFIG_USB_CONFIGFS_F_UVC=3Dy=0A=
CONFIG_USB_CONFIGFS_F_PRINTER=3Dy=0A=
CONFIG_USB_CONFIGFS_F_TCM=3Dy=0A=
=0A=
#=0A=
# USB Gadget precomposed configurations=0A=
#=0A=
# CONFIG_USB_ZERO is not set=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_ETH is not set=0A=
# CONFIG_USB_G_NCM is not set=0A=
CONFIG_USB_GADGETFS=3Dy=0A=
# CONFIG_USB_FUNCTIONFS is not set=0A=
# CONFIG_USB_MASS_STORAGE is not set=0A=
# CONFIG_USB_GADGET_TARGET is not set=0A=
# CONFIG_USB_G_SERIAL is not set=0A=
# CONFIG_USB_MIDI_GADGET is not set=0A=
# CONFIG_USB_G_PRINTER is not set=0A=
# CONFIG_USB_CDC_COMPOSITE is not set=0A=
# CONFIG_USB_G_NOKIA is not set=0A=
# CONFIG_USB_G_ACM_MS is not set=0A=
# CONFIG_USB_G_MULTI is not set=0A=
# CONFIG_USB_G_HID is not set=0A=
# CONFIG_USB_G_DBGP is not set=0A=
# CONFIG_USB_G_WEBCAM is not set=0A=
CONFIG_USB_RAW_GADGET=3Dy=0A=
# end of USB Gadget precomposed configurations=0A=
=0A=
CONFIG_TYPEC=3Dy=0A=
CONFIG_TYPEC_TCPM=3Dy=0A=
CONFIG_TYPEC_TCPCI=3Dy=0A=
CONFIG_TYPEC_RT1711H=3Dy=0A=
CONFIG_TYPEC_MT6360=3Dy=0A=
CONFIG_TYPEC_TCPCI_MT6370=3Dy=0A=
CONFIG_TYPEC_TCPCI_MAXIM=3Dy=0A=
CONFIG_TYPEC_FUSB302=3Dy=0A=
CONFIG_TYPEC_WCOVE=3Dy=0A=
CONFIG_TYPEC_UCSI=3Dy=0A=
CONFIG_UCSI_CCG=3Dy=0A=
CONFIG_UCSI_ACPI=3Dy=0A=
CONFIG_UCSI_STM32G0=3Dy=0A=
CONFIG_TYPEC_TPS6598X=3Dy=0A=
CONFIG_TYPEC_ANX7411=3Dy=0A=
CONFIG_TYPEC_RT1719=3Dy=0A=
CONFIG_TYPEC_HD3SS3220=3Dy=0A=
CONFIG_TYPEC_STUSB160X=3Dy=0A=
CONFIG_TYPEC_WUSB3801=3Dy=0A=
=0A=
#=0A=
# USB Type-C Multiplexer/DeMultiplexer Switch support=0A=
#=0A=
CONFIG_TYPEC_MUX_FSA4480=3Dy=0A=
CONFIG_TYPEC_MUX_GPIO_SBU=3Dy=0A=
CONFIG_TYPEC_MUX_PI3USB30532=3Dy=0A=
CONFIG_TYPEC_MUX_INTEL_PMC=3Dy=0A=
# CONFIG_TYPEC_MUX_IT5205 is not set=0A=
CONFIG_TYPEC_MUX_NB7VPQ904M=3Dy=0A=
CONFIG_TYPEC_MUX_PTN36502=3Dy=0A=
# CONFIG_TYPEC_MUX_TUSB1046 is not set=0A=
CONFIG_TYPEC_MUX_WCD939X_USBSS=3Dy=0A=
# end of USB Type-C Multiplexer/DeMultiplexer Switch support=0A=
=0A=
#=0A=
# USB Type-C Alternate Mode drivers=0A=
#=0A=
CONFIG_TYPEC_DP_ALTMODE=3Dy=0A=
CONFIG_TYPEC_NVIDIA_ALTMODE=3Dy=0A=
# end of USB Type-C Alternate Mode drivers=0A=
=0A=
CONFIG_USB_ROLE_SWITCH=3Dy=0A=
CONFIG_USB_ROLES_INTEL_XHCI=3Dy=0A=
CONFIG_MMC=3Dy=0A=
# CONFIG_PWRSEQ_EMMC is not set=0A=
# CONFIG_PWRSEQ_SD8787 is not set=0A=
# CONFIG_PWRSEQ_SIMPLE is not set=0A=
# CONFIG_MMC_BLOCK is not set=0A=
# CONFIG_SDIO_UART is not set=0A=
# CONFIG_MMC_TEST is not set=0A=
# CONFIG_MMC_CRYPTO is not set=0A=
=0A=
#=0A=
# MMC/SD/SDIO Host Controller Drivers=0A=
#=0A=
# CONFIG_MMC_DEBUG is not set=0A=
# CONFIG_MMC_SDHCI is not set=0A=
# CONFIG_MMC_WBSD is not set=0A=
# CONFIG_MMC_TIFM_SD is not set=0A=
# CONFIG_MMC_SPI is not set=0A=
# CONFIG_MMC_SDRICOH_CS is not set=0A=
# CONFIG_MMC_CB710 is not set=0A=
# CONFIG_MMC_VIA_SDMMC is not set=0A=
CONFIG_MMC_VUB300=3Dy=0A=
CONFIG_MMC_USHC=3Dy=0A=
# CONFIG_MMC_USDHI6ROL0 is not set=0A=
CONFIG_MMC_REALTEK_USB=3Dy=0A=
# CONFIG_MMC_CQHCI is not set=0A=
# CONFIG_MMC_HSQ is not set=0A=
# CONFIG_MMC_TOSHIBA_PCI is not set=0A=
# CONFIG_MMC_MTK is not set=0A=
# CONFIG_SCSI_UFSHCD is not set=0A=
CONFIG_MEMSTICK=3Dy=0A=
# CONFIG_MEMSTICK_DEBUG is not set=0A=
=0A=
#=0A=
# MemoryStick drivers=0A=
#=0A=
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set=0A=
# CONFIG_MSPRO_BLOCK is not set=0A=
# CONFIG_MS_BLOCK is not set=0A=
=0A=
#=0A=
# MemoryStick Host Controller Drivers=0A=
#=0A=
# CONFIG_MEMSTICK_TIFM_MS is not set=0A=
# CONFIG_MEMSTICK_JMICRON_38X is not set=0A=
# CONFIG_MEMSTICK_R592 is not set=0A=
CONFIG_MEMSTICK_REALTEK_USB=3Dy=0A=
CONFIG_NEW_LEDS=3Dy=0A=
CONFIG_LEDS_CLASS=3Dy=0A=
# CONFIG_LEDS_CLASS_FLASH is not set=0A=
CONFIG_LEDS_CLASS_MULTICOLOR=3Dy=0A=
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set=0A=
=0A=
#=0A=
# LED drivers=0A=
#=0A=
# CONFIG_LEDS_AN30259A is not set=0A=
# CONFIG_LEDS_APU is not set=0A=
# CONFIG_LEDS_AW200XX is not set=0A=
# CONFIG_LEDS_AW2013 is not set=0A=
# CONFIG_LEDS_BCM6328 is not set=0A=
# CONFIG_LEDS_BCM6358 is not set=0A=
# CONFIG_LEDS_CHT_WCOVE is not set=0A=
# CONFIG_LEDS_CR0014114 is not set=0A=
# CONFIG_LEDS_EL15203000 is not set=0A=
# CONFIG_LEDS_LM3530 is not set=0A=
# CONFIG_LEDS_LM3532 is not set=0A=
# CONFIG_LEDS_LM3642 is not set=0A=
# CONFIG_LEDS_LM3692X is not set=0A=
# CONFIG_LEDS_PCA9532 is not set=0A=
# CONFIG_LEDS_GPIO is not set=0A=
# CONFIG_LEDS_LP3944 is not set=0A=
# CONFIG_LEDS_LP3952 is not set=0A=
# CONFIG_LEDS_LP50XX is not set=0A=
# CONFIG_LEDS_LP55XX_COMMON is not set=0A=
# CONFIG_LEDS_LP8860 is not set=0A=
# CONFIG_LEDS_PCA955X is not set=0A=
# CONFIG_LEDS_PCA963X is not set=0A=
# CONFIG_LEDS_PCA995X is not set=0A=
# CONFIG_LEDS_DAC124S085 is not set=0A=
# CONFIG_LEDS_REGULATOR is not set=0A=
# CONFIG_LEDS_BD2606MVV is not set=0A=
# CONFIG_LEDS_BD2802 is not set=0A=
# CONFIG_LEDS_INTEL_SS4200 is not set=0A=
# CONFIG_LEDS_LT3593 is not set=0A=
# CONFIG_LEDS_TCA6507 is not set=0A=
# CONFIG_LEDS_TLC591XX is not set=0A=
# CONFIG_LEDS_LM355x is not set=0A=
# CONFIG_LEDS_IS31FL319X is not set=0A=
# CONFIG_LEDS_IS31FL32XX is not set=0A=
=0A=
#=0A=
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THI=
NGM)=0A=
#=0A=
# CONFIG_LEDS_BLINKM is not set=0A=
# CONFIG_LEDS_SYSCON is not set=0A=
# CONFIG_LEDS_MLXCPLD is not set=0A=
# CONFIG_LEDS_MLXREG is not set=0A=
# CONFIG_LEDS_USER is not set=0A=
# CONFIG_LEDS_NIC78BX is not set=0A=
# CONFIG_LEDS_SPI_BYTE is not set=0A=
# CONFIG_LEDS_LM3697 is not set=0A=
# CONFIG_LEDS_LGM is not set=0A=
=0A=
#=0A=
# Flash and Torch LED drivers=0A=
#=0A=
=0A=
#=0A=
# RGB LED drivers=0A=
#=0A=
# CONFIG_LEDS_GROUP_MULTICOLOR is not set=0A=
# CONFIG_LEDS_KTD202X is not set=0A=
# CONFIG_LEDS_NCP5623 is not set=0A=
# CONFIG_LEDS_MT6370_RGB is not set=0A=
=0A=
#=0A=
# LED Triggers=0A=
#=0A=
CONFIG_LEDS_TRIGGERS=3Dy=0A=
# CONFIG_LEDS_TRIGGER_TIMER is not set=0A=
# CONFIG_LEDS_TRIGGER_ONESHOT is not set=0A=
# CONFIG_LEDS_TRIGGER_DISK is not set=0A=
# CONFIG_LEDS_TRIGGER_MTD is not set=0A=
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set=0A=
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set=0A=
# CONFIG_LEDS_TRIGGER_CPU is not set=0A=
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set=0A=
# CONFIG_LEDS_TRIGGER_GPIO is not set=0A=
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set=0A=
=0A=
#=0A=
# iptables trigger is under Netfilter config (LED target)=0A=
#=0A=
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set=0A=
# CONFIG_LEDS_TRIGGER_CAMERA is not set=0A=
# CONFIG_LEDS_TRIGGER_PANIC is not set=0A=
# CONFIG_LEDS_TRIGGER_NETDEV is not set=0A=
# CONFIG_LEDS_TRIGGER_PATTERN is not set=0A=
# CONFIG_LEDS_TRIGGER_TTY is not set=0A=
# CONFIG_LEDS_TRIGGER_INPUT_EVENTS is not set=0A=
=0A=
#=0A=
# Simple LED drivers=0A=
#=0A=
# CONFIG_ACCESSIBILITY is not set=0A=
CONFIG_INFINIBAND=3Dy=0A=
CONFIG_INFINIBAND_USER_MAD=3Dy=0A=
CONFIG_INFINIBAND_USER_ACCESS=3Dy=0A=
CONFIG_INFINIBAND_USER_MEM=3Dy=0A=
CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy=0A=
CONFIG_INFINIBAND_ADDR_TRANS=3Dy=0A=
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy=0A=
CONFIG_INFINIBAND_VIRT_DMA=3Dy=0A=
# CONFIG_INFINIBAND_EFA is not set=0A=
# CONFIG_INFINIBAND_ERDMA is not set=0A=
CONFIG_MLX4_INFINIBAND=3Dy=0A=
# CONFIG_INFINIBAND_MTHCA is not set=0A=
# CONFIG_INFINIBAND_OCRDMA is not set=0A=
# CONFIG_INFINIBAND_USNIC is not set=0A=
# CONFIG_INFINIBAND_VMWARE_PVRDMA is not set=0A=
# CONFIG_INFINIBAND_RDMAVT is not set=0A=
CONFIG_RDMA_RXE=3Dy=0A=
CONFIG_RDMA_SIW=3Dy=0A=
CONFIG_INFINIBAND_IPOIB=3Dy=0A=
CONFIG_INFINIBAND_IPOIB_CM=3Dy=0A=
CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy=0A=
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set=0A=
CONFIG_INFINIBAND_SRP=3Dy=0A=
# CONFIG_INFINIBAND_SRPT is not set=0A=
CONFIG_INFINIBAND_ISER=3Dy=0A=
CONFIG_INFINIBAND_RTRS=3Dy=0A=
CONFIG_INFINIBAND_RTRS_CLIENT=3Dy=0A=
# CONFIG_INFINIBAND_RTRS_SERVER is not set=0A=
# CONFIG_INFINIBAND_OPA_VNIC is not set=0A=
CONFIG_EDAC_ATOMIC_SCRUB=3Dy=0A=
CONFIG_EDAC_SUPPORT=3Dy=0A=
CONFIG_EDAC=3Dy=0A=
# CONFIG_EDAC_LEGACY_SYSFS is not set=0A=
# CONFIG_EDAC_DEBUG is not set=0A=
# CONFIG_EDAC_DECODE_MCE is not set=0A=
# CONFIG_EDAC_E752X is not set=0A=
# CONFIG_EDAC_I82975X is not set=0A=
# CONFIG_EDAC_I3000 is not set=0A=
# CONFIG_EDAC_I3200 is not set=0A=
# CONFIG_EDAC_IE31200 is not set=0A=
# CONFIG_EDAC_X38 is not set=0A=
# CONFIG_EDAC_I5400 is not set=0A=
# CONFIG_EDAC_I7CORE is not set=0A=
# CONFIG_EDAC_I5100 is not set=0A=
# CONFIG_EDAC_I7300 is not set=0A=
# CONFIG_EDAC_SBRIDGE is not set=0A=
# CONFIG_EDAC_SKX is not set=0A=
# CONFIG_EDAC_I10NM is not set=0A=
# CONFIG_EDAC_PND2 is not set=0A=
# CONFIG_EDAC_IGEN6 is not set=0A=
CONFIG_RTC_LIB=3Dy=0A=
CONFIG_RTC_MC146818_LIB=3Dy=0A=
CONFIG_RTC_CLASS=3Dy=0A=
# CONFIG_RTC_HCTOSYS is not set=0A=
CONFIG_RTC_SYSTOHC=3Dy=0A=
CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"=0A=
# CONFIG_RTC_DEBUG is not set=0A=
# CONFIG_RTC_NVMEM is not set=0A=
=0A=
#=0A=
# RTC interfaces=0A=
#=0A=
CONFIG_RTC_INTF_SYSFS=3Dy=0A=
CONFIG_RTC_INTF_PROC=3Dy=0A=
CONFIG_RTC_INTF_DEV=3Dy=0A=
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set=0A=
# CONFIG_RTC_DRV_TEST is not set=0A=
=0A=
#=0A=
# I2C RTC drivers=0A=
#=0A=
# CONFIG_RTC_DRV_ABB5ZES3 is not set=0A=
# CONFIG_RTC_DRV_ABEOZ9 is not set=0A=
# CONFIG_RTC_DRV_ABX80X is not set=0A=
# CONFIG_RTC_DRV_DS1307 is not set=0A=
# CONFIG_RTC_DRV_DS1374 is not set=0A=
# CONFIG_RTC_DRV_DS1672 is not set=0A=
# CONFIG_RTC_DRV_HYM8563 is not set=0A=
# CONFIG_RTC_DRV_MAX6900 is not set=0A=
# CONFIG_RTC_DRV_MAX31335 is not set=0A=
# CONFIG_RTC_DRV_NCT3018Y is not set=0A=
# CONFIG_RTC_DRV_RS5C372 is not set=0A=
# CONFIG_RTC_DRV_ISL1208 is not set=0A=
# CONFIG_RTC_DRV_ISL12022 is not set=0A=
# CONFIG_RTC_DRV_ISL12026 is not set=0A=
# CONFIG_RTC_DRV_X1205 is not set=0A=
# CONFIG_RTC_DRV_PCF8523 is not set=0A=
# CONFIG_RTC_DRV_PCF85063 is not set=0A=
# CONFIG_RTC_DRV_PCF85363 is not set=0A=
# CONFIG_RTC_DRV_PCF8563 is not set=0A=
# CONFIG_RTC_DRV_PCF8583 is not set=0A=
# CONFIG_RTC_DRV_M41T80 is not set=0A=
# CONFIG_RTC_DRV_BQ32K is not set=0A=
# CONFIG_RTC_DRV_TWL4030 is not set=0A=
# CONFIG_RTC_DRV_S35390A is not set=0A=
# CONFIG_RTC_DRV_FM3130 is not set=0A=
# CONFIG_RTC_DRV_RX8010 is not set=0A=
# CONFIG_RTC_DRV_RX8111 is not set=0A=
# CONFIG_RTC_DRV_RX8581 is not set=0A=
# CONFIG_RTC_DRV_RX8025 is not set=0A=
# CONFIG_RTC_DRV_EM3027 is not set=0A=
# CONFIG_RTC_DRV_RV3028 is not set=0A=
# CONFIG_RTC_DRV_RV3032 is not set=0A=
# CONFIG_RTC_DRV_RV8803 is not set=0A=
# CONFIG_RTC_DRV_SD2405AL is not set=0A=
# CONFIG_RTC_DRV_SD3078 is not set=0A=
=0A=
#=0A=
# SPI RTC drivers=0A=
#=0A=
# CONFIG_RTC_DRV_M41T93 is not set=0A=
# CONFIG_RTC_DRV_M41T94 is not set=0A=
# CONFIG_RTC_DRV_DS1302 is not set=0A=
# CONFIG_RTC_DRV_DS1305 is not set=0A=
# CONFIG_RTC_DRV_DS1343 is not set=0A=
# CONFIG_RTC_DRV_DS1347 is not set=0A=
# CONFIG_RTC_DRV_DS1390 is not set=0A=
# CONFIG_RTC_DRV_MAX6916 is not set=0A=
# CONFIG_RTC_DRV_R9701 is not set=0A=
# CONFIG_RTC_DRV_RX4581 is not set=0A=
# CONFIG_RTC_DRV_RS5C348 is not set=0A=
# CONFIG_RTC_DRV_MAX6902 is not set=0A=
# CONFIG_RTC_DRV_PCF2123 is not set=0A=
# CONFIG_RTC_DRV_MCP795 is not set=0A=
CONFIG_RTC_I2C_AND_SPI=3Dy=0A=
=0A=
#=0A=
# SPI and I2C RTC drivers=0A=
#=0A=
# CONFIG_RTC_DRV_DS3232 is not set=0A=
# CONFIG_RTC_DRV_PCF2127 is not set=0A=
# CONFIG_RTC_DRV_RV3029C2 is not set=0A=
# CONFIG_RTC_DRV_RX6110 is not set=0A=
=0A=
#=0A=
# Platform RTC drivers=0A=
#=0A=
CONFIG_RTC_DRV_CMOS=3Dy=0A=
# CONFIG_RTC_DRV_DS1286 is not set=0A=
# CONFIG_RTC_DRV_DS1511 is not set=0A=
# CONFIG_RTC_DRV_DS1553 is not set=0A=
# CONFIG_RTC_DRV_DS1685_FAMILY is not set=0A=
# CONFIG_RTC_DRV_DS1742 is not set=0A=
# CONFIG_RTC_DRV_DS2404 is not set=0A=
# CONFIG_RTC_DRV_STK17TA8 is not set=0A=
# CONFIG_RTC_DRV_M48T86 is not set=0A=
# CONFIG_RTC_DRV_M48T35 is not set=0A=
# CONFIG_RTC_DRV_M48T59 is not set=0A=
# CONFIG_RTC_DRV_MSM6242 is not set=0A=
# CONFIG_RTC_DRV_RP5C01 is not set=0A=
# CONFIG_RTC_DRV_ZYNQMP is not set=0A=
=0A=
#=0A=
# on-CPU RTC drivers=0A=
#=0A=
# CONFIG_RTC_DRV_CADENCE is not set=0A=
# CONFIG_RTC_DRV_FTRTC010 is not set=0A=
# CONFIG_RTC_DRV_R7301 is not set=0A=
=0A=
#=0A=
# HID Sensor RTC drivers=0A=
#=0A=
CONFIG_RTC_DRV_HID_SENSOR_TIME=3Dy=0A=
# CONFIG_RTC_DRV_GOLDFISH is not set=0A=
CONFIG_DMADEVICES=3Dy=0A=
# CONFIG_DMADEVICES_DEBUG is not set=0A=
=0A=
#=0A=
# DMA Devices=0A=
#=0A=
CONFIG_DMA_ENGINE=3Dy=0A=
CONFIG_DMA_VIRTUAL_CHANNELS=3Dy=0A=
CONFIG_DMA_ACPI=3Dy=0A=
CONFIG_DMA_OF=3Dy=0A=
# CONFIG_ALTERA_MSGDMA is not set=0A=
# CONFIG_DW_AXI_DMAC is not set=0A=
# CONFIG_FSL_EDMA is not set=0A=
CONFIG_INTEL_IDMA64=3Dy=0A=
# CONFIG_INTEL_IDXD is not set=0A=
# CONFIG_INTEL_IDXD_COMPAT is not set=0A=
CONFIG_INTEL_IOATDMA=3Dy=0A=
# CONFIG_PLX_DMA is not set=0A=
# CONFIG_XILINX_DMA is not set=0A=
# CONFIG_XILINX_XDMA is not set=0A=
# CONFIG_XILINX_ZYNQMP_DPDMA is not set=0A=
# CONFIG_AMD_QDMA is not set=0A=
# CONFIG_AMD_PTDMA is not set=0A=
# CONFIG_QCOM_HIDMA_MGMT is not set=0A=
# CONFIG_QCOM_HIDMA is not set=0A=
CONFIG_DW_DMAC_CORE=3Dy=0A=
# CONFIG_DW_DMAC is not set=0A=
# CONFIG_DW_DMAC_PCI is not set=0A=
# CONFIG_DW_EDMA is not set=0A=
CONFIG_HSU_DMA=3Dy=0A=
# CONFIG_SF_PDMA is not set=0A=
# CONFIG_INTEL_LDMA is not set=0A=
=0A=
#=0A=
# DMA Clients=0A=
#=0A=
CONFIG_ASYNC_TX_DMA=3Dy=0A=
# CONFIG_DMATEST is not set=0A=
CONFIG_DMA_ENGINE_RAID=3Dy=0A=
=0A=
#=0A=
# DMABUF options=0A=
#=0A=
CONFIG_SYNC_FILE=3Dy=0A=
CONFIG_SW_SYNC=3Dy=0A=
CONFIG_UDMABUF=3Dy=0A=
CONFIG_DMABUF_MOVE_NOTIFY=3Dy=0A=
# CONFIG_DMABUF_DEBUG is not set=0A=
# CONFIG_DMABUF_SELFTESTS is not set=0A=
CONFIG_DMABUF_HEAPS=3Dy=0A=
# CONFIG_DMABUF_SYSFS_STATS is not set=0A=
CONFIG_DMABUF_HEAPS_SYSTEM=3Dy=0A=
CONFIG_DMABUF_HEAPS_CMA=3Dy=0A=
# end of DMABUF options=0A=
=0A=
CONFIG_DCA=3Dy=0A=
# CONFIG_UIO is not set=0A=
CONFIG_VFIO=3Dy=0A=
CONFIG_VFIO_DEVICE_CDEV=3Dy=0A=
# CONFIG_VFIO_GROUP is not set=0A=
CONFIG_VFIO_VIRQFD=3Dy=0A=
# CONFIG_VFIO_DEBUGFS is not set=0A=
=0A=
#=0A=
# VFIO support for PCI devices=0A=
#=0A=
CONFIG_VFIO_PCI_CORE=3Dy=0A=
CONFIG_VFIO_PCI_MMAP=3Dy=0A=
CONFIG_VFIO_PCI_INTX=3Dy=0A=
CONFIG_VFIO_PCI=3Dy=0A=
# CONFIG_VFIO_PCI_VGA is not set=0A=
# CONFIG_VFIO_PCI_IGD is not set=0A=
# CONFIG_VIRTIO_VFIO_PCI is not set=0A=
# end of VFIO support for PCI devices=0A=
=0A=
CONFIG_IRQ_BYPASS_MANAGER=3Dy=0A=
# CONFIG_VIRT_DRIVERS is not set=0A=
CONFIG_VIRTIO_ANCHOR=3Dy=0A=
CONFIG_VIRTIO=3Dy=0A=
CONFIG_VIRTIO_PCI_LIB=3Dy=0A=
CONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy=0A=
CONFIG_VIRTIO_MENU=3Dy=0A=
CONFIG_VIRTIO_PCI=3Dy=0A=
CONFIG_VIRTIO_PCI_ADMIN_LEGACY=3Dy=0A=
CONFIG_VIRTIO_PCI_LEGACY=3Dy=0A=
CONFIG_VIRTIO_VDPA=3Dy=0A=
CONFIG_VIRTIO_PMEM=3Dy=0A=
CONFIG_VIRTIO_BALLOON=3Dy=0A=
CONFIG_VIRTIO_MEM=3Dy=0A=
CONFIG_VIRTIO_INPUT=3Dy=0A=
CONFIG_VIRTIO_MMIO=3Dy=0A=
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=3Dy=0A=
CONFIG_VIRTIO_DMA_SHARED_BUFFER=3Dy=0A=
# CONFIG_VIRTIO_DEBUG is not set=0A=
CONFIG_VDPA=3Dy=0A=
CONFIG_VDPA_SIM=3Dy=0A=
CONFIG_VDPA_SIM_NET=3Dy=0A=
CONFIG_VDPA_SIM_BLOCK=3Dy=0A=
# CONFIG_IFCVF is not set=0A=
# CONFIG_MLX5_VDPA_STEERING_DEBUG is not set=0A=
CONFIG_VP_VDPA=3Dy=0A=
# CONFIG_ALIBABA_ENI_VDPA is not set=0A=
# CONFIG_SNET_VDPA is not set=0A=
# CONFIG_OCTEONEP_VDPA is not set=0A=
CONFIG_VHOST_IOTLB=3Dy=0A=
CONFIG_VHOST_RING=3Dy=0A=
CONFIG_VHOST_TASK=3Dy=0A=
CONFIG_VHOST=3Dy=0A=
CONFIG_VHOST_MENU=3Dy=0A=
CONFIG_VHOST_NET=3Dy=0A=
# CONFIG_VHOST_SCSI is not set=0A=
CONFIG_VHOST_VSOCK=3Dy=0A=
CONFIG_VHOST_VDPA=3Dy=0A=
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=3Dy=0A=
=0A=
#=0A=
# Microsoft Hyper-V guest support=0A=
#=0A=
# CONFIG_HYPERV is not set=0A=
# end of Microsoft Hyper-V guest support=0A=
=0A=
CONFIG_GREYBUS=3Dy=0A=
# CONFIG_GREYBUS_BEAGLEPLAY is not set=0A=
CONFIG_GREYBUS_ES2=3Dy=0A=
CONFIG_COMEDI=3Dy=0A=
# CONFIG_COMEDI_DEBUG is not set=0A=
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=3D2048=0A=
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=3D20480=0A=
# CONFIG_COMEDI_MISC_DRIVERS is not set=0A=
# CONFIG_COMEDI_PCI_DRIVERS is not set=0A=
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set=0A=
CONFIG_COMEDI_USB_DRIVERS=3Dy=0A=
CONFIG_COMEDI_DT9812=3Dy=0A=
CONFIG_COMEDI_NI_USB6501=3Dy=0A=
CONFIG_COMEDI_USBDUX=3Dy=0A=
CONFIG_COMEDI_USBDUXFAST=3Dy=0A=
CONFIG_COMEDI_USBDUXSIGMA=3Dy=0A=
CONFIG_COMEDI_VMK80XX=3Dy=0A=
# CONFIG_COMEDI_8255_SA is not set=0A=
# CONFIG_COMEDI_KCOMEDILIB is not set=0A=
# CONFIG_COMEDI_TESTS is not set=0A=
CONFIG_STAGING=3Dy=0A=
# CONFIG_RTL8723BS is not set=0A=
=0A=
#=0A=
# IIO staging drivers=0A=
#=0A=
=0A=
#=0A=
# Accelerometers=0A=
#=0A=
# CONFIG_ADIS16203 is not set=0A=
# CONFIG_ADIS16240 is not set=0A=
# end of Accelerometers=0A=
=0A=
#=0A=
# Analog to digital converters=0A=
#=0A=
# CONFIG_AD7816 is not set=0A=
# end of Analog to digital converters=0A=
=0A=
#=0A=
# Analog digital bi-direction converters=0A=
#=0A=
# CONFIG_ADT7316 is not set=0A=
# end of Analog digital bi-direction converters=0A=
=0A=
#=0A=
# Direct Digital Synthesis=0A=
#=0A=
# CONFIG_AD9832 is not set=0A=
# CONFIG_AD9834 is not set=0A=
# end of Direct Digital Synthesis=0A=
=0A=
#=0A=
# Network Analyzer, Impedance Converters=0A=
#=0A=
# CONFIG_AD5933 is not set=0A=
# end of Network Analyzer, Impedance Converters=0A=
# end of IIO staging drivers=0A=
=0A=
# CONFIG_FB_SM750 is not set=0A=
# CONFIG_STAGING_MEDIA is not set=0A=
# CONFIG_FB_TFT is not set=0A=
# CONFIG_MOST_COMPONENTS is not set=0A=
# CONFIG_GREYBUS_AUDIO is not set=0A=
# CONFIG_GREYBUS_BOOTROM is not set=0A=
# CONFIG_GREYBUS_FIRMWARE is not set=0A=
CONFIG_GREYBUS_HID=3Dy=0A=
# CONFIG_GREYBUS_LOG is not set=0A=
# CONFIG_GREYBUS_LOOPBACK is not set=0A=
# CONFIG_GREYBUS_POWER is not set=0A=
# CONFIG_GREYBUS_RAW is not set=0A=
# CONFIG_GREYBUS_VIBRATOR is not set=0A=
CONFIG_GREYBUS_BRIDGED_PHY=3Dy=0A=
# CONFIG_GREYBUS_GPIO is not set=0A=
# CONFIG_GREYBUS_I2C is not set=0A=
# CONFIG_GREYBUS_SDIO is not set=0A=
# CONFIG_GREYBUS_SPI is not set=0A=
# CONFIG_GREYBUS_UART is not set=0A=
CONFIG_GREYBUS_USB=3Dy=0A=
# CONFIG_XIL_AXIS_FIFO is not set=0A=
# CONFIG_VME_BUS is not set=0A=
# CONFIG_GPIB is not set=0A=
# CONFIG_GOLDFISH is not set=0A=
# CONFIG_CHROME_PLATFORMS is not set=0A=
# CONFIG_CZNIC_PLATFORMS is not set=0A=
# CONFIG_MELLANOX_PLATFORM is not set=0A=
CONFIG_SURFACE_PLATFORMS=3Dy=0A=
# CONFIG_SURFACE3_WMI is not set=0A=
# CONFIG_SURFACE_3_POWER_OPREGION is not set=0A=
# CONFIG_SURFACE_GPE is not set=0A=
# CONFIG_SURFACE_HOTPLUG is not set=0A=
# CONFIG_SURFACE_PRO3_BUTTON is not set=0A=
# CONFIG_SURFACE_AGGREGATOR is not set=0A=
CONFIG_X86_PLATFORM_DEVICES=3Dy=0A=
CONFIG_ACPI_WMI=3Dy=0A=
CONFIG_WMI_BMOF=3Dy=0A=
# CONFIG_HUAWEI_WMI is not set=0A=
# CONFIG_MXM_WMI is not set=0A=
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set=0A=
# CONFIG_XIAOMI_WMI is not set=0A=
# CONFIG_GIGABYTE_WMI is not set=0A=
# CONFIG_YOGABOOK is not set=0A=
# CONFIG_YT2_1380 is not set=0A=
# CONFIG_ACERHDF is not set=0A=
# CONFIG_ACER_WIRELESS is not set=0A=
# CONFIG_ACER_WMI is not set=0A=
=0A=
#=0A=
# AMD HSMP Driver=0A=
#=0A=
# CONFIG_AMD_HSMP_ACPI is not set=0A=
# CONFIG_AMD_HSMP_PLAT is not set=0A=
# end of AMD HSMP Driver=0A=
=0A=
# CONFIG_AMD_PMC is not set=0A=
# CONFIG_AMD_3D_VCACHE is not set=0A=
# CONFIG_AMD_WBRF is not set=0A=
# CONFIG_ADV_SWBUTTON is not set=0A=
# CONFIG_APPLE_GMUX is not set=0A=
# CONFIG_ASUS_LAPTOP is not set=0A=
# CONFIG_ASUS_WIRELESS is not set=0A=
CONFIG_ASUS_WMI=3Dy=0A=
# CONFIG_ASUS_NB_WMI is not set=0A=
CONFIG_ASUS_TF103C_DOCK=3Dy=0A=
CONFIG_EEEPC_LAPTOP=3Dy=0A=
# CONFIG_EEEPC_WMI is not set=0A=
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set=0A=
# CONFIG_AMILO_RFKILL is not set=0A=
# CONFIG_FUJITSU_LAPTOP is not set=0A=
# CONFIG_FUJITSU_TABLET is not set=0A=
# CONFIG_GPD_POCKET_FAN is not set=0A=
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set=0A=
# CONFIG_WIRELESS_HOTKEY is not set=0A=
# CONFIG_IBM_RTL is not set=0A=
# CONFIG_IDEAPAD_LAPTOP is not set=0A=
# CONFIG_SENSORS_HDAPS is not set=0A=
# CONFIG_THINKPAD_ACPI is not set=0A=
# CONFIG_THINKPAD_LMI is not set=0A=
# CONFIG_INTEL_ATOMISP2_PM is not set=0A=
# CONFIG_INTEL_IFS is not set=0A=
# CONFIG_INTEL_SAR_INT1092 is not set=0A=
# CONFIG_INTEL_SKL_INT3472 is not set=0A=
=0A=
#=0A=
# Intel Speed Select Technology interface support=0A=
#=0A=
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set=0A=
# end of Intel Speed Select Technology interface support=0A=
=0A=
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set=0A=
# CONFIG_INTEL_WMI_THUNDERBOLT is not set=0A=
=0A=
#=0A=
# Intel Uncore Frequency Control=0A=
#=0A=
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set=0A=
# end of Intel Uncore Frequency Control=0A=
=0A=
# CONFIG_INTEL_HID_EVENT is not set=0A=
# CONFIG_INTEL_VBTN is not set=0A=
# CONFIG_INTEL_INT0002_VGPIO is not set=0A=
# CONFIG_INTEL_OAKTRAIL is not set=0A=
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set=0A=
CONFIG_INTEL_CHTWC_INT33FE=3Dy=0A=
CONFIG_INTEL_ISHTP_ECLITE=3Dy=0A=
# CONFIG_INTEL_PUNIT_IPC is not set=0A=
# CONFIG_INTEL_RST is not set=0A=
# CONFIG_INTEL_SMARTCONNECT is not set=0A=
# CONFIG_INTEL_TURBO_MAX_3 is not set=0A=
# CONFIG_INTEL_VSEC is not set=0A=
# CONFIG_ACPI_QUICKSTART is not set=0A=
# CONFIG_MEEGOPAD_ANX7428 is not set=0A=
# CONFIG_MSI_EC is not set=0A=
# CONFIG_MSI_LAPTOP is not set=0A=
# CONFIG_MSI_WMI is not set=0A=
# CONFIG_MSI_WMI_PLATFORM is not set=0A=
# CONFIG_PCENGINES_APU2 is not set=0A=
# CONFIG_BARCO_P50_GPIO is not set=0A=
# CONFIG_SAMSUNG_LAPTOP is not set=0A=
# CONFIG_SAMSUNG_Q10 is not set=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
# CONFIG_TOSHIBA_BT_RFKILL is not set=0A=
# CONFIG_TOSHIBA_HAPS is not set=0A=
# CONFIG_TOSHIBA_WMI is not set=0A=
# CONFIG_ACPI_CMPC is not set=0A=
# CONFIG_COMPAL_LAPTOP is not set=0A=
# CONFIG_LG_LAPTOP is not set=0A=
# CONFIG_PANASONIC_LAPTOP is not set=0A=
# CONFIG_SONY_LAPTOP is not set=0A=
# CONFIG_SYSTEM76_ACPI is not set=0A=
# CONFIG_TOPSTAR_LAPTOP is not set=0A=
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set=0A=
# CONFIG_MLX_PLATFORM is not set=0A=
# CONFIG_INSPUR_PLATFORM_PROFILE is not set=0A=
# CONFIG_LENOVO_WMI_CAMERA is not set=0A=
# CONFIG_INTEL_IPS is not set=0A=
CONFIG_INTEL_SCU_IPC=3Dy=0A=
# CONFIG_INTEL_SCU_PCI is not set=0A=
# CONFIG_INTEL_SCU_PLATFORM is not set=0A=
# CONFIG_SIEMENS_SIMATIC_IPC is not set=0A=
# CONFIG_SILICOM_PLATFORM is not set=0A=
# CONFIG_WINMATE_FM07_KEYS is not set=0A=
CONFIG_P2SB=3Dy=0A=
CONFIG_HAVE_CLK=3Dy=0A=
CONFIG_HAVE_CLK_PREPARE=3Dy=0A=
CONFIG_COMMON_CLK=3Dy=0A=
# CONFIG_LMK04832 is not set=0A=
# CONFIG_COMMON_CLK_MAX9485 is not set=0A=
# CONFIG_COMMON_CLK_SI5341 is not set=0A=
# CONFIG_COMMON_CLK_SI5351 is not set=0A=
# CONFIG_COMMON_CLK_SI514 is not set=0A=
# CONFIG_COMMON_CLK_SI544 is not set=0A=
# CONFIG_COMMON_CLK_SI570 is not set=0A=
# CONFIG_COMMON_CLK_CDCE706 is not set=0A=
# CONFIG_COMMON_CLK_CDCE925 is not set=0A=
# CONFIG_COMMON_CLK_CS2000_CP is not set=0A=
# CONFIG_CLK_TWL is not set=0A=
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set=0A=
# CONFIG_COMMON_CLK_RS9_PCIE is not set=0A=
# CONFIG_COMMON_CLK_SI521XX is not set=0A=
# CONFIG_COMMON_CLK_VC3 is not set=0A=
# CONFIG_COMMON_CLK_VC5 is not set=0A=
# CONFIG_COMMON_CLK_VC7 is not set=0A=
# CONFIG_COMMON_CLK_FIXED_MMIO is not set=0A=
# CONFIG_CLK_LGM_CGU is not set=0A=
# CONFIG_XILINX_VCU is not set=0A=
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set=0A=
# CONFIG_HWSPINLOCK is not set=0A=
=0A=
#=0A=
# Clock Source drivers=0A=
#=0A=
CONFIG_CLKEVT_I8253=3Dy=0A=
CONFIG_I8253_LOCK=3Dy=0A=
CONFIG_CLKBLD_I8253=3Dy=0A=
# end of Clock Source drivers=0A=
=0A=
CONFIG_MAILBOX=3Dy=0A=
# CONFIG_PLATFORM_MHU is not set=0A=
CONFIG_PCC=3Dy=0A=
# CONFIG_ALTERA_MBOX is not set=0A=
# CONFIG_MAILBOX_TEST is not set=0A=
CONFIG_IOMMU_IOVA=3Dy=0A=
CONFIG_IOMMU_API=3Dy=0A=
CONFIG_IOMMUFD_DRIVER=3Dy=0A=
CONFIG_IOMMU_SUPPORT=3Dy=0A=
=0A=
#=0A=
# Generic IOMMU Pagetable Support=0A=
#=0A=
# end of Generic IOMMU Pagetable Support=0A=
=0A=
# CONFIG_IOMMU_DEBUGFS is not set=0A=
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set=0A=
CONFIG_IOMMU_DEFAULT_DMA_LAZY=3Dy=0A=
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set=0A=
CONFIG_OF_IOMMU=3Dy=0A=
CONFIG_IOMMU_DMA=3Dy=0A=
CONFIG_IOMMU_SVA=3Dy=0A=
CONFIG_IOMMU_IOPF=3Dy=0A=
# CONFIG_AMD_IOMMU is not set=0A=
CONFIG_DMAR_TABLE=3Dy=0A=
CONFIG_INTEL_IOMMU=3Dy=0A=
CONFIG_INTEL_IOMMU_SVM=3Dy=0A=
CONFIG_INTEL_IOMMU_DEFAULT_ON=3Dy=0A=
CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy=0A=
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=3Dy=0A=
CONFIG_INTEL_IOMMU_PERF_EVENTS=3Dy=0A=
CONFIG_IOMMUFD_DRIVER_CORE=3Dy=0A=
CONFIG_IOMMUFD=3Dy=0A=
CONFIG_IOMMUFD_TEST=3Dy=0A=
CONFIG_IRQ_REMAP=3Dy=0A=
# CONFIG_VIRTIO_IOMMU is not set=0A=
=0A=
#=0A=
# Remoteproc drivers=0A=
#=0A=
# CONFIG_REMOTEPROC is not set=0A=
# end of Remoteproc drivers=0A=
=0A=
#=0A=
# Rpmsg drivers=0A=
#=0A=
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set=0A=
# CONFIG_RPMSG_VIRTIO is not set=0A=
# end of Rpmsg drivers=0A=
=0A=
CONFIG_SOUNDWIRE=3Dy=0A=
=0A=
#=0A=
# SoundWire Devices=0A=
#=0A=
# CONFIG_SOUNDWIRE_AMD is not set=0A=
# CONFIG_SOUNDWIRE_INTEL is not set=0A=
# CONFIG_SOUNDWIRE_QCOM is not set=0A=
=0A=
#=0A=
# SOC (System On Chip) specific Drivers=0A=
#=0A=
=0A=
#=0A=
# Amlogic SoC drivers=0A=
#=0A=
# end of Amlogic SoC drivers=0A=
=0A=
#=0A=
# Broadcom SoC drivers=0A=
#=0A=
# end of Broadcom SoC drivers=0A=
=0A=
#=0A=
# NXP/Freescale QorIQ SoC drivers=0A=
#=0A=
# end of NXP/Freescale QorIQ SoC drivers=0A=
=0A=
#=0A=
# fujitsu SoC drivers=0A=
#=0A=
# end of fujitsu SoC drivers=0A=
=0A=
#=0A=
# i.MX SoC drivers=0A=
#=0A=
# end of i.MX SoC drivers=0A=
=0A=
#=0A=
# Enable LiteX SoC Builder specific drivers=0A=
#=0A=
# CONFIG_LITEX_SOC_CONTROLLER is not set=0A=
# end of Enable LiteX SoC Builder specific drivers=0A=
=0A=
# CONFIG_WPCM450_SOC is not set=0A=
=0A=
#=0A=
# Qualcomm SoC drivers=0A=
#=0A=
CONFIG_QCOM_QMI_HELPERS=3Dy=0A=
# end of Qualcomm SoC drivers=0A=
=0A=
# CONFIG_SOC_TI is not set=0A=
=0A=
#=0A=
# Xilinx SoC drivers=0A=
#=0A=
# end of Xilinx SoC drivers=0A=
# end of SOC (System On Chip) specific Drivers=0A=
=0A=
#=0A=
# PM Domains=0A=
#=0A=
=0A=
#=0A=
# Amlogic PM Domains=0A=
#=0A=
# end of Amlogic PM Domains=0A=
=0A=
#=0A=
# Broadcom PM Domains=0A=
#=0A=
# end of Broadcom PM Domains=0A=
=0A=
#=0A=
# i.MX PM Domains=0A=
#=0A=
# end of i.MX PM Domains=0A=
=0A=
#=0A=
# Qualcomm PM Domains=0A=
#=0A=
# end of Qualcomm PM Domains=0A=
# end of PM Domains=0A=
=0A=
# CONFIG_PM_DEVFREQ is not set=0A=
CONFIG_EXTCON=3Dy=0A=
=0A=
#=0A=
# Extcon Device Drivers=0A=
#=0A=
# CONFIG_EXTCON_ADC_JACK is not set=0A=
# CONFIG_EXTCON_FSA9480 is not set=0A=
# CONFIG_EXTCON_GPIO is not set=0A=
# CONFIG_EXTCON_INTEL_INT3496 is not set=0A=
CONFIG_EXTCON_INTEL_CHT_WC=3Dy=0A=
# CONFIG_EXTCON_LC824206XA is not set=0A=
# CONFIG_EXTCON_MAX3355 is not set=0A=
CONFIG_EXTCON_PTN5150=3Dy=0A=
# CONFIG_EXTCON_RT8973A is not set=0A=
# CONFIG_EXTCON_SM5502 is not set=0A=
# CONFIG_EXTCON_USB_GPIO is not set=0A=
CONFIG_EXTCON_USBC_TUSB320=3Dy=0A=
# CONFIG_MEMORY is not set=0A=
CONFIG_IIO=3Dy=0A=
CONFIG_IIO_BUFFER=3Dy=0A=
# CONFIG_IIO_BUFFER_CB is not set=0A=
# CONFIG_IIO_BUFFER_DMA is not set=0A=
# CONFIG_IIO_BUFFER_DMAENGINE is not set=0A=
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set=0A=
CONFIG_IIO_KFIFO_BUF=3Dy=0A=
CONFIG_IIO_TRIGGERED_BUFFER=3Dy=0A=
# CONFIG_IIO_CONFIGFS is not set=0A=
CONFIG_IIO_TRIGGER=3Dy=0A=
CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2=0A=
# CONFIG_IIO_SW_DEVICE is not set=0A=
# CONFIG_IIO_SW_TRIGGER is not set=0A=
# CONFIG_IIO_TRIGGERED_EVENT is not set=0A=
=0A=
#=0A=
# Accelerometers=0A=
#=0A=
# CONFIG_ADIS16201 is not set=0A=
# CONFIG_ADIS16209 is not set=0A=
# CONFIG_ADXL313_I2C is not set=0A=
# CONFIG_ADXL313_SPI is not set=0A=
# CONFIG_ADXL345_I2C is not set=0A=
# CONFIG_ADXL345_SPI is not set=0A=
# CONFIG_ADXL355_I2C is not set=0A=
# CONFIG_ADXL355_SPI is not set=0A=
# CONFIG_ADXL367_SPI is not set=0A=
# CONFIG_ADXL367_I2C is not set=0A=
# CONFIG_ADXL372_SPI is not set=0A=
# CONFIG_ADXL372_I2C is not set=0A=
# CONFIG_ADXL380_SPI is not set=0A=
# CONFIG_ADXL380_I2C is not set=0A=
# CONFIG_BMA180 is not set=0A=
# CONFIG_BMA220 is not set=0A=
# CONFIG_BMA400 is not set=0A=
# CONFIG_BMC150_ACCEL is not set=0A=
# CONFIG_BMI088_ACCEL is not set=0A=
# CONFIG_DA280 is not set=0A=
# CONFIG_DA311 is not set=0A=
# CONFIG_DMARD06 is not set=0A=
# CONFIG_DMARD09 is not set=0A=
# CONFIG_DMARD10 is not set=0A=
# CONFIG_FXLS8962AF_I2C is not set=0A=
# CONFIG_FXLS8962AF_SPI is not set=0A=
CONFIG_HID_SENSOR_ACCEL_3D=3Dy=0A=
# CONFIG_IIO_ST_ACCEL_3AXIS is not set=0A=
# CONFIG_IIO_KX022A_SPI is not set=0A=
# CONFIG_IIO_KX022A_I2C is not set=0A=
# CONFIG_KXSD9 is not set=0A=
# CONFIG_KXCJK1013 is not set=0A=
# CONFIG_MC3230 is not set=0A=
# CONFIG_MMA7455_I2C is not set=0A=
# CONFIG_MMA7455_SPI is not set=0A=
# CONFIG_MMA7660 is not set=0A=
# CONFIG_MMA8452 is not set=0A=
# CONFIG_MMA9551 is not set=0A=
# CONFIG_MMA9553 is not set=0A=
# CONFIG_MSA311 is not set=0A=
# CONFIG_MXC4005 is not set=0A=
# CONFIG_MXC6255 is not set=0A=
# CONFIG_SCA3000 is not set=0A=
# CONFIG_SCA3300 is not set=0A=
# CONFIG_STK8312 is not set=0A=
# CONFIG_STK8BA50 is not set=0A=
# end of Accelerometers=0A=
=0A=
#=0A=
# Analog to digital converters=0A=
#=0A=
# CONFIG_AD4000 is not set=0A=
# CONFIG_AD4130 is not set=0A=
# CONFIG_AD4695 is not set=0A=
# CONFIG_AD7091R5 is not set=0A=
# CONFIG_AD7091R8 is not set=0A=
# CONFIG_AD7124 is not set=0A=
# CONFIG_AD7173 is not set=0A=
# CONFIG_AD7192 is not set=0A=
# CONFIG_AD7266 is not set=0A=
# CONFIG_AD7280 is not set=0A=
# CONFIG_AD7291 is not set=0A=
# CONFIG_AD7292 is not set=0A=
# CONFIG_AD7298 is not set=0A=
# CONFIG_AD7380 is not set=0A=
# CONFIG_AD7476 is not set=0A=
# CONFIG_AD7606_IFACE_PARALLEL is not set=0A=
# CONFIG_AD7606_IFACE_SPI is not set=0A=
# CONFIG_AD7766 is not set=0A=
# CONFIG_AD7768_1 is not set=0A=
# CONFIG_AD7779 is not set=0A=
# CONFIG_AD7780 is not set=0A=
# CONFIG_AD7791 is not set=0A=
# CONFIG_AD7793 is not set=0A=
# CONFIG_AD7887 is not set=0A=
# CONFIG_AD7923 is not set=0A=
# CONFIG_AD7944 is not set=0A=
# CONFIG_AD7949 is not set=0A=
# CONFIG_AD799X is not set=0A=
# CONFIG_AD9467 is not set=0A=
# CONFIG_CC10001_ADC is not set=0A=
CONFIG_DLN2_ADC=3Dy=0A=
# CONFIG_ENVELOPE_DETECTOR is not set=0A=
# CONFIG_GEHC_PMC_ADC is not set=0A=
# CONFIG_HI8435 is not set=0A=
# CONFIG_HX711 is not set=0A=
# CONFIG_INA2XX_ADC is not set=0A=
# CONFIG_LTC2309 is not set=0A=
# CONFIG_LTC2471 is not set=0A=
# CONFIG_LTC2485 is not set=0A=
# CONFIG_LTC2496 is not set=0A=
# CONFIG_LTC2497 is not set=0A=
# CONFIG_MAX1027 is not set=0A=
# CONFIG_MAX11100 is not set=0A=
# CONFIG_MAX1118 is not set=0A=
# CONFIG_MAX11205 is not set=0A=
# CONFIG_MAX11410 is not set=0A=
# CONFIG_MAX1241 is not set=0A=
# CONFIG_MAX1363 is not set=0A=
# CONFIG_MAX34408 is not set=0A=
# CONFIG_MAX9611 is not set=0A=
# CONFIG_MCP320X is not set=0A=
# CONFIG_MCP3422 is not set=0A=
# CONFIG_MCP3564 is not set=0A=
# CONFIG_MCP3911 is not set=0A=
# CONFIG_MEDIATEK_MT6360_ADC is not set=0A=
# CONFIG_MEDIATEK_MT6370_ADC is not set=0A=
# CONFIG_NAU7802 is not set=0A=
# CONFIG_PAC1921 is not set=0A=
# CONFIG_PAC1934 is not set=0A=
# CONFIG_RICHTEK_RTQ6056 is not set=0A=
# CONFIG_SD_ADC_MODULATOR is not set=0A=
# CONFIG_TI_ADC081C is not set=0A=
# CONFIG_TI_ADC0832 is not set=0A=
# CONFIG_TI_ADC084S021 is not set=0A=
# CONFIG_TI_ADC12138 is not set=0A=
# CONFIG_TI_ADC108S102 is not set=0A=
# CONFIG_TI_ADC128S052 is not set=0A=
# CONFIG_TI_ADC161S626 is not set=0A=
# CONFIG_TI_ADS1015 is not set=0A=
# CONFIG_TI_ADS1119 is not set=0A=
# CONFIG_TI_ADS7924 is not set=0A=
# CONFIG_TI_ADS1100 is not set=0A=
# CONFIG_TI_ADS1298 is not set=0A=
# CONFIG_TI_ADS7950 is not set=0A=
# CONFIG_TI_ADS8344 is not set=0A=
# CONFIG_TI_ADS8688 is not set=0A=
# CONFIG_TI_ADS124S08 is not set=0A=
# CONFIG_TI_ADS131E08 is not set=0A=
# CONFIG_TI_LMP92064 is not set=0A=
# CONFIG_TI_TLC4541 is not set=0A=
# CONFIG_TI_TSC2046 is not set=0A=
# CONFIG_TWL4030_MADC is not set=0A=
# CONFIG_TWL6030_GPADC is not set=0A=
# CONFIG_VF610_ADC is not set=0A=
CONFIG_VIPERBOARD_ADC=3Dy=0A=
# CONFIG_XILINX_XADC is not set=0A=
# end of Analog to digital converters=0A=
=0A=
#=0A=
# Analog to digital and digital to analog converters=0A=
#=0A=
# CONFIG_AD74115 is not set=0A=
# CONFIG_AD74413R is not set=0A=
# end of Analog to digital and digital to analog converters=0A=
=0A=
#=0A=
# Analog Front Ends=0A=
#=0A=
# CONFIG_IIO_RESCALE is not set=0A=
# end of Analog Front Ends=0A=
=0A=
#=0A=
# Amplifiers=0A=
#=0A=
# CONFIG_AD8366 is not set=0A=
# CONFIG_ADA4250 is not set=0A=
# CONFIG_HMC425 is not set=0A=
# end of Amplifiers=0A=
=0A=
#=0A=
# Capacitance to digital converters=0A=
#=0A=
# CONFIG_AD7150 is not set=0A=
# CONFIG_AD7746 is not set=0A=
# end of Capacitance to digital converters=0A=
=0A=
#=0A=
# Chemical Sensors=0A=
#=0A=
# CONFIG_AOSONG_AGS02MA is not set=0A=
# CONFIG_ATLAS_PH_SENSOR is not set=0A=
# CONFIG_ATLAS_EZO_SENSOR is not set=0A=
# CONFIG_BME680 is not set=0A=
# CONFIG_CCS811 is not set=0A=
# CONFIG_ENS160 is not set=0A=
# CONFIG_IAQCORE is not set=0A=
# CONFIG_PMS7003 is not set=0A=
# CONFIG_SCD30_CORE is not set=0A=
# CONFIG_SCD4X is not set=0A=
# CONFIG_SENSIRION_SGP30 is not set=0A=
# CONFIG_SENSIRION_SGP40 is not set=0A=
# CONFIG_SPS30_I2C is not set=0A=
# CONFIG_SPS30_SERIAL is not set=0A=
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set=0A=
# CONFIG_VZ89X is not set=0A=
# end of Chemical Sensors=0A=
=0A=
#=0A=
# Hid Sensor IIO Common=0A=
#=0A=
CONFIG_HID_SENSOR_IIO_COMMON=3Dy=0A=
CONFIG_HID_SENSOR_IIO_TRIGGER=3Dy=0A=
# end of Hid Sensor IIO Common=0A=
=0A=
#=0A=
# IIO SCMI Sensors=0A=
#=0A=
# end of IIO SCMI Sensors=0A=
=0A=
#=0A=
# SSP Sensor Common=0A=
#=0A=
# CONFIG_IIO_SSP_SENSORHUB is not set=0A=
# end of SSP Sensor Common=0A=
=0A=
#=0A=
# Digital to analog converters=0A=
#=0A=
# CONFIG_AD3552R_HS is not set=0A=
# CONFIG_AD3552R is not set=0A=
# CONFIG_AD5064 is not set=0A=
# CONFIG_AD5360 is not set=0A=
# CONFIG_AD5380 is not set=0A=
# CONFIG_AD5421 is not set=0A=
# CONFIG_AD5446 is not set=0A=
# CONFIG_AD5449 is not set=0A=
# CONFIG_AD5592R is not set=0A=
# CONFIG_AD5593R is not set=0A=
# CONFIG_AD5504 is not set=0A=
# CONFIG_AD5624R_SPI is not set=0A=
# CONFIG_AD9739A is not set=0A=
# CONFIG_LTC2688 is not set=0A=
# CONFIG_AD5686_SPI is not set=0A=
# CONFIG_AD5696_I2C is not set=0A=
# CONFIG_AD5755 is not set=0A=
# CONFIG_AD5758 is not set=0A=
# CONFIG_AD5761 is not set=0A=
# CONFIG_AD5764 is not set=0A=
# CONFIG_AD5766 is not set=0A=
# CONFIG_AD5770R is not set=0A=
# CONFIG_AD5791 is not set=0A=
# CONFIG_AD7293 is not set=0A=
# CONFIG_AD7303 is not set=0A=
# CONFIG_AD8460 is not set=0A=
# CONFIG_AD8801 is not set=0A=
# CONFIG_DPOT_DAC is not set=0A=
# CONFIG_DS4424 is not set=0A=
# CONFIG_LTC1660 is not set=0A=
# CONFIG_LTC2632 is not set=0A=
# CONFIG_LTC2664 is not set=0A=
# CONFIG_M62332 is not set=0A=
# CONFIG_MAX517 is not set=0A=
# CONFIG_MAX5522 is not set=0A=
# CONFIG_MAX5821 is not set=0A=
# CONFIG_MCP4725 is not set=0A=
# CONFIG_MCP4728 is not set=0A=
# CONFIG_MCP4821 is not set=0A=
# CONFIG_MCP4922 is not set=0A=
# CONFIG_TI_DAC082S085 is not set=0A=
# CONFIG_TI_DAC5571 is not set=0A=
# CONFIG_TI_DAC7311 is not set=0A=
# CONFIG_TI_DAC7612 is not set=0A=
# CONFIG_VF610_DAC is not set=0A=
# end of Digital to analog converters=0A=
=0A=
#=0A=
# IIO dummy driver=0A=
#=0A=
# end of IIO dummy driver=0A=
=0A=
#=0A=
# Filters=0A=
#=0A=
# CONFIG_ADMV8818 is not set=0A=
# end of Filters=0A=
=0A=
#=0A=
# Frequency Synthesizers DDS/PLL=0A=
#=0A=
=0A=
#=0A=
# Clock Generator/Distribution=0A=
#=0A=
# CONFIG_AD9523 is not set=0A=
# end of Clock Generator/Distribution=0A=
=0A=
#=0A=
# Phase-Locked Loop (PLL) frequency synthesizers=0A=
#=0A=
# CONFIG_ADF4350 is not set=0A=
# CONFIG_ADF4371 is not set=0A=
# CONFIG_ADF4377 is not set=0A=
# CONFIG_ADMFM2000 is not set=0A=
# CONFIG_ADMV1013 is not set=0A=
# CONFIG_ADMV1014 is not set=0A=
# CONFIG_ADMV4420 is not set=0A=
# CONFIG_ADRF6780 is not set=0A=
# end of Phase-Locked Loop (PLL) frequency synthesizers=0A=
# end of Frequency Synthesizers DDS/PLL=0A=
=0A=
#=0A=
# Digital gyroscope sensors=0A=
#=0A=
# CONFIG_ADIS16080 is not set=0A=
# CONFIG_ADIS16130 is not set=0A=
# CONFIG_ADIS16136 is not set=0A=
# CONFIG_ADIS16260 is not set=0A=
# CONFIG_ADXRS290 is not set=0A=
# CONFIG_ADXRS450 is not set=0A=
# CONFIG_BMG160 is not set=0A=
# CONFIG_FXAS21002C is not set=0A=
CONFIG_HID_SENSOR_GYRO_3D=3Dy=0A=
# CONFIG_MPU3050_I2C is not set=0A=
# CONFIG_IIO_ST_GYRO_3AXIS is not set=0A=
# CONFIG_ITG3200 is not set=0A=
# end of Digital gyroscope sensors=0A=
=0A=
#=0A=
# Health Sensors=0A=
#=0A=
=0A=
#=0A=
# Heart Rate Monitors=0A=
#=0A=
# CONFIG_AFE4403 is not set=0A=
# CONFIG_AFE4404 is not set=0A=
# CONFIG_MAX30100 is not set=0A=
# CONFIG_MAX30102 is not set=0A=
# end of Heart Rate Monitors=0A=
# end of Health Sensors=0A=
=0A=
#=0A=
# Humidity sensors=0A=
#=0A=
# CONFIG_AM2315 is not set=0A=
# CONFIG_DHT11 is not set=0A=
# CONFIG_ENS210 is not set=0A=
# CONFIG_HDC100X is not set=0A=
# CONFIG_HDC2010 is not set=0A=
# CONFIG_HDC3020 is not set=0A=
CONFIG_HID_SENSOR_HUMIDITY=3Dy=0A=
# CONFIG_HTS221 is not set=0A=
# CONFIG_HTU21 is not set=0A=
# CONFIG_SI7005 is not set=0A=
# CONFIG_SI7020 is not set=0A=
# end of Humidity sensors=0A=
=0A=
#=0A=
# Inertial measurement units=0A=
#=0A=
# CONFIG_ADIS16400 is not set=0A=
# CONFIG_ADIS16460 is not set=0A=
# CONFIG_ADIS16475 is not set=0A=
# CONFIG_ADIS16480 is not set=0A=
# CONFIG_BMI160_I2C is not set=0A=
# CONFIG_BMI160_SPI is not set=0A=
# CONFIG_BMI270_I2C is not set=0A=
# CONFIG_BMI270_SPI is not set=0A=
# CONFIG_BMI323_I2C is not set=0A=
# CONFIG_BMI323_SPI is not set=0A=
# CONFIG_BOSCH_BNO055_SERIAL is not set=0A=
# CONFIG_BOSCH_BNO055_I2C is not set=0A=
# CONFIG_FXOS8700_I2C is not set=0A=
# CONFIG_FXOS8700_SPI is not set=0A=
# CONFIG_KMX61 is not set=0A=
# CONFIG_INV_ICM42600_I2C is not set=0A=
# CONFIG_INV_ICM42600_SPI is not set=0A=
# CONFIG_INV_MPU6050_I2C is not set=0A=
# CONFIG_INV_MPU6050_SPI is not set=0A=
# CONFIG_SMI240 is not set=0A=
# CONFIG_IIO_ST_LSM6DSX is not set=0A=
# CONFIG_IIO_ST_LSM9DS0 is not set=0A=
# end of Inertial measurement units=0A=
=0A=
#=0A=
# Light sensors=0A=
#=0A=
# CONFIG_ACPI_ALS is not set=0A=
# CONFIG_ADJD_S311 is not set=0A=
# CONFIG_ADUX1020 is not set=0A=
# CONFIG_AL3010 is not set=0A=
# CONFIG_AL3320A is not set=0A=
# CONFIG_APDS9300 is not set=0A=
# CONFIG_APDS9306 is not set=0A=
# CONFIG_APDS9960 is not set=0A=
# CONFIG_AS73211 is not set=0A=
# CONFIG_BH1745 is not set=0A=
# CONFIG_BH1750 is not set=0A=
# CONFIG_BH1780 is not set=0A=
# CONFIG_CM32181 is not set=0A=
# CONFIG_CM3232 is not set=0A=
# CONFIG_CM3323 is not set=0A=
# CONFIG_CM3605 is not set=0A=
# CONFIG_CM36651 is not set=0A=
# CONFIG_GP2AP002 is not set=0A=
# CONFIG_GP2AP020A00F is not set=0A=
# CONFIG_SENSORS_ISL29018 is not set=0A=
# CONFIG_SENSORS_ISL29028 is not set=0A=
# CONFIG_ISL29125 is not set=0A=
# CONFIG_ISL76682 is not set=0A=
CONFIG_HID_SENSOR_ALS=3Dy=0A=
CONFIG_HID_SENSOR_PROX=3Dy=0A=
# CONFIG_JSA1212 is not set=0A=
# CONFIG_ROHM_BU27008 is not set=0A=
# CONFIG_ROHM_BU27034 is not set=0A=
# CONFIG_RPR0521 is not set=0A=
# CONFIG_LTR390 is not set=0A=
# CONFIG_LTR501 is not set=0A=
# CONFIG_LTRF216A is not set=0A=
# CONFIG_LV0104CS is not set=0A=
# CONFIG_MAX44000 is not set=0A=
# CONFIG_MAX44009 is not set=0A=
# CONFIG_NOA1305 is not set=0A=
# CONFIG_OPT3001 is not set=0A=
# CONFIG_OPT4001 is not set=0A=
# CONFIG_PA12203001 is not set=0A=
# CONFIG_SI1133 is not set=0A=
# CONFIG_SI1145 is not set=0A=
# CONFIG_STK3310 is not set=0A=
# CONFIG_ST_UVIS25 is not set=0A=
# CONFIG_TCS3414 is not set=0A=
# CONFIG_TCS3472 is not set=0A=
# CONFIG_SENSORS_TSL2563 is not set=0A=
# CONFIG_TSL2583 is not set=0A=
# CONFIG_TSL2591 is not set=0A=
# CONFIG_TSL2772 is not set=0A=
# CONFIG_TSL4531 is not set=0A=
# CONFIG_US5182D is not set=0A=
# CONFIG_VCNL4000 is not set=0A=
# CONFIG_VCNL4035 is not set=0A=
# CONFIG_VEML3235 is not set=0A=
# CONFIG_VEML6030 is not set=0A=
# CONFIG_VEML6040 is not set=0A=
# CONFIG_VEML6070 is not set=0A=
# CONFIG_VEML6075 is not set=0A=
# CONFIG_VL6180 is not set=0A=
# CONFIG_ZOPT2201 is not set=0A=
# end of Light sensors=0A=
=0A=
#=0A=
# Magnetometer sensors=0A=
#=0A=
# CONFIG_AF8133J is not set=0A=
# CONFIG_AK8974 is not set=0A=
# CONFIG_AK8975 is not set=0A=
# CONFIG_AK09911 is not set=0A=
# CONFIG_ALS31300 is not set=0A=
# CONFIG_BMC150_MAGN_I2C is not set=0A=
# CONFIG_BMC150_MAGN_SPI is not set=0A=
# CONFIG_MAG3110 is not set=0A=
CONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dy=0A=
# CONFIG_MMC35240 is not set=0A=
# CONFIG_IIO_ST_MAGN_3AXIS is not set=0A=
# CONFIG_SENSORS_HMC5843_I2C is not set=0A=
# CONFIG_SENSORS_HMC5843_SPI is not set=0A=
# CONFIG_SENSORS_RM3100_I2C is not set=0A=
# CONFIG_SENSORS_RM3100_SPI is not set=0A=
# CONFIG_TI_TMAG5273 is not set=0A=
# CONFIG_YAMAHA_YAS530 is not set=0A=
# end of Magnetometer sensors=0A=
=0A=
#=0A=
# Multiplexers=0A=
#=0A=
# CONFIG_IIO_MUX is not set=0A=
# end of Multiplexers=0A=
=0A=
#=0A=
# Inclinometer sensors=0A=
#=0A=
CONFIG_HID_SENSOR_INCLINOMETER_3D=3Dy=0A=
CONFIG_HID_SENSOR_DEVICE_ROTATION=3Dy=0A=
# end of Inclinometer sensors=0A=
=0A=
#=0A=
# Triggers - standalone=0A=
#=0A=
# CONFIG_IIO_INTERRUPT_TRIGGER is not set=0A=
# CONFIG_IIO_SYSFS_TRIGGER is not set=0A=
# end of Triggers - standalone=0A=
=0A=
#=0A=
# Linear and angular position sensors=0A=
#=0A=
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=3Dy=0A=
# end of Linear and angular position sensors=0A=
=0A=
#=0A=
# Digital potentiometers=0A=
#=0A=
# CONFIG_AD5110 is not set=0A=
# CONFIG_AD5272 is not set=0A=
# CONFIG_DS1803 is not set=0A=
# CONFIG_MAX5432 is not set=0A=
# CONFIG_MAX5481 is not set=0A=
# CONFIG_MAX5487 is not set=0A=
# CONFIG_MCP4018 is not set=0A=
# CONFIG_MCP4131 is not set=0A=
# CONFIG_MCP4531 is not set=0A=
# CONFIG_MCP41010 is not set=0A=
# CONFIG_TPL0102 is not set=0A=
# CONFIG_X9250 is not set=0A=
# end of Digital potentiometers=0A=
=0A=
#=0A=
# Digital potentiostats=0A=
#=0A=
# CONFIG_LMP91000 is not set=0A=
# end of Digital potentiostats=0A=
=0A=
#=0A=
# Pressure sensors=0A=
#=0A=
# CONFIG_ABP060MG is not set=0A=
# CONFIG_ROHM_BM1390 is not set=0A=
# CONFIG_BMP280 is not set=0A=
# CONFIG_DLHL60D is not set=0A=
# CONFIG_DPS310 is not set=0A=
CONFIG_HID_SENSOR_PRESS=3Dy=0A=
# CONFIG_HP03 is not set=0A=
# CONFIG_HSC030PA is not set=0A=
# CONFIG_ICP10100 is not set=0A=
# CONFIG_MPL115_I2C is not set=0A=
# CONFIG_MPL115_SPI is not set=0A=
# CONFIG_MPL3115 is not set=0A=
# CONFIG_MPRLS0025PA is not set=0A=
# CONFIG_MS5611 is not set=0A=
# CONFIG_MS5637 is not set=0A=
# CONFIG_SDP500 is not set=0A=
# CONFIG_IIO_ST_PRESS is not set=0A=
# CONFIG_T5403 is not set=0A=
# CONFIG_HP206C is not set=0A=
# CONFIG_ZPA2326 is not set=0A=
# end of Pressure sensors=0A=
=0A=
#=0A=
# Lightning sensors=0A=
#=0A=
# CONFIG_AS3935 is not set=0A=
# end of Lightning sensors=0A=
=0A=
#=0A=
# Proximity and distance sensors=0A=
#=0A=
# CONFIG_HX9023S is not set=0A=
# CONFIG_IRSD200 is not set=0A=
# CONFIG_ISL29501 is not set=0A=
# CONFIG_LIDAR_LITE_V2 is not set=0A=
# CONFIG_MB1232 is not set=0A=
# CONFIG_PING is not set=0A=
# CONFIG_RFD77402 is not set=0A=
# CONFIG_SRF04 is not set=0A=
# CONFIG_SX9310 is not set=0A=
# CONFIG_SX9324 is not set=0A=
# CONFIG_SX9360 is not set=0A=
# CONFIG_SX9500 is not set=0A=
# CONFIG_SRF08 is not set=0A=
# CONFIG_VCNL3020 is not set=0A=
# CONFIG_VL53L0X_I2C is not set=0A=
# CONFIG_AW96103 is not set=0A=
# end of Proximity and distance sensors=0A=
=0A=
#=0A=
# Resolver to digital converters=0A=
#=0A=
# CONFIG_AD2S90 is not set=0A=
# CONFIG_AD2S1200 is not set=0A=
# CONFIG_AD2S1210 is not set=0A=
# end of Resolver to digital converters=0A=
=0A=
#=0A=
# Temperature sensors=0A=
#=0A=
# CONFIG_LTC2983 is not set=0A=
# CONFIG_MAXIM_THERMOCOUPLE is not set=0A=
CONFIG_HID_SENSOR_TEMP=3Dy=0A=
# CONFIG_MLX90614 is not set=0A=
# CONFIG_MLX90632 is not set=0A=
# CONFIG_MLX90635 is not set=0A=
# CONFIG_TMP006 is not set=0A=
# CONFIG_TMP007 is not set=0A=
# CONFIG_TMP117 is not set=0A=
# CONFIG_TSYS01 is not set=0A=
# CONFIG_TSYS02D is not set=0A=
# CONFIG_MAX30208 is not set=0A=
# CONFIG_MAX31856 is not set=0A=
# CONFIG_MAX31865 is not set=0A=
# CONFIG_MCP9600 is not set=0A=
# end of Temperature sensors=0A=
=0A=
# CONFIG_NTB is not set=0A=
# CONFIG_PWM is not set=0A=
=0A=
#=0A=
# IRQ chip support=0A=
#=0A=
CONFIG_IRQCHIP=3Dy=0A=
# CONFIG_AL_FIC is not set=0A=
# CONFIG_LAN966X_OIC is not set=0A=
# CONFIG_XILINX_INTC is not set=0A=
# end of IRQ chip support=0A=
=0A=
# CONFIG_IPACK_BUS is not set=0A=
CONFIG_RESET_CONTROLLER=3Dy=0A=
# CONFIG_RESET_GPIO is not set=0A=
# CONFIG_RESET_INTEL_GW is not set=0A=
# CONFIG_RESET_SIMPLE is not set=0A=
# CONFIG_RESET_TI_SYSCON is not set=0A=
# CONFIG_RESET_TI_TPS380X is not set=0A=
=0A=
#=0A=
# PHY Subsystem=0A=
#=0A=
CONFIG_GENERIC_PHY=3Dy=0A=
CONFIG_USB_LGM_PHY=3Dy=0A=
# CONFIG_PHY_CAN_TRANSCEIVER is not set=0A=
# CONFIG_PHY_NXP_PTN3222 is not set=0A=
=0A=
#=0A=
# PHY drivers for Broadcom platforms=0A=
#=0A=
# CONFIG_BCM_KONA_USB2_PHY is not set=0A=
# end of PHY drivers for Broadcom platforms=0A=
=0A=
# CONFIG_PHY_CADENCE_TORRENT is not set=0A=
# CONFIG_PHY_CADENCE_DPHY is not set=0A=
# CONFIG_PHY_CADENCE_DPHY_RX is not set=0A=
# CONFIG_PHY_CADENCE_SIERRA is not set=0A=
# CONFIG_PHY_CADENCE_SALVO is not set=0A=
# CONFIG_PHY_PXA_28NM_HSIC is not set=0A=
# CONFIG_PHY_PXA_28NM_USB2 is not set=0A=
# CONFIG_PHY_LAN966X_SERDES is not set=0A=
CONFIG_PHY_CPCAP_USB=3Dy=0A=
# CONFIG_PHY_MAPPHONE_MDM6600 is not set=0A=
# CONFIG_PHY_OCELOT_SERDES is not set=0A=
CONFIG_PHY_QCOM_USB_HS=3Dy=0A=
CONFIG_PHY_QCOM_USB_HSIC=3Dy=0A=
CONFIG_PHY_SAMSUNG_USB2=3Dy=0A=
CONFIG_PHY_TUSB1210=3Dy=0A=
# CONFIG_PHY_INTEL_LGM_COMBO is not set=0A=
# CONFIG_PHY_INTEL_LGM_EMMC is not set=0A=
# end of PHY Subsystem=0A=
=0A=
# CONFIG_POWERCAP is not set=0A=
# CONFIG_MCB is not set=0A=
=0A=
#=0A=
# Performance monitor support=0A=
#=0A=
# CONFIG_DWC_PCIE_PMU is not set=0A=
# end of Performance monitor support=0A=
=0A=
CONFIG_RAS=3Dy=0A=
CONFIG_USB4=3Dy=0A=
# CONFIG_USB4_DEBUGFS_WRITE is not set=0A=
# CONFIG_USB4_DMA_TEST is not set=0A=
=0A=
#=0A=
# Android=0A=
#=0A=
CONFIG_ANDROID_BINDER_IPC=3Dy=0A=
CONFIG_ANDROID_BINDERFS=3Dy=0A=
CONFIG_ANDROID_BINDER_DEVICES=3D"binder0,binder1"=0A=
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set=0A=
# end of Android=0A=
=0A=
CONFIG_LIBNVDIMM=3Dy=0A=
CONFIG_BLK_DEV_PMEM=3Dy=0A=
CONFIG_ND_CLAIM=3Dy=0A=
CONFIG_ND_BTT=3Dy=0A=
CONFIG_BTT=3Dy=0A=
CONFIG_ND_PFN=3Dy=0A=
CONFIG_NVDIMM_PFN=3Dy=0A=
CONFIG_NVDIMM_DAX=3Dy=0A=
CONFIG_OF_PMEM=3Dy=0A=
CONFIG_NVDIMM_KEYS=3Dy=0A=
# CONFIG_NVDIMM_SECURITY_TEST is not set=0A=
CONFIG_DAX=3Dy=0A=
CONFIG_DEV_DAX=3Dy=0A=
# CONFIG_DEV_DAX_PMEM is not set=0A=
# CONFIG_DEV_DAX_KMEM is not set=0A=
CONFIG_NVMEM=3Dy=0A=
CONFIG_NVMEM_SYSFS=3Dy=0A=
CONFIG_NVMEM_LAYOUTS=3Dy=0A=
=0A=
#=0A=
# Layout Types=0A=
#=0A=
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set=0A=
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set=0A=
# CONFIG_NVMEM_LAYOUT_U_BOOT_ENV is not set=0A=
# end of Layout Types=0A=
=0A=
# CONFIG_NVMEM_RMEM is not set=0A=
# CONFIG_NVMEM_U_BOOT_ENV is not set=0A=
=0A=
#=0A=
# HW tracing support=0A=
#=0A=
# CONFIG_STM is not set=0A=
# CONFIG_INTEL_TH is not set=0A=
# end of HW tracing support=0A=
=0A=
# CONFIG_FPGA is not set=0A=
# CONFIG_FSI is not set=0A=
CONFIG_TEE=3Dy=0A=
# CONFIG_SIOX is not set=0A=
# CONFIG_SLIMBUS is not set=0A=
# CONFIG_INTERCONNECT is not set=0A=
CONFIG_COUNTER=3Dy=0A=
# CONFIG_INTEL_QEP is not set=0A=
# CONFIG_INTERRUPT_CNT is not set=0A=
CONFIG_MOST=3Dy=0A=
CONFIG_MOST_USB_HDM=3Dy=0A=
# CONFIG_MOST_CDEV is not set=0A=
# CONFIG_MOST_SND is not set=0A=
# CONFIG_PECI is not set=0A=
# CONFIG_HTE is not set=0A=
# end of Device Drivers=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_DCACHE_WORD_ACCESS=3Dy=0A=
CONFIG_VALIDATE_FS_PARSER=3Dy=0A=
CONFIG_FS_IOMAP=3Dy=0A=
CONFIG_FS_STACK=3Dy=0A=
CONFIG_BUFFER_HEAD=3Dy=0A=
CONFIG_LEGACY_DIRECT_IO=3Dy=0A=
# CONFIG_EXT2_FS is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_POSIX_ACL=3Dy=0A=
CONFIG_EXT3_FS_SECURITY=3Dy=0A=
CONFIG_EXT4_FS=3Dy=0A=
CONFIG_EXT4_USE_FOR_EXT2=3Dy=0A=
CONFIG_EXT4_FS_POSIX_ACL=3Dy=0A=
CONFIG_EXT4_FS_SECURITY=3Dy=0A=
# CONFIG_EXT4_DEBUG is not set=0A=
CONFIG_JBD2=3Dy=0A=
# CONFIG_JBD2_DEBUG is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
CONFIG_JFS_FS=3Dy=0A=
CONFIG_JFS_POSIX_ACL=3Dy=0A=
CONFIG_JFS_SECURITY=3Dy=0A=
CONFIG_JFS_DEBUG=3Dy=0A=
# CONFIG_JFS_STATISTICS is not set=0A=
CONFIG_XFS_FS=3Dy=0A=
# CONFIG_XFS_SUPPORT_V4 is not set=0A=
# CONFIG_XFS_SUPPORT_ASCII_CI is not set=0A=
CONFIG_XFS_QUOTA=3Dy=0A=
CONFIG_XFS_POSIX_ACL=3Dy=0A=
CONFIG_XFS_RT=3Dy=0A=
# CONFIG_XFS_ONLINE_SCRUB is not set=0A=
# CONFIG_XFS_WARN is not set=0A=
# CONFIG_XFS_DEBUG is not set=0A=
CONFIG_GFS2_FS=3Dy=0A=
CONFIG_GFS2_FS_LOCKING_DLM=3Dy=0A=
CONFIG_OCFS2_FS=3Dy=0A=
CONFIG_OCFS2_FS_O2CB=3Dy=0A=
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dy=0A=
CONFIG_OCFS2_FS_STATS=3Dy=0A=
# CONFIG_OCFS2_DEBUG_MASKLOG is not set=0A=
CONFIG_OCFS2_DEBUG_FS=3Dy=0A=
CONFIG_BTRFS_FS=3Dy=0A=
CONFIG_BTRFS_FS_POSIX_ACL=3Dy=0A=
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set=0A=
# CONFIG_BTRFS_DEBUG is not set=0A=
CONFIG_BTRFS_ASSERT=3Dy=0A=
# CONFIG_BTRFS_EXPERIMENTAL is not set=0A=
CONFIG_BTRFS_FS_REF_VERIFY=3Dy=0A=
CONFIG_NILFS2_FS=3Dy=0A=
CONFIG_F2FS_FS=3Dy=0A=
CONFIG_F2FS_STAT_FS=3Dy=0A=
CONFIG_F2FS_FS_XATTR=3Dy=0A=
CONFIG_F2FS_FS_POSIX_ACL=3Dy=0A=
CONFIG_F2FS_FS_SECURITY=3Dy=0A=
CONFIG_F2FS_CHECK_FS=3Dy=0A=
CONFIG_F2FS_FAULT_INJECTION=3Dy=0A=
CONFIG_F2FS_FS_COMPRESSION=3Dy=0A=
CONFIG_F2FS_FS_LZO=3Dy=0A=
CONFIG_F2FS_FS_LZORLE=3Dy=0A=
CONFIG_F2FS_FS_LZ4=3Dy=0A=
CONFIG_F2FS_FS_LZ4HC=3Dy=0A=
CONFIG_F2FS_FS_ZSTD=3Dy=0A=
# CONFIG_F2FS_IOSTAT is not set=0A=
# CONFIG_F2FS_UNFAIR_RWSEM is not set=0A=
CONFIG_BCACHEFS_FS=3Dy=0A=
CONFIG_BCACHEFS_QUOTA=3Dy=0A=
CONFIG_BCACHEFS_ERASURE_CODING=3Dy=0A=
CONFIG_BCACHEFS_POSIX_ACL=3Dy=0A=
CONFIG_BCACHEFS_DEBUG=3Dy=0A=
# CONFIG_BCACHEFS_TESTS is not set=0A=
# CONFIG_BCACHEFS_LOCK_TIME_STATS is not set=0A=
# CONFIG_BCACHEFS_NO_LATENCY_ACCT is not set=0A=
CONFIG_BCACHEFS_SIX_OPTIMISTIC_SPIN=3Dy=0A=
# CONFIG_BCACHEFS_PATH_TRACEPOINTS is not set=0A=
CONFIG_ZONEFS_FS=3Dy=0A=
CONFIG_FS_DAX=3Dy=0A=
CONFIG_FS_DAX_PMD=3Dy=0A=
CONFIG_FS_POSIX_ACL=3Dy=0A=
CONFIG_EXPORTFS=3Dy=0A=
CONFIG_EXPORTFS_BLOCK_OPS=3Dy=0A=
CONFIG_FILE_LOCKING=3Dy=0A=
CONFIG_FS_ENCRYPTION=3Dy=0A=
CONFIG_FS_ENCRYPTION_ALGS=3Dy=0A=
# CONFIG_FS_ENCRYPTION_INLINE_CRYPT is not set=0A=
CONFIG_FS_VERITY=3Dy=0A=
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dy=0A=
CONFIG_FSNOTIFY=3Dy=0A=
CONFIG_DNOTIFY=3Dy=0A=
CONFIG_INOTIFY_USER=3Dy=0A=
CONFIG_FANOTIFY=3Dy=0A=
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy=0A=
CONFIG_QUOTA=3Dy=0A=
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy=0A=
# CONFIG_QUOTA_DEBUG is not set=0A=
CONFIG_QUOTA_TREE=3Dy=0A=
# CONFIG_QFMT_V1 is not set=0A=
CONFIG_QFMT_V2=3Dy=0A=
CONFIG_QUOTACTL=3Dy=0A=
CONFIG_AUTOFS_FS=3Dy=0A=
CONFIG_FUSE_FS=3Dy=0A=
CONFIG_CUSE=3Dy=0A=
CONFIG_VIRTIO_FS=3Dy=0A=
CONFIG_FUSE_DAX=3Dy=0A=
# CONFIG_FUSE_PASSTHROUGH is not set=0A=
CONFIG_OVERLAY_FS=3Dy=0A=
CONFIG_OVERLAY_FS_REDIRECT_DIR=3Dy=0A=
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=3Dy=0A=
CONFIG_OVERLAY_FS_INDEX=3Dy=0A=
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set=0A=
# CONFIG_OVERLAY_FS_XINO_AUTO is not set=0A=
# CONFIG_OVERLAY_FS_METACOPY is not set=0A=
CONFIG_OVERLAY_FS_DEBUG=3Dy=0A=
=0A=
#=0A=
# Caches=0A=
#=0A=
CONFIG_NETFS_SUPPORT=3Dy=0A=
# CONFIG_NETFS_STATS is not set=0A=
# CONFIG_NETFS_DEBUG is not set=0A=
CONFIG_FSCACHE=3Dy=0A=
# CONFIG_FSCACHE_STATS is not set=0A=
CONFIG_CACHEFILES=3Dy=0A=
# CONFIG_CACHEFILES_DEBUG is not set=0A=
# CONFIG_CACHEFILES_ERROR_INJECTION is not set=0A=
# CONFIG_CACHEFILES_ONDEMAND is not set=0A=
# end of Caches=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
CONFIG_UDF_FS=3Dy=0A=
# end of CD-ROM/DVD Filesystems=0A=
=0A=
#=0A=
# DOS/FAT/EXFAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dy=0A=
CONFIG_MSDOS_FS=3Dy=0A=
CONFIG_VFAT_FS=3Dy=0A=
CONFIG_FAT_DEFAULT_CODEPAGE=3D437=0A=
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"=0A=
# CONFIG_FAT_DEFAULT_UTF8 is not set=0A=
CONFIG_EXFAT_FS=3Dy=0A=
CONFIG_EXFAT_DEFAULT_IOCHARSET=3D"utf8"=0A=
CONFIG_NTFS3_FS=3Dy=0A=
# CONFIG_NTFS3_64BIT_CLUSTER is not set=0A=
CONFIG_NTFS3_LZX_XPRESS=3Dy=0A=
CONFIG_NTFS3_FS_POSIX_ACL=3Dy=0A=
# CONFIG_NTFS_FS is not set=0A=
# end of DOS/FAT/EXFAT/NT Filesystems=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_PROC_VMCORE=3Dy=0A=
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set=0A=
CONFIG_PROC_SYSCTL=3Dy=0A=
CONFIG_PROC_PAGE_MONITOR=3Dy=0A=
CONFIG_PROC_CHILDREN=3Dy=0A=
CONFIG_PROC_PID_ARCH_STATUS=3Dy=0A=
CONFIG_KERNFS=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_TMPFS_POSIX_ACL=3Dy=0A=
CONFIG_TMPFS_XATTR=3Dy=0A=
# CONFIG_TMPFS_INODE64 is not set=0A=
CONFIG_TMPFS_QUOTA=3Dy=0A=
CONFIG_HUGETLBFS=3Dy=0A=
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set=0A=
CONFIG_HUGETLB_PAGE=3Dy=0A=
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy=0A=
CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING=3Dy=0A=
CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy=0A=
CONFIG_CONFIGFS_FS=3Dy=0A=
# end of Pseudo filesystems=0A=
=0A=
CONFIG_MISC_FILESYSTEMS=3Dy=0A=
CONFIG_ORANGEFS_FS=3Dy=0A=
CONFIG_ADFS_FS=3Dy=0A=
# CONFIG_ADFS_FS_RW is not set=0A=
CONFIG_AFFS_FS=3Dy=0A=
CONFIG_ECRYPT_FS=3Dy=0A=
CONFIG_ECRYPT_FS_MESSAGING=3Dy=0A=
CONFIG_HFS_FS=3Dy=0A=
CONFIG_HFSPLUS_FS=3Dy=0A=
CONFIG_BEFS_FS=3Dy=0A=
# CONFIG_BEFS_DEBUG is not set=0A=
CONFIG_BFS_FS=3Dy=0A=
CONFIG_EFS_FS=3Dy=0A=
CONFIG_JFFS2_FS=3Dy=0A=
CONFIG_JFFS2_FS_DEBUG=3D0=0A=
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy=0A=
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set=0A=
CONFIG_JFFS2_SUMMARY=3Dy=0A=
CONFIG_JFFS2_FS_XATTR=3Dy=0A=
CONFIG_JFFS2_FS_POSIX_ACL=3Dy=0A=
CONFIG_JFFS2_FS_SECURITY=3Dy=0A=
CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy=0A=
CONFIG_JFFS2_ZLIB=3Dy=0A=
CONFIG_JFFS2_LZO=3Dy=0A=
CONFIG_JFFS2_RTIME=3Dy=0A=
CONFIG_JFFS2_RUBIN=3Dy=0A=
# CONFIG_JFFS2_CMODE_NONE is not set=0A=
CONFIG_JFFS2_CMODE_PRIORITY=3Dy=0A=
# CONFIG_JFFS2_CMODE_SIZE is not set=0A=
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set=0A=
CONFIG_UBIFS_FS=3Dy=0A=
CONFIG_UBIFS_FS_ADVANCED_COMPR=3Dy=0A=
CONFIG_UBIFS_FS_LZO=3Dy=0A=
CONFIG_UBIFS_FS_ZLIB=3Dy=0A=
CONFIG_UBIFS_FS_ZSTD=3Dy=0A=
CONFIG_UBIFS_ATIME_SUPPORT=3Dy=0A=
CONFIG_UBIFS_FS_XATTR=3Dy=0A=
CONFIG_UBIFS_FS_SECURITY=3Dy=0A=
# CONFIG_UBIFS_FS_AUTHENTICATION is not set=0A=
CONFIG_CRAMFS=3Dy=0A=
CONFIG_CRAMFS_BLOCKDEV=3Dy=0A=
CONFIG_CRAMFS_MTD=3Dy=0A=
CONFIG_SQUASHFS=3Dy=0A=
# CONFIG_SQUASHFS_FILE_CACHE is not set=0A=
CONFIG_SQUASHFS_FILE_DIRECT=3Dy=0A=
CONFIG_SQUASHFS_DECOMP_MULTI=3Dy=0A=
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set=0A=
# CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE is not set=0A=
CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI=3Dy=0A=
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set=0A=
# CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS is not set=0A=
CONFIG_SQUASHFS_XATTR=3Dy=0A=
CONFIG_SQUASHFS_ZLIB=3Dy=0A=
CONFIG_SQUASHFS_LZ4=3Dy=0A=
CONFIG_SQUASHFS_LZO=3Dy=0A=
CONFIG_SQUASHFS_XZ=3Dy=0A=
CONFIG_SQUASHFS_ZSTD=3Dy=0A=
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=3Dy=0A=
# CONFIG_SQUASHFS_EMBEDDED is not set=0A=
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3=0A=
CONFIG_VXFS_FS=3Dy=0A=
CONFIG_MINIX_FS=3Dy=0A=
CONFIG_OMFS_FS=3Dy=0A=
CONFIG_HPFS_FS=3Dy=0A=
CONFIG_QNX4FS_FS=3Dy=0A=
CONFIG_QNX6FS_FS=3Dy=0A=
# CONFIG_QNX6FS_DEBUG is not set=0A=
CONFIG_ROMFS_FS=3Dy=0A=
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set=0A=
# CONFIG_ROMFS_BACKED_BY_MTD is not set=0A=
CONFIG_ROMFS_BACKED_BY_BOTH=3Dy=0A=
CONFIG_ROMFS_ON_BLOCK=3Dy=0A=
CONFIG_ROMFS_ON_MTD=3Dy=0A=
CONFIG_PSTORE=3Dy=0A=
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=3D10240=0A=
CONFIG_PSTORE_COMPRESS=3Dy=0A=
# CONFIG_PSTORE_CONSOLE is not set=0A=
# CONFIG_PSTORE_PMSG is not set=0A=
# CONFIG_PSTORE_RAM is not set=0A=
# CONFIG_PSTORE_BLK is not set=0A=
CONFIG_SYSV_FS=3Dy=0A=
CONFIG_UFS_FS=3Dy=0A=
CONFIG_UFS_FS_WRITE=3Dy=0A=
# CONFIG_UFS_DEBUG is not set=0A=
CONFIG_EROFS_FS=3Dy=0A=
# CONFIG_EROFS_FS_DEBUG is not set=0A=
CONFIG_EROFS_FS_XATTR=3Dy=0A=
CONFIG_EROFS_FS_POSIX_ACL=3Dy=0A=
CONFIG_EROFS_FS_SECURITY=3Dy=0A=
CONFIG_EROFS_FS_BACKED_BY_FILE=3Dy=0A=
CONFIG_EROFS_FS_ZIP=3Dy=0A=
# CONFIG_EROFS_FS_ZIP_LZMA is not set=0A=
# CONFIG_EROFS_FS_ZIP_DEFLATE is not set=0A=
# CONFIG_EROFS_FS_ZIP_ZSTD is not set=0A=
# CONFIG_EROFS_FS_ONDEMAND is not set=0A=
# CONFIG_EROFS_FS_PCPU_KTHREAD is not set=0A=
CONFIG_NETWORK_FILESYSTEMS=3Dy=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V2 is not set=0A=
CONFIG_NFS_V3=3Dy=0A=
CONFIG_NFS_V3_ACL=3Dy=0A=
CONFIG_NFS_V4=3Dy=0A=
# CONFIG_NFS_SWAP is not set=0A=
CONFIG_NFS_V4_1=3Dy=0A=
CONFIG_NFS_V4_2=3Dy=0A=
CONFIG_PNFS_FILE_LAYOUT=3Dy=0A=
CONFIG_PNFS_BLOCK=3Dy=0A=
CONFIG_PNFS_FLEXFILE_LAYOUT=3Dy=0A=
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"=0A=
# CONFIG_NFS_V4_1_MIGRATION is not set=0A=
CONFIG_NFS_V4_SECURITY_LABEL=3Dy=0A=
CONFIG_ROOT_NFS=3Dy=0A=
CONFIG_NFS_FSCACHE=3Dy=0A=
# CONFIG_NFS_USE_LEGACY_DNS is not set=0A=
CONFIG_NFS_USE_KERNEL_DNS=3Dy=0A=
# CONFIG_NFS_DISABLE_UDP_SUPPORT is not set=0A=
CONFIG_NFS_V4_2_READ_PLUS=3Dy=0A=
CONFIG_NFSD=3Dy=0A=
# CONFIG_NFSD_V2 is not set=0A=
CONFIG_NFSD_V3_ACL=3Dy=0A=
CONFIG_NFSD_V4=3Dy=0A=
CONFIG_NFSD_PNFS=3Dy=0A=
CONFIG_NFSD_BLOCKLAYOUT=3Dy=0A=
CONFIG_NFSD_SCSILAYOUT=3Dy=0A=
CONFIG_NFSD_FLEXFILELAYOUT=3Dy=0A=
CONFIG_NFSD_V4_2_INTER_SSC=3Dy=0A=
CONFIG_NFSD_V4_SECURITY_LABEL=3Dy=0A=
# CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set=0A=
CONFIG_GRACE_PERIOD=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_NFS_ACL_SUPPORT=3Dy=0A=
CONFIG_NFS_COMMON=3Dy=0A=
# CONFIG_NFS_LOCALIO is not set=0A=
CONFIG_NFS_V4_2_SSC_HELPER=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_SUNRPC_GSS=3Dy=0A=
CONFIG_SUNRPC_BACKCHANNEL=3Dy=0A=
CONFIG_RPCSEC_GSS_KRB5=3Dy=0A=
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=3Dy=0A=
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set=0A=
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set=0A=
# CONFIG_SUNRPC_DEBUG is not set=0A=
# CONFIG_SUNRPC_XPRT_RDMA is not set=0A=
CONFIG_CEPH_FS=3Dy=0A=
CONFIG_CEPH_FSCACHE=3Dy=0A=
CONFIG_CEPH_FS_POSIX_ACL=3Dy=0A=
# CONFIG_CEPH_FS_SECURITY_LABEL is not set=0A=
CONFIG_CIFS=3Dy=0A=
# CONFIG_CIFS_STATS2 is not set=0A=
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy=0A=
CONFIG_CIFS_UPCALL=3Dy=0A=
CONFIG_CIFS_XATTR=3Dy=0A=
CONFIG_CIFS_POSIX=3Dy=0A=
CONFIG_CIFS_DEBUG=3Dy=0A=
# CONFIG_CIFS_DEBUG2 is not set=0A=
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set=0A=
CONFIG_CIFS_DFS_UPCALL=3Dy=0A=
CONFIG_CIFS_SWN_UPCALL=3Dy=0A=
CONFIG_CIFS_SMB_DIRECT=3Dy=0A=
CONFIG_CIFS_FSCACHE=3Dy=0A=
# CONFIG_CIFS_ROOT is not set=0A=
# CONFIG_CIFS_COMPRESSION is not set=0A=
CONFIG_SMB_SERVER=3Dy=0A=
# CONFIG_SMB_SERVER_SMBDIRECT is not set=0A=
# CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN is not set=0A=
# CONFIG_SMB_SERVER_KERBEROS5 is not set=0A=
CONFIG_SMBFS=3Dy=0A=
# CONFIG_CODA_FS is not set=0A=
CONFIG_AFS_FS=3Dy=0A=
# CONFIG_AFS_DEBUG is not set=0A=
CONFIG_AFS_FSCACHE=3Dy=0A=
# CONFIG_AFS_DEBUG_CURSOR is not set=0A=
CONFIG_9P_FS=3Dy=0A=
CONFIG_9P_FSCACHE=3Dy=0A=
CONFIG_9P_FS_POSIX_ACL=3Dy=0A=
CONFIG_9P_FS_SECURITY=3Dy=0A=
CONFIG_NLS=3Dy=0A=
CONFIG_NLS_DEFAULT=3D"utf8"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
CONFIG_NLS_CODEPAGE_737=3Dy=0A=
CONFIG_NLS_CODEPAGE_775=3Dy=0A=
CONFIG_NLS_CODEPAGE_850=3Dy=0A=
CONFIG_NLS_CODEPAGE_852=3Dy=0A=
CONFIG_NLS_CODEPAGE_855=3Dy=0A=
CONFIG_NLS_CODEPAGE_857=3Dy=0A=
CONFIG_NLS_CODEPAGE_860=3Dy=0A=
CONFIG_NLS_CODEPAGE_861=3Dy=0A=
CONFIG_NLS_CODEPAGE_862=3Dy=0A=
CONFIG_NLS_CODEPAGE_863=3Dy=0A=
CONFIG_NLS_CODEPAGE_864=3Dy=0A=
CONFIG_NLS_CODEPAGE_865=3Dy=0A=
CONFIG_NLS_CODEPAGE_866=3Dy=0A=
CONFIG_NLS_CODEPAGE_869=3Dy=0A=
CONFIG_NLS_CODEPAGE_936=3Dy=0A=
CONFIG_NLS_CODEPAGE_950=3Dy=0A=
CONFIG_NLS_CODEPAGE_932=3Dy=0A=
CONFIG_NLS_CODEPAGE_949=3Dy=0A=
CONFIG_NLS_CODEPAGE_874=3Dy=0A=
CONFIG_NLS_ISO8859_8=3Dy=0A=
CONFIG_NLS_CODEPAGE_1250=3Dy=0A=
CONFIG_NLS_CODEPAGE_1251=3Dy=0A=
CONFIG_NLS_ASCII=3Dy=0A=
CONFIG_NLS_ISO8859_1=3Dy=0A=
CONFIG_NLS_ISO8859_2=3Dy=0A=
CONFIG_NLS_ISO8859_3=3Dy=0A=
CONFIG_NLS_ISO8859_4=3Dy=0A=
CONFIG_NLS_ISO8859_5=3Dy=0A=
CONFIG_NLS_ISO8859_6=3Dy=0A=
CONFIG_NLS_ISO8859_7=3Dy=0A=
CONFIG_NLS_ISO8859_9=3Dy=0A=
CONFIG_NLS_ISO8859_13=3Dy=0A=
CONFIG_NLS_ISO8859_14=3Dy=0A=
CONFIG_NLS_ISO8859_15=3Dy=0A=
CONFIG_NLS_KOI8_R=3Dy=0A=
CONFIG_NLS_KOI8_U=3Dy=0A=
CONFIG_NLS_MAC_ROMAN=3Dy=0A=
CONFIG_NLS_MAC_CELTIC=3Dy=0A=
CONFIG_NLS_MAC_CENTEURO=3Dy=0A=
CONFIG_NLS_MAC_CROATIAN=3Dy=0A=
CONFIG_NLS_MAC_CYRILLIC=3Dy=0A=
CONFIG_NLS_MAC_GAELIC=3Dy=0A=
CONFIG_NLS_MAC_GREEK=3Dy=0A=
CONFIG_NLS_MAC_ICELAND=3Dy=0A=
CONFIG_NLS_MAC_INUIT=3Dy=0A=
CONFIG_NLS_MAC_ROMANIAN=3Dy=0A=
CONFIG_NLS_MAC_TURKISH=3Dy=0A=
CONFIG_NLS_UTF8=3Dy=0A=
CONFIG_NLS_UCS2_UTILS=3Dy=0A=
CONFIG_DLM=3Dy=0A=
# CONFIG_DLM_DEBUG is not set=0A=
CONFIG_UNICODE=3Dy=0A=
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set=0A=
CONFIG_IO_WQ=3Dy=0A=
# end of File systems=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
CONFIG_KEYS=3Dy=0A=
CONFIG_KEYS_REQUEST_CACHE=3Dy=0A=
CONFIG_PERSISTENT_KEYRINGS=3Dy=0A=
CONFIG_BIG_KEYS=3Dy=0A=
CONFIG_TRUSTED_KEYS=3Dy=0A=
# CONFIG_TRUSTED_KEYS_TPM is not set=0A=
# CONFIG_TRUSTED_KEYS_TEE is not set=0A=
=0A=
#=0A=
# No trust source selected!=0A=
#=0A=
CONFIG_ENCRYPTED_KEYS=3Dy=0A=
# CONFIG_USER_DECRYPTED_DATA is not set=0A=
CONFIG_KEY_DH_OPERATIONS=3Dy=0A=
CONFIG_KEY_NOTIFICATIONS=3Dy=0A=
# CONFIG_SECURITY_DMESG_RESTRICT is not set=0A=
CONFIG_PROC_MEM_ALWAYS_FORCE=3Dy=0A=
# CONFIG_PROC_MEM_FORCE_PTRACE is not set=0A=
# CONFIG_PROC_MEM_NO_FORCE is not set=0A=
CONFIG_SECURITY=3Dy=0A=
CONFIG_SECURITYFS=3Dy=0A=
CONFIG_SECURITY_NETWORK=3Dy=0A=
CONFIG_SECURITY_INFINIBAND=3Dy=0A=
CONFIG_SECURITY_NETWORK_XFRM=3Dy=0A=
CONFIG_SECURITY_PATH=3Dy=0A=
# CONFIG_INTEL_TXT is not set=0A=
CONFIG_LSM_MMAP_MIN_ADDR=3D65536=0A=
CONFIG_HARDENED_USERCOPY=3Dy=0A=
CONFIG_FORTIFY_SOURCE=3Dy=0A=
# CONFIG_STATIC_USERMODEHELPER is not set=0A=
CONFIG_SECURITY_SELINUX=3Dy=0A=
CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy=0A=
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy=0A=
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy=0A=
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9=0A=
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=3D256=0A=
# CONFIG_SECURITY_SELINUX_DEBUG is not set=0A=
# CONFIG_SECURITY_SMACK is not set=0A=
CONFIG_SECURITY_TOMOYO=3Dy=0A=
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=3D64=0A=
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=3D32=0A=
CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER=3Dy=0A=
CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING=3Dy=0A=
# CONFIG_SECURITY_APPARMOR is not set=0A=
# CONFIG_SECURITY_LOADPIN is not set=0A=
CONFIG_SECURITY_YAMA=3Dy=0A=
CONFIG_SECURITY_SAFESETID=3Dy=0A=
CONFIG_SECURITY_LOCKDOWN_LSM=3Dy=0A=
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy=0A=
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=3Dy=0A=
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set=0A=
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set=0A=
CONFIG_SECURITY_LANDLOCK=3Dy=0A=
# CONFIG_SECURITY_IPE is not set=0A=
CONFIG_INTEGRITY=3Dy=0A=
CONFIG_INTEGRITY_SIGNATURE=3Dy=0A=
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy=0A=
CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy=0A=
CONFIG_INTEGRITY_AUDIT=3Dy=0A=
CONFIG_IMA=3Dy=0A=
CONFIG_IMA_MEASURE_PCR_IDX=3D10=0A=
CONFIG_IMA_LSM_RULES=3Dy=0A=
CONFIG_IMA_NG_TEMPLATE=3Dy=0A=
# CONFIG_IMA_SIG_TEMPLATE is not set=0A=
CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"=0A=
# CONFIG_IMA_DEFAULT_HASH_SHA1 is not set=0A=
CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy=0A=
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set=0A=
# CONFIG_IMA_DEFAULT_HASH_WP512 is not set=0A=
CONFIG_IMA_DEFAULT_HASH=3D"sha256"=0A=
CONFIG_IMA_WRITE_POLICY=3Dy=0A=
CONFIG_IMA_READ_POLICY=3Dy=0A=
CONFIG_IMA_APPRAISE=3Dy=0A=
# CONFIG_IMA_ARCH_POLICY is not set=0A=
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set=0A=
# CONFIG_IMA_APPRAISE_BOOTPARAM is not set=0A=
CONFIG_IMA_APPRAISE_MODSIG=3Dy=0A=
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set=0A=
# CONFIG_IMA_BLACKLIST_KEYRING is not set=0A=
# CONFIG_IMA_LOAD_X509 is not set=0A=
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy=0A=
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy=0A=
# CONFIG_IMA_DISABLE_HTABLE is not set=0A=
CONFIG_EVM=3Dy=0A=
CONFIG_EVM_ATTR_FSUUID=3Dy=0A=
CONFIG_EVM_ADD_XATTRS=3Dy=0A=
# CONFIG_EVM_LOAD_X509 is not set=0A=
CONFIG_DEFAULT_SECURITY_SELINUX=3Dy=0A=
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set=0A=
# CONFIG_DEFAULT_SECURITY_DAC is not set=0A=
CONFIG_LSM=3D"landlock,lockdown,yama,safesetid,integrity,tomoyo,selinux,bpf=
"=0A=
=0A=
#=0A=
# Kernel hardening options=0A=
#=0A=
=0A=
#=0A=
# Memory initialization=0A=
#=0A=
CONFIG_INIT_STACK_NONE=3Dy=0A=
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy=0A=
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set=0A=
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=3Dy=0A=
# CONFIG_ZERO_CALL_USED_REGS is not set=0A=
# end of Memory initialization=0A=
=0A=
#=0A=
# Hardening of kernel data structures=0A=
#=0A=
CONFIG_LIST_HARDENED=3Dy=0A=
CONFIG_BUG_ON_DATA_CORRUPTION=3Dy=0A=
# end of Hardening of kernel data structures=0A=
=0A=
CONFIG_RANDSTRUCT_NONE=3Dy=0A=
# end of Kernel hardening options=0A=
# end of Security options=0A=
=0A=
CONFIG_XOR_BLOCKS=3Dy=0A=
CONFIG_ASYNC_CORE=3Dy=0A=
CONFIG_ASYNC_MEMCPY=3Dy=0A=
CONFIG_ASYNC_XOR=3Dy=0A=
CONFIG_ASYNC_PQ=3Dy=0A=
CONFIG_ASYNC_RAID6_RECOV=3Dy=0A=
CONFIG_CRYPTO=3Dy=0A=
=0A=
#=0A=
# Crypto core or helper=0A=
#=0A=
CONFIG_CRYPTO_ALGAPI=3Dy=0A=
CONFIG_CRYPTO_ALGAPI2=3Dy=0A=
CONFIG_CRYPTO_AEAD=3Dy=0A=
CONFIG_CRYPTO_AEAD2=3Dy=0A=
CONFIG_CRYPTO_SIG=3Dy=0A=
CONFIG_CRYPTO_SIG2=3Dy=0A=
CONFIG_CRYPTO_SKCIPHER=3Dy=0A=
CONFIG_CRYPTO_SKCIPHER2=3Dy=0A=
CONFIG_CRYPTO_HASH=3Dy=0A=
CONFIG_CRYPTO_HASH2=3Dy=0A=
CONFIG_CRYPTO_RNG=3Dy=0A=
CONFIG_CRYPTO_RNG2=3Dy=0A=
CONFIG_CRYPTO_RNG_DEFAULT=3Dy=0A=
CONFIG_CRYPTO_AKCIPHER2=3Dy=0A=
CONFIG_CRYPTO_AKCIPHER=3Dy=0A=
CONFIG_CRYPTO_KPP2=3Dy=0A=
CONFIG_CRYPTO_KPP=3Dy=0A=
CONFIG_CRYPTO_ACOMP2=3Dy=0A=
CONFIG_CRYPTO_MANAGER=3Dy=0A=
CONFIG_CRYPTO_MANAGER2=3Dy=0A=
CONFIG_CRYPTO_USER=3Dy=0A=
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy=0A=
CONFIG_CRYPTO_NULL=3Dy=0A=
CONFIG_CRYPTO_NULL2=3Dy=0A=
CONFIG_CRYPTO_PCRYPT=3Dy=0A=
CONFIG_CRYPTO_CRYPTD=3Dy=0A=
CONFIG_CRYPTO_AUTHENC=3Dy=0A=
# CONFIG_CRYPTO_TEST is not set=0A=
CONFIG_CRYPTO_SIMD=3Dy=0A=
CONFIG_CRYPTO_ENGINE=3Dy=0A=
# end of Crypto core or helper=0A=
=0A=
#=0A=
# Public-key cryptography=0A=
#=0A=
CONFIG_CRYPTO_RSA=3Dy=0A=
CONFIG_CRYPTO_DH=3Dy=0A=
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set=0A=
CONFIG_CRYPTO_ECC=3Dy=0A=
CONFIG_CRYPTO_ECDH=3Dy=0A=
CONFIG_CRYPTO_ECDSA=3Dy=0A=
CONFIG_CRYPTO_ECRDSA=3Dy=0A=
CONFIG_CRYPTO_CURVE25519=3Dy=0A=
# end of Public-key cryptography=0A=
=0A=
#=0A=
# Block ciphers=0A=
#=0A=
CONFIG_CRYPTO_AES=3Dy=0A=
CONFIG_CRYPTO_AES_TI=3Dy=0A=
CONFIG_CRYPTO_ANUBIS=3Dy=0A=
CONFIG_CRYPTO_ARIA=3Dy=0A=
CONFIG_CRYPTO_BLOWFISH=3Dy=0A=
CONFIG_CRYPTO_BLOWFISH_COMMON=3Dy=0A=
CONFIG_CRYPTO_CAMELLIA=3Dy=0A=
CONFIG_CRYPTO_CAST_COMMON=3Dy=0A=
CONFIG_CRYPTO_CAST5=3Dy=0A=
CONFIG_CRYPTO_CAST6=3Dy=0A=
CONFIG_CRYPTO_DES=3Dy=0A=
CONFIG_CRYPTO_FCRYPT=3Dy=0A=
CONFIG_CRYPTO_KHAZAD=3Dy=0A=
CONFIG_CRYPTO_SEED=3Dy=0A=
CONFIG_CRYPTO_SERPENT=3Dy=0A=
CONFIG_CRYPTO_SM4=3Dy=0A=
CONFIG_CRYPTO_SM4_GENERIC=3Dy=0A=
CONFIG_CRYPTO_TEA=3Dy=0A=
CONFIG_CRYPTO_TWOFISH=3Dy=0A=
CONFIG_CRYPTO_TWOFISH_COMMON=3Dy=0A=
# end of Block ciphers=0A=
=0A=
#=0A=
# Length-preserving ciphers and modes=0A=
#=0A=
CONFIG_CRYPTO_ADIANTUM=3Dy=0A=
CONFIG_CRYPTO_ARC4=3Dy=0A=
CONFIG_CRYPTO_CHACHA20=3Dy=0A=
CONFIG_CRYPTO_CBC=3Dy=0A=
CONFIG_CRYPTO_CTR=3Dy=0A=
CONFIG_CRYPTO_CTS=3Dy=0A=
CONFIG_CRYPTO_ECB=3Dy=0A=
CONFIG_CRYPTO_HCTR2=3Dy=0A=
CONFIG_CRYPTO_KEYWRAP=3Dy=0A=
CONFIG_CRYPTO_LRW=3Dy=0A=
CONFIG_CRYPTO_PCBC=3Dy=0A=
CONFIG_CRYPTO_XCTR=3Dy=0A=
CONFIG_CRYPTO_XTS=3Dy=0A=
CONFIG_CRYPTO_NHPOLY1305=3Dy=0A=
# end of Length-preserving ciphers and modes=0A=
=0A=
#=0A=
# AEAD (authenticated encryption with associated data) ciphers=0A=
#=0A=
CONFIG_CRYPTO_AEGIS128=3Dy=0A=
CONFIG_CRYPTO_CHACHA20POLY1305=3Dy=0A=
CONFIG_CRYPTO_CCM=3Dy=0A=
CONFIG_CRYPTO_GCM=3Dy=0A=
CONFIG_CRYPTO_GENIV=3Dy=0A=
CONFIG_CRYPTO_SEQIV=3Dy=0A=
CONFIG_CRYPTO_ECHAINIV=3Dy=0A=
CONFIG_CRYPTO_ESSIV=3Dy=0A=
# end of AEAD (authenticated encryption with associated data) ciphers=0A=
=0A=
#=0A=
# Hashes, digests, and MACs=0A=
#=0A=
CONFIG_CRYPTO_BLAKE2B=3Dy=0A=
CONFIG_CRYPTO_CMAC=3Dy=0A=
CONFIG_CRYPTO_GHASH=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
# CONFIG_CRYPTO_MD4 is not set=0A=
CONFIG_CRYPTO_MD5=3Dy=0A=
CONFIG_CRYPTO_MICHAEL_MIC=3Dy=0A=
CONFIG_CRYPTO_POLYVAL=3Dy=0A=
CONFIG_CRYPTO_POLY1305=3Dy=0A=
CONFIG_CRYPTO_RMD160=3Dy=0A=
CONFIG_CRYPTO_SHA1=3Dy=0A=
CONFIG_CRYPTO_SHA256=3Dy=0A=
CONFIG_CRYPTO_SHA512=3Dy=0A=
CONFIG_CRYPTO_SHA3=3Dy=0A=
CONFIG_CRYPTO_SM3=3Dy=0A=
# CONFIG_CRYPTO_SM3_GENERIC is not set=0A=
CONFIG_CRYPTO_STREEBOG=3Dy=0A=
CONFIG_CRYPTO_VMAC=3Dy=0A=
CONFIG_CRYPTO_WP512=3Dy=0A=
CONFIG_CRYPTO_XCBC=3Dy=0A=
CONFIG_CRYPTO_XXHASH=3Dy=0A=
# end of Hashes, digests, and MACs=0A=
=0A=
#=0A=
# CRCs (cyclic redundancy checks)=0A=
#=0A=
CONFIG_CRYPTO_CRC32C=3Dy=0A=
CONFIG_CRYPTO_CRC32=3Dy=0A=
CONFIG_CRYPTO_CRCT10DIF=3Dy=0A=
CONFIG_CRYPTO_CRC64_ROCKSOFT=3Dy=0A=
# end of CRCs (cyclic redundancy checks)=0A=
=0A=
#=0A=
# Compression=0A=
#=0A=
CONFIG_CRYPTO_DEFLATE=3Dy=0A=
CONFIG_CRYPTO_LZO=3Dy=0A=
CONFIG_CRYPTO_842=3Dy=0A=
CONFIG_CRYPTO_LZ4=3Dy=0A=
CONFIG_CRYPTO_LZ4HC=3Dy=0A=
CONFIG_CRYPTO_ZSTD=3Dy=0A=
# end of Compression=0A=
=0A=
#=0A=
# Random number generation=0A=
#=0A=
CONFIG_CRYPTO_ANSI_CPRNG=3Dy=0A=
CONFIG_CRYPTO_DRBG_MENU=3Dy=0A=
CONFIG_CRYPTO_DRBG_HMAC=3Dy=0A=
CONFIG_CRYPTO_DRBG_HASH=3Dy=0A=
CONFIG_CRYPTO_DRBG_CTR=3Dy=0A=
CONFIG_CRYPTO_DRBG=3Dy=0A=
CONFIG_CRYPTO_JITTERENTROPY=3Dy=0A=
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=3D64=0A=
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=3D32=0A=
CONFIG_CRYPTO_JITTERENTROPY_OSR=3D1=0A=
CONFIG_CRYPTO_KDF800108_CTR=3Dy=0A=
# end of Random number generation=0A=
=0A=
#=0A=
# Userspace interface=0A=
#=0A=
CONFIG_CRYPTO_USER_API=3Dy=0A=
CONFIG_CRYPTO_USER_API_HASH=3Dy=0A=
CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy=0A=
CONFIG_CRYPTO_USER_API_RNG=3Dy=0A=
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set=0A=
CONFIG_CRYPTO_USER_API_AEAD=3Dy=0A=
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=3Dy=0A=
# end of Userspace interface=0A=
=0A=
CONFIG_CRYPTO_HASH_INFO=3Dy=0A=
=0A=
#=0A=
# Accelerated Cryptographic Algorithms for CPU (x86)=0A=
#=0A=
CONFIG_CRYPTO_CURVE25519_X86=3Dy=0A=
CONFIG_CRYPTO_AES_NI_INTEL=3Dy=0A=
CONFIG_CRYPTO_BLOWFISH_X86_64=3Dy=0A=
CONFIG_CRYPTO_CAMELLIA_X86_64=3Dy=0A=
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dy=0A=
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dy=0A=
CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dy=0A=
CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dy=0A=
CONFIG_CRYPTO_DES3_EDE_X86_64=3Dy=0A=
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dy=0A=
CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dy=0A=
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dy=0A=
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=3Dy=0A=
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=3Dy=0A=
CONFIG_CRYPTO_TWOFISH_X86_64=3Dy=0A=
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dy=0A=
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dy=0A=
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=3Dy=0A=
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set=0A=
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set=0A=
CONFIG_CRYPTO_CHACHA20_X86_64=3Dy=0A=
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=3Dy=0A=
CONFIG_CRYPTO_NHPOLY1305_SSE2=3Dy=0A=
CONFIG_CRYPTO_NHPOLY1305_AVX2=3Dy=0A=
CONFIG_CRYPTO_BLAKE2S_X86=3Dy=0A=
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=3Dy=0A=
CONFIG_CRYPTO_POLY1305_X86_64=3Dy=0A=
CONFIG_CRYPTO_SHA1_SSSE3=3Dy=0A=
CONFIG_CRYPTO_SHA256_SSSE3=3Dy=0A=
CONFIG_CRYPTO_SHA512_SSSE3=3Dy=0A=
CONFIG_CRYPTO_SM3_AVX_X86_64=3Dy=0A=
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dy=0A=
CONFIG_CRYPTO_CRC32C_INTEL=3Dy=0A=
CONFIG_CRYPTO_CRC32_PCLMUL=3Dy=0A=
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dy=0A=
# end of Accelerated Cryptographic Algorithms for CPU (x86)=0A=
=0A=
CONFIG_CRYPTO_HW=3Dy=0A=
CONFIG_CRYPTO_DEV_PADLOCK=3Dy=0A=
CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dy=0A=
CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dy=0A=
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set=0A=
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set=0A=
CONFIG_CRYPTO_DEV_CCP=3Dy=0A=
CONFIG_CRYPTO_DEV_CCP_DD=3Dy=0A=
# CONFIG_CRYPTO_DEV_SP_CCP is not set=0A=
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set=0A=
CONFIG_CRYPTO_DEV_QAT=3Dy=0A=
CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dy=0A=
CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dy=0A=
CONFIG_CRYPTO_DEV_QAT_C62X=3Dy=0A=
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set=0A=
# CONFIG_CRYPTO_DEV_QAT_420XX is not set=0A=
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dy=0A=
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dy=0A=
CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dy=0A=
# CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION is not set=0A=
CONFIG_CRYPTO_DEV_VIRTIO=3Dy=0A=
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set=0A=
# CONFIG_CRYPTO_DEV_CCREE is not set=0A=
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set=0A=
CONFIG_ASYMMETRIC_KEY_TYPE=3Dy=0A=
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy=0A=
CONFIG_X509_CERTIFICATE_PARSER=3Dy=0A=
CONFIG_PKCS8_PRIVATE_KEY_PARSER=3Dy=0A=
CONFIG_PKCS7_MESSAGE_PARSER=3Dy=0A=
CONFIG_PKCS7_TEST_KEY=3Dy=0A=
CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy=0A=
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set=0A=
=0A=
#=0A=
# Certificates for signature checking=0A=
#=0A=
CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"=0A=
# CONFIG_MODULE_SIG_KEY_TYPE_RSA is not set=0A=
CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=3Dy=0A=
CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy=0A=
CONFIG_SYSTEM_TRUSTED_KEYS=3D""=0A=
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set=0A=
CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy=0A=
# CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set=0A=
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set=0A=
# end of Certificates for signature checking=0A=
=0A=
CONFIG_BINARY_PRINTF=3Dy=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_RAID6_PQ=3Dy=0A=
# CONFIG_RAID6_PQ_BENCHMARK is not set=0A=
CONFIG_LINEAR_RANGES=3Dy=0A=
# CONFIG_PACKING is not set=0A=
CONFIG_BITREVERSE=3Dy=0A=
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy=0A=
CONFIG_GENERIC_STRNLEN_USER=3Dy=0A=
CONFIG_GENERIC_NET_UTILS=3Dy=0A=
# CONFIG_CORDIC is not set=0A=
# CONFIG_PRIME_NUMBERS is not set=0A=
CONFIG_RATIONAL=3Dy=0A=
CONFIG_GENERIC_IOMAP=3Dy=0A=
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy=0A=
CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy=0A=
CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy=0A=
=0A=
#=0A=
# Crypto library routines=0A=
#=0A=
CONFIG_CRYPTO_LIB_UTILS=3Dy=0A=
CONFIG_CRYPTO_LIB_AES=3Dy=0A=
CONFIG_CRYPTO_LIB_ARC4=3Dy=0A=
CONFIG_CRYPTO_LIB_GF128MUL=3Dy=0A=
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=3Dy=0A=
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dy=0A=
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dy=0A=
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=3Dy=0A=
CONFIG_CRYPTO_LIB_CHACHA=3Dy=0A=
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=3Dy=0A=
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=3Dy=0A=
CONFIG_CRYPTO_LIB_CURVE25519=3Dy=0A=
CONFIG_CRYPTO_LIB_DES=3Dy=0A=
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11=0A=
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=3Dy=0A=
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=3Dy=0A=
CONFIG_CRYPTO_LIB_POLY1305=3Dy=0A=
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=3Dy=0A=
CONFIG_CRYPTO_LIB_SHA1=3Dy=0A=
CONFIG_CRYPTO_LIB_SHA256=3Dy=0A=
# end of Crypto library routines=0A=
=0A=
CONFIG_CRC_CCITT=3Dy=0A=
CONFIG_CRC16=3Dy=0A=
CONFIG_CRC_T10DIF=3Dy=0A=
CONFIG_CRC64_ROCKSOFT=3Dy=0A=
CONFIG_CRC_ITU_T=3Dy=0A=
CONFIG_CRC32=3Dy=0A=
# CONFIG_CRC32_SELFTEST is not set=0A=
CONFIG_CRC32_SLICEBY8=3Dy=0A=
# CONFIG_CRC32_SLICEBY4 is not set=0A=
# CONFIG_CRC32_SARWATE is not set=0A=
# CONFIG_CRC32_BIT is not set=0A=
CONFIG_CRC64=3Dy=0A=
CONFIG_CRC4=3Dy=0A=
CONFIG_CRC7=3Dy=0A=
CONFIG_LIBCRC32C=3Dy=0A=
CONFIG_CRC8=3Dy=0A=
CONFIG_XXHASH=3Dy=0A=
# CONFIG_RANDOM32_SELFTEST is not set=0A=
CONFIG_842_COMPRESS=3Dy=0A=
CONFIG_842_DECOMPRESS=3Dy=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
CONFIG_LZO_COMPRESS=3Dy=0A=
CONFIG_LZO_DECOMPRESS=3Dy=0A=
CONFIG_LZ4_COMPRESS=3Dy=0A=
CONFIG_LZ4HC_COMPRESS=3Dy=0A=
CONFIG_LZ4_DECOMPRESS=3Dy=0A=
CONFIG_ZSTD_COMMON=3Dy=0A=
CONFIG_ZSTD_COMPRESS=3Dy=0A=
CONFIG_ZSTD_DECOMPRESS=3Dy=0A=
CONFIG_XZ_DEC=3Dy=0A=
CONFIG_XZ_DEC_X86=3Dy=0A=
CONFIG_XZ_DEC_POWERPC=3Dy=0A=
CONFIG_XZ_DEC_ARM=3Dy=0A=
CONFIG_XZ_DEC_ARMTHUMB=3Dy=0A=
CONFIG_XZ_DEC_ARM64=3Dy=0A=
CONFIG_XZ_DEC_SPARC=3Dy=0A=
CONFIG_XZ_DEC_RISCV=3Dy=0A=
# CONFIG_XZ_DEC_MICROLZMA is not set=0A=
CONFIG_XZ_DEC_BCJ=3Dy=0A=
# CONFIG_XZ_DEC_TEST is not set=0A=
CONFIG_DECOMPRESS_GZIP=3Dy=0A=
CONFIG_DECOMPRESS_BZIP2=3Dy=0A=
CONFIG_DECOMPRESS_LZMA=3Dy=0A=
CONFIG_DECOMPRESS_XZ=3Dy=0A=
CONFIG_DECOMPRESS_LZO=3Dy=0A=
CONFIG_DECOMPRESS_LZ4=3Dy=0A=
CONFIG_DECOMPRESS_ZSTD=3Dy=0A=
CONFIG_GENERIC_ALLOCATOR=3Dy=0A=
CONFIG_REED_SOLOMON=3Dy=0A=
CONFIG_REED_SOLOMON_DEC8=3Dy=0A=
CONFIG_TEXTSEARCH=3Dy=0A=
CONFIG_TEXTSEARCH_KMP=3Dy=0A=
CONFIG_TEXTSEARCH_BM=3Dy=0A=
CONFIG_TEXTSEARCH_FSM=3Dy=0A=
CONFIG_INTERVAL_TREE=3Dy=0A=
CONFIG_INTERVAL_TREE_SPAN_ITER=3Dy=0A=
CONFIG_XARRAY_MULTI=3Dy=0A=
CONFIG_ASSOCIATIVE_ARRAY=3Dy=0A=
CONFIG_CLOSURES=3Dy=0A=
CONFIG_HAS_IOMEM=3Dy=0A=
CONFIG_HAS_IOPORT=3Dy=0A=
CONFIG_HAS_IOPORT_MAP=3Dy=0A=
CONFIG_HAS_DMA=3Dy=0A=
CONFIG_DMA_OPS_HELPERS=3Dy=0A=
CONFIG_NEED_SG_DMA_FLAGS=3Dy=0A=
CONFIG_NEED_SG_DMA_LENGTH=3Dy=0A=
CONFIG_NEED_DMA_MAP_STATE=3Dy=0A=
CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy=0A=
CONFIG_DMA_DECLARE_COHERENT=3Dy=0A=
CONFIG_SWIOTLB=3Dy=0A=
# CONFIG_SWIOTLB_DYNAMIC is not set=0A=
CONFIG_DMA_NEED_SYNC=3Dy=0A=
# CONFIG_DMA_RESTRICTED_POOL is not set=0A=
CONFIG_DMA_CMA=3Dy=0A=
# CONFIG_DMA_NUMA_CMA is not set=0A=
=0A=
#=0A=
# Default contiguous memory area size:=0A=
#=0A=
CONFIG_CMA_SIZE_MBYTES=3D0=0A=
CONFIG_CMA_SIZE_PERCENTAGE=3D0=0A=
# CONFIG_CMA_SIZE_SEL_MBYTES is not set=0A=
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set=0A=
# CONFIG_CMA_SIZE_SEL_MIN is not set=0A=
CONFIG_CMA_SIZE_SEL_MAX=3Dy=0A=
CONFIG_CMA_ALIGNMENT=3D8=0A=
# CONFIG_DMA_API_DEBUG is not set=0A=
# CONFIG_DMA_MAP_BENCHMARK is not set=0A=
CONFIG_SGL_ALLOC=3Dy=0A=
CONFIG_CHECK_SIGNATURE=3Dy=0A=
# CONFIG_CPUMASK_OFFSTACK is not set=0A=
CONFIG_CPU_RMAP=3Dy=0A=
CONFIG_DQL=3Dy=0A=
CONFIG_GLOB=3Dy=0A=
# CONFIG_GLOB_SELFTEST is not set=0A=
CONFIG_NLATTR=3Dy=0A=
CONFIG_CLZ_TAB=3Dy=0A=
CONFIG_IRQ_POLL=3Dy=0A=
CONFIG_MPILIB=3Dy=0A=
CONFIG_SIGNATURE=3Dy=0A=
CONFIG_DIMLIB=3Dy=0A=
CONFIG_LIBFDT=3Dy=0A=
CONFIG_OID_REGISTRY=3Dy=0A=
CONFIG_HAVE_GENERIC_VDSO=3Dy=0A=
CONFIG_GENERIC_GETTIMEOFDAY=3Dy=0A=
CONFIG_GENERIC_VDSO_TIME_NS=3Dy=0A=
CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT=3Dy=0A=
CONFIG_VDSO_GETRANDOM=3Dy=0A=
CONFIG_FONT_SUPPORT=3Dy=0A=
# CONFIG_FONTS is not set=0A=
CONFIG_FONT_8x8=3Dy=0A=
CONFIG_FONT_8x16=3Dy=0A=
CONFIG_SG_POOL=3Dy=0A=
CONFIG_ARCH_HAS_PMEM_API=3Dy=0A=
CONFIG_MEMREGION=3Dy=0A=
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=3Dy=0A=
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy=0A=
CONFIG_ARCH_HAS_COPY_MC=3Dy=0A=
CONFIG_ARCH_STACKWALK=3Dy=0A=
CONFIG_STACKDEPOT=3Dy=0A=
CONFIG_STACKDEPOT_ALWAYS_INIT=3Dy=0A=
CONFIG_STACKDEPOT_MAX_FRAMES=3D64=0A=
CONFIG_REF_TRACKER=3Dy=0A=
CONFIG_SBITMAP=3Dy=0A=
# CONFIG_LWQ_TEST is not set=0A=
# end of Library routines=0A=
=0A=
CONFIG_FIRMWARE_TABLE=3Dy=0A=
CONFIG_UNION_FIND=3Dy=0A=
CONFIG_MIN_HEAP=3Dy=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
=0A=
#=0A=
# printk and dmesg options=0A=
#=0A=
CONFIG_PRINTK_TIME=3Dy=0A=
CONFIG_PRINTK_CALLER=3Dy=0A=
# CONFIG_STACKTRACE_BUILD_ID is not set=0A=
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7=0A=
CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4=0A=
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4=0A=
# CONFIG_BOOT_PRINTK_DELAY is not set=0A=
CONFIG_DYNAMIC_DEBUG=3Dy=0A=
CONFIG_DYNAMIC_DEBUG_CORE=3Dy=0A=
CONFIG_SYMBOLIC_ERRNAME=3Dy=0A=
CONFIG_DEBUG_BUGVERBOSE=3Dy=0A=
# end of printk and dmesg options=0A=
=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
CONFIG_DEBUG_MISC=3Dy=0A=
=0A=
#=0A=
# Compile-time checks and compiler options=0A=
#=0A=
CONFIG_DEBUG_INFO=3Dy=0A=
CONFIG_AS_HAS_NON_CONST_ULEB128=3Dy=0A=
# CONFIG_DEBUG_INFO_NONE is not set=0A=
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set=0A=
CONFIG_DEBUG_INFO_DWARF4=3Dy=0A=
# CONFIG_DEBUG_INFO_DWARF5 is not set=0A=
# CONFIG_DEBUG_INFO_REDUCED is not set=0A=
CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy=0A=
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set=0A=
# CONFIG_DEBUG_INFO_SPLIT is not set=0A=
# CONFIG_DEBUG_INFO_BTF is not set=0A=
CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy=0A=
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=3Dy=0A=
# CONFIG_GDB_SCRIPTS is not set=0A=
CONFIG_FRAME_WARN=3D2048=0A=
# CONFIG_STRIP_ASM_SYMS is not set=0A=
# CONFIG_READABLE_ASM is not set=0A=
# CONFIG_HEADERS_INSTALL is not set=0A=
# CONFIG_DEBUG_SECTION_MISMATCH is not set=0A=
CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy=0A=
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set=0A=
CONFIG_OBJTOOL=3Dy=0A=
CONFIG_NOINSTR_VALIDATION=3Dy=0A=
# CONFIG_VMLINUX_MAP is not set=0A=
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set=0A=
# end of Compile-time checks and compiler options=0A=
=0A=
#=0A=
# Generic Kernel Debugging Instruments=0A=
#=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
CONFIG_DEBUG_FS=3Dy=0A=
CONFIG_DEBUG_FS_ALLOW_ALL=3Dy=0A=
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set=0A=
# CONFIG_DEBUG_FS_ALLOW_NONE is not set=0A=
CONFIG_HAVE_ARCH_KGDB=3Dy=0A=
# CONFIG_KGDB is not set=0A=
CONFIG_ARCH_HAS_UBSAN=3Dy=0A=
CONFIG_UBSAN=3Dy=0A=
# CONFIG_UBSAN_TRAP is not set=0A=
CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=3Dy=0A=
CONFIG_UBSAN_BOUNDS=3Dy=0A=
CONFIG_UBSAN_BOUNDS_STRICT=3Dy=0A=
CONFIG_UBSAN_SHIFT=3Dy=0A=
# CONFIG_UBSAN_DIV_ZERO is not set=0A=
# CONFIG_UBSAN_SIGNED_WRAP is not set=0A=
# CONFIG_UBSAN_BOOL is not set=0A=
# CONFIG_UBSAN_ENUM is not set=0A=
# CONFIG_UBSAN_ALIGNMENT is not set=0A=
# CONFIG_TEST_UBSAN is not set=0A=
CONFIG_HAVE_ARCH_KCSAN=3Dy=0A=
CONFIG_HAVE_KCSAN_COMPILER=3Dy=0A=
# end of Generic Kernel Debugging Instruments=0A=
=0A=
#=0A=
# Networking Debugging=0A=
#=0A=
CONFIG_NET_DEV_REFCNT_TRACKER=3Dy=0A=
CONFIG_NET_NS_REFCNT_TRACKER=3Dy=0A=
CONFIG_DEBUG_NET=3Dy=0A=
# CONFIG_DEBUG_NET_SMALL_RTNL is not set=0A=
# end of Networking Debugging=0A=
=0A=
#=0A=
# Memory Debugging=0A=
#=0A=
CONFIG_PAGE_EXTENSION=3Dy=0A=
# CONFIG_DEBUG_PAGEALLOC is not set=0A=
CONFIG_SLUB_DEBUG=3Dy=0A=
# CONFIG_SLUB_DEBUG_ON is not set=0A=
CONFIG_SLUB_RCU_DEBUG=3Dy=0A=
CONFIG_PAGE_OWNER=3Dy=0A=
CONFIG_PAGE_TABLE_CHECK=3Dy=0A=
CONFIG_PAGE_TABLE_CHECK_ENFORCED=3Dy=0A=
CONFIG_PAGE_POISONING=3Dy=0A=
# CONFIG_DEBUG_PAGE_REF is not set=0A=
# CONFIG_DEBUG_RODATA_TEST is not set=0A=
CONFIG_ARCH_HAS_DEBUG_WX=3Dy=0A=
CONFIG_DEBUG_WX=3Dy=0A=
CONFIG_GENERIC_PTDUMP=3Dy=0A=
CONFIG_PTDUMP_CORE=3Dy=0A=
CONFIG_PTDUMP_DEBUGFS=3Dy=0A=
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy=0A=
# CONFIG_DEBUG_KMEMLEAK is not set=0A=
# CONFIG_PER_VMA_LOCK_STATS is not set=0A=
CONFIG_DEBUG_OBJECTS=3Dy=0A=
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set=0A=
CONFIG_DEBUG_OBJECTS_FREE=3Dy=0A=
CONFIG_DEBUG_OBJECTS_TIMERS=3Dy=0A=
CONFIG_DEBUG_OBJECTS_WORK=3Dy=0A=
CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy=0A=
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=3Dy=0A=
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=3D1=0A=
# CONFIG_SHRINKER_DEBUG is not set=0A=
CONFIG_DEBUG_STACK_USAGE=3Dy=0A=
CONFIG_SCHED_STACK_END_CHECK=3Dy=0A=
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy=0A=
CONFIG_DEBUG_VM_IRQSOFF=3Dy=0A=
CONFIG_DEBUG_VM=3Dy=0A=
CONFIG_DEBUG_VM_MAPLE_TREE=3Dy=0A=
CONFIG_DEBUG_VM_RB=3Dy=0A=
CONFIG_DEBUG_VM_PGFLAGS=3Dy=0A=
CONFIG_DEBUG_VM_PGTABLE=3Dy=0A=
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy=0A=
CONFIG_DEBUG_VIRTUAL=3Dy=0A=
CONFIG_DEBUG_MEMORY_INIT=3Dy=0A=
CONFIG_DEBUG_PER_CPU_MAPS=3Dy=0A=
CONFIG_DEBUG_KMAP_LOCAL=3Dy=0A=
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=3Dy=0A=
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=3Dy=0A=
# CONFIG_MEM_ALLOC_PROFILING is not set=0A=
CONFIG_HAVE_ARCH_KASAN=3Dy=0A=
CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy=0A=
CONFIG_CC_HAS_KASAN_GENERIC=3Dy=0A=
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy=0A=
CONFIG_KASAN=3Dy=0A=
CONFIG_KASAN_GENERIC=3Dy=0A=
# CONFIG_KASAN_OUTLINE is not set=0A=
CONFIG_KASAN_INLINE=3Dy=0A=
CONFIG_KASAN_STACK=3Dy=0A=
CONFIG_KASAN_VMALLOC=3Dy=0A=
# CONFIG_KASAN_EXTRA_INFO is not set=0A=
CONFIG_HAVE_ARCH_KFENCE=3Dy=0A=
CONFIG_KFENCE=3Dy=0A=
CONFIG_KFENCE_SAMPLE_INTERVAL=3D100=0A=
CONFIG_KFENCE_NUM_OBJECTS=3D255=0A=
# CONFIG_KFENCE_DEFERRABLE is not set=0A=
CONFIG_KFENCE_STATIC_KEYS=3Dy=0A=
CONFIG_KFENCE_STRESS_TEST_FAULTS=3D0=0A=
CONFIG_HAVE_ARCH_KMSAN=3Dy=0A=
# end of Memory Debugging=0A=
=0A=
# CONFIG_DEBUG_SHIRQ is not set=0A=
=0A=
#=0A=
# Debug Oops, Lockups and Hangs=0A=
#=0A=
CONFIG_PANIC_ON_OOPS=3Dy=0A=
CONFIG_PANIC_ON_OOPS_VALUE=3D1=0A=
CONFIG_PANIC_TIMEOUT=3D86400=0A=
CONFIG_LOCKUP_DETECTOR=3Dy=0A=
CONFIG_SOFTLOCKUP_DETECTOR=3Dy=0A=
# CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM is not set=0A=
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3Dy=0A=
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy=0A=
CONFIG_HARDLOCKUP_DETECTOR=3Dy=0A=
# CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set=0A=
CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy=0A=
# CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set=0A=
# CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set=0A=
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=3Dy=0A=
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy=0A=
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy=0A=
CONFIG_DETECT_HUNG_TASK=3Dy=0A=
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D140=0A=
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=3Dy=0A=
CONFIG_WQ_WATCHDOG=3Dy=0A=
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set=0A=
# CONFIG_TEST_LOCKUP is not set=0A=
# end of Debug Oops, Lockups and Hangs=0A=
=0A=
#=0A=
# Scheduler Debugging=0A=
#=0A=
# CONFIG_SCHED_DEBUG is not set=0A=
CONFIG_SCHED_INFO=3Dy=0A=
CONFIG_SCHEDSTATS=3Dy=0A=
# end of Scheduler Debugging=0A=
=0A=
CONFIG_DEBUG_PREEMPT=3Dy=0A=
=0A=
#=0A=
# Lock Debugging (spinlocks, mutexes, etc...)=0A=
#=0A=
CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy=0A=
CONFIG_PROVE_LOCKING=3Dy=0A=
CONFIG_PROVE_RAW_LOCK_NESTING=3Dy=0A=
# CONFIG_LOCK_STAT is not set=0A=
CONFIG_DEBUG_RT_MUTEXES=3Dy=0A=
CONFIG_DEBUG_SPINLOCK=3Dy=0A=
CONFIG_DEBUG_MUTEXES=3Dy=0A=
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy=0A=
CONFIG_DEBUG_RWSEMS=3Dy=0A=
CONFIG_DEBUG_LOCK_ALLOC=3Dy=0A=
CONFIG_LOCKDEP=3Dy=0A=
CONFIG_LOCKDEP_BITS=3D20=0A=
CONFIG_LOCKDEP_CHAINS_BITS=3D20=0A=
CONFIG_LOCKDEP_STACK_TRACE_BITS=3D20=0A=
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=3D14=0A=
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=3D12=0A=
# CONFIG_DEBUG_LOCKDEP is not set=0A=
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy=0A=
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set=0A=
# CONFIG_LOCK_TORTURE_TEST is not set=0A=
# CONFIG_WW_MUTEX_SELFTEST is not set=0A=
# CONFIG_SCF_TORTURE_TEST is not set=0A=
CONFIG_CSD_LOCK_WAIT_DEBUG=3Dy=0A=
# CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT is not set=0A=
# end of Lock Debugging (spinlocks, mutexes, etc...)=0A=
=0A=
CONFIG_TRACE_IRQFLAGS=3Dy=0A=
CONFIG_TRACE_IRQFLAGS_NMI=3Dy=0A=
CONFIG_NMI_CHECK_CPU=3Dy=0A=
CONFIG_DEBUG_IRQFLAGS=3Dy=0A=
CONFIG_STACKTRACE=3Dy=0A=
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set=0A=
# CONFIG_DEBUG_KOBJECT is not set=0A=
# CONFIG_DEBUG_KOBJECT_RELEASE is not set=0A=
=0A=
#=0A=
# Debug kernel data structures=0A=
#=0A=
CONFIG_DEBUG_LIST=3Dy=0A=
CONFIG_DEBUG_PLIST=3Dy=0A=
CONFIG_DEBUG_SG=3Dy=0A=
CONFIG_DEBUG_NOTIFIERS=3Dy=0A=
# CONFIG_DEBUG_CLOSURES is not set=0A=
CONFIG_DEBUG_MAPLE_TREE=3Dy=0A=
# end of Debug kernel data structures=0A=
=0A=
#=0A=
# RCU Debugging=0A=
#=0A=
CONFIG_PROVE_RCU=3Dy=0A=
# CONFIG_RCU_SCALE_TEST is not set=0A=
# CONFIG_RCU_TORTURE_TEST is not set=0A=
# CONFIG_RCU_REF_SCALE_TEST is not set=0A=
CONFIG_RCU_CPU_STALL_TIMEOUT=3D100=0A=
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0=0A=
# CONFIG_RCU_CPU_STALL_CPUTIME is not set=0A=
# CONFIG_RCU_TRACE is not set=0A=
CONFIG_RCU_EQS_DEBUG=3Dy=0A=
# end of RCU Debugging=0A=
=0A=
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set=0A=
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set=0A=
# CONFIG_LATENCYTOP is not set=0A=
CONFIG_USER_STACKTRACE_SUPPORT=3Dy=0A=
CONFIG_NOP_TRACER=3Dy=0A=
CONFIG_HAVE_RETHOOK=3Dy=0A=
CONFIG_HAVE_FUNCTION_TRACER=3Dy=0A=
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy=0A=
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy=0A=
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy=0A=
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy=0A=
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=3Dy=0A=
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy=0A=
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy=0A=
CONFIG_HAVE_FENTRY=3Dy=0A=
CONFIG_HAVE_OBJTOOL_MCOUNT=3Dy=0A=
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=3Dy=0A=
CONFIG_HAVE_C_RECORDMCOUNT=3Dy=0A=
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=3Dy=0A=
CONFIG_TRACE_CLOCK=3Dy=0A=
CONFIG_RING_BUFFER=3Dy=0A=
CONFIG_EVENT_TRACING=3Dy=0A=
CONFIG_CONTEXT_SWITCH_TRACER=3Dy=0A=
CONFIG_PREEMPTIRQ_TRACEPOINTS=3Dy=0A=
CONFIG_TRACING=3Dy=0A=
CONFIG_GENERIC_TRACER=3Dy=0A=
CONFIG_TRACING_SUPPORT=3Dy=0A=
CONFIG_FTRACE=3Dy=0A=
# CONFIG_BOOTTIME_TRACING is not set=0A=
# CONFIG_FUNCTION_TRACER is not set=0A=
# CONFIG_STACK_TRACER is not set=0A=
# CONFIG_IRQSOFF_TRACER is not set=0A=
# CONFIG_PREEMPT_TRACER is not set=0A=
# CONFIG_SCHED_TRACER is not set=0A=
# CONFIG_HWLAT_TRACER is not set=0A=
# CONFIG_OSNOISE_TRACER is not set=0A=
# CONFIG_TIMERLAT_TRACER is not set=0A=
# CONFIG_MMIOTRACE is not set=0A=
# CONFIG_FTRACE_SYSCALLS is not set=0A=
# CONFIG_TRACER_SNAPSHOT is not set=0A=
CONFIG_BRANCH_PROFILE_NONE=3Dy=0A=
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set=0A=
CONFIG_BLK_DEV_IO_TRACE=3Dy=0A=
CONFIG_UPROBE_EVENTS=3Dy=0A=
CONFIG_BPF_EVENTS=3Dy=0A=
CONFIG_DYNAMIC_EVENTS=3Dy=0A=
CONFIG_PROBE_EVENTS=3Dy=0A=
# CONFIG_SYNTH_EVENTS is not set=0A=
# CONFIG_USER_EVENTS is not set=0A=
# CONFIG_HIST_TRIGGERS is not set=0A=
CONFIG_TRACE_EVENT_INJECT=3Dy=0A=
# CONFIG_TRACEPOINT_BENCHMARK is not set=0A=
# CONFIG_RING_BUFFER_BENCHMARK is not set=0A=
# CONFIG_TRACE_EVAL_MAP_FILE is not set=0A=
# CONFIG_FTRACE_STARTUP_TEST is not set=0A=
# CONFIG_RING_BUFFER_STARTUP_TEST is not set=0A=
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=3Dy=0A=
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set=0A=
# CONFIG_RV is not set=0A=
CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy=0A=
# CONFIG_SAMPLES is not set=0A=
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy=0A=
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=3Dy=0A=
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy=0A=
# CONFIG_STRICT_DEVMEM is not set=0A=
=0A=
#=0A=
# x86 Debugging=0A=
#=0A=
CONFIG_EARLY_PRINTK_USB=3Dy=0A=
CONFIG_X86_VERBOSE_BOOTUP=3Dy=0A=
CONFIG_EARLY_PRINTK=3Dy=0A=
CONFIG_EARLY_PRINTK_DBGP=3Dy=0A=
# CONFIG_EARLY_PRINTK_USB_XDBC is not set=0A=
# CONFIG_DEBUG_TLBFLUSH is not set=0A=
CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy=0A=
# CONFIG_X86_DECODER_SELFTEST is not set=0A=
CONFIG_IO_DELAY_0X80=3Dy=0A=
# CONFIG_IO_DELAY_0XED is not set=0A=
# CONFIG_IO_DELAY_UDELAY is not set=0A=
# CONFIG_IO_DELAY_NONE is not set=0A=
CONFIG_DEBUG_BOOT_PARAMS=3Dy=0A=
# CONFIG_CPA_DEBUG is not set=0A=
CONFIG_DEBUG_ENTRY=3Dy=0A=
# CONFIG_DEBUG_NMI_SELFTEST is not set=0A=
CONFIG_X86_DEBUG_FPU=3Dy=0A=
# CONFIG_PUNIT_ATOM_DEBUG is not set=0A=
CONFIG_UNWINDER_ORC=3Dy=0A=
# CONFIG_UNWINDER_FRAME_POINTER is not set=0A=
# end of x86 Debugging=0A=
=0A=
#=0A=
# Kernel Testing and Coverage=0A=
#=0A=
# CONFIG_KUNIT is not set=0A=
# CONFIG_NOTIFIER_ERROR_INJECTION is not set=0A=
CONFIG_FAULT_INJECTION=3Dy=0A=
CONFIG_FAILSLAB=3Dy=0A=
CONFIG_FAIL_PAGE_ALLOC=3Dy=0A=
CONFIG_FAULT_INJECTION_USERCOPY=3Dy=0A=
CONFIG_FAIL_MAKE_REQUEST=3Dy=0A=
CONFIG_FAIL_IO_TIMEOUT=3Dy=0A=
CONFIG_FAIL_FUTEX=3Dy=0A=
CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy=0A=
# CONFIG_FAIL_MMC_REQUEST is not set=0A=
# CONFIG_FAIL_SKB_REALLOC is not set=0A=
CONFIG_FAULT_INJECTION_CONFIGFS=3Dy=0A=
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set=0A=
CONFIG_ARCH_HAS_KCOV=3Dy=0A=
CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy=0A=
CONFIG_KCOV=3Dy=0A=
CONFIG_KCOV_ENABLE_COMPARISONS=3Dy=0A=
CONFIG_KCOV_INSTRUMENT_ALL=3Dy=0A=
CONFIG_KCOV_IRQ_AREA_SIZE=3D0x40000=0A=
# CONFIG_KCOV_SELFTEST is not set=0A=
CONFIG_RUNTIME_TESTING_MENU=3Dy=0A=
# CONFIG_TEST_DHRY is not set=0A=
# CONFIG_LKDTM is not set=0A=
# CONFIG_TEST_MIN_HEAP is not set=0A=
# CONFIG_TEST_DIV64 is not set=0A=
# CONFIG_TEST_MULDIV64 is not set=0A=
# CONFIG_BACKTRACE_SELF_TEST is not set=0A=
# CONFIG_TEST_REF_TRACKER is not set=0A=
# CONFIG_RBTREE_TEST is not set=0A=
# CONFIG_REED_SOLOMON_TEST is not set=0A=
# CONFIG_INTERVAL_TREE_TEST is not set=0A=
# CONFIG_PERCPU_TEST is not set=0A=
# CONFIG_ATOMIC64_SELFTEST is not set=0A=
# CONFIG_ASYNC_RAID6_TEST is not set=0A=
# CONFIG_TEST_HEXDUMP is not set=0A=
# CONFIG_TEST_KSTRTOX is not set=0A=
# CONFIG_TEST_PRINTF is not set=0A=
# CONFIG_TEST_SCANF is not set=0A=
# CONFIG_TEST_BITMAP is not set=0A=
# CONFIG_TEST_UUID is not set=0A=
# CONFIG_TEST_XARRAY is not set=0A=
# CONFIG_TEST_MAPLE_TREE is not set=0A=
# CONFIG_TEST_RHASHTABLE is not set=0A=
# CONFIG_TEST_IDA is not set=0A=
# CONFIG_TEST_LKM is not set=0A=
# CONFIG_TEST_BITOPS is not set=0A=
# CONFIG_TEST_VMALLOC is not set=0A=
# CONFIG_TEST_BPF is not set=0A=
# CONFIG_TEST_BLACKHOLE_DEV is not set=0A=
# CONFIG_FIND_BIT_BENCHMARK is not set=0A=
# CONFIG_TEST_FIRMWARE is not set=0A=
# CONFIG_TEST_SYSCTL is not set=0A=
# CONFIG_TEST_UDELAY is not set=0A=
# CONFIG_TEST_STATIC_KEYS is not set=0A=
# CONFIG_TEST_DYNAMIC_DEBUG is not set=0A=
# CONFIG_TEST_KMOD is not set=0A=
# CONFIG_TEST_KALLSYMS is not set=0A=
# CONFIG_TEST_DEBUG_VIRTUAL is not set=0A=
# CONFIG_TEST_MEMCAT_P is not set=0A=
# CONFIG_TEST_MEMINIT is not set=0A=
# CONFIG_TEST_HMM is not set=0A=
# CONFIG_TEST_FREE_PAGES is not set=0A=
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set=0A=
# CONFIG_TEST_OBJPOOL is not set=0A=
CONFIG_ARCH_USE_MEMTEST=3Dy=0A=
# CONFIG_MEMTEST is not set=0A=
# end of Kernel Testing and Coverage=0A=
=0A=
#=0A=
# Rust hacking=0A=
#=0A=
# end of Rust hacking=0A=
# end of Kernel hacking=0A=

