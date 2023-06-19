Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69195735B83
	for <lists+linux-can@lfdr.de>; Mon, 19 Jun 2023 17:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjFSPuW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Jun 2023 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFSPuV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Jun 2023 11:50:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F321B0
        for <linux-can@vger.kernel.org>; Mon, 19 Jun 2023 08:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDs6+SGoeCHwxX3fCWnZW6QPgy1LCBhSS462GLetLhNEjuzaBm6ex3k53o+ENnKrM26j3/E29YthnL6BCXs/CXKpjXH2zyQHAV1u5T3reMH3BLeuDSzkPrZoRPeXbsE9WNmyBG+TsUJcuZN3sNGNUL4UGSfkYluL59g+FV4IQFfVl/N2mxgtNBqwj+VGjWO750MF8mDEZr/U5ZexoqUx3fZFDBODx4xfihaUm/2HgUUIU4w/y8SnNEH/aZql9AZQucr6VrmqcdfuzxszA6YuwhYyH1VnnBIrMN6gee4CqRZcmxzsnxMZEe3ktNjf9xCtX5a01pzycILv8Wm1xeljYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GXyJ6CXsD6KSItnsiJfxnQJW7+S4TPaJDoMk1ZihX4=;
 b=jwIbYASxbqaiuxIukjzw3ZWg0RggY6g+xJiFEYQwAyEBYJLyBmyqr1g7+VAMN9Lmr96hMu3fwwadJD+r1fGUxZnikg72FTYY+U9mNO6tQOB9izjzAQptrAUgH6ymcM/K77Ss2PsEKSk/382/vepF2aeuyhGME5/HSCmZPSFF9E1oanSme7h0oCB9RHIly6+y9SWZeYeBrnixdt4IQ5bVPEuEzGb0TuzTOGBm1zs/0RKEOY9S8QPMu2V62OODLFk8LABcpeclS+4SAJ0pairPMdcqPGujA67Z8TltBj4vgPXRGSEXo/o31zce575CdoP17Q91fIox8JNMHDvXd2eG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.de; dmarc=pass action=none
 header.from=hms-networks.de; dkim=pass header.d=hms-networks.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GXyJ6CXsD6KSItnsiJfxnQJW7+S4TPaJDoMk1ZihX4=;
 b=Su+IGeKuPw6+hKOU2zaIKjR79l7YuSROyDhmTkoBp+77Fkj9+5cCan82DIq4aj2uoU37Ah1YRhpIRSWZVXVRCzYbe4Q+X0z7N0+nDDXlwh/uaOpf4JMluDDrquPAmwxSqCJpDMDGxa+R8x8avZDDwuFqazbMVGTXgq3qifZUJTU=
Received: from AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22)
 by AS4PR10MB6182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:589::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 15:50:15 +0000
Received: from AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e8db:6122:7e2d:4340]) by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e8db:6122:7e2d:4340%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 15:50:15 +0000
From:   Markus Marb <marm@hms-networks.de>
To:     Eric Stahl <ericstahl@limntech.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH v9] can: usb: IXXAT USB-to-CAN adapters drivers
Thread-Topic: [PATCH v9] can: usb: IXXAT USB-to-CAN adapters drivers
Thread-Index: AQHZjOhoyejNGGpamUeld52KQTlLQa90CG8AgB5RiYCAABeZIA==
Date:   Mon, 19 Jun 2023 15:50:15 +0000
Message-ID: <AM0PR10MB3683650EC713AAB50CDE5A72905FA@AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM>
References: <20230522200144.15949-1-ps.report@gmx.net>
 <CAMZ6RqJ4gL35=8112ES1y4jW9k+AaDNRmCcL-rbUPXtRMnZb8g@mail.gmail.com>
 <afff3b9a-8d84-49c9-4fc0-a07a792d4177@limntech.com>
In-Reply-To: <afff3b9a-8d84-49c9-4fc0-a07a792d4177@limntech.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR10MB3683:EE_|AS4PR10MB6182:EE_
x-ms-office365-filtering-correlation-id: 609a2c36-1d50-498a-5f49-08db70dce005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GL5gJDEaNrYpTaPf/5QnTivHMTwkko2C+OsMOQZeM4H9WsEkwh7FtmUCzchcZ6gUAxGhnSUDlnhJYu+Lqnzy6W4UrCjYbJDaxwzQQhPaVaJJkAsFpcuDGdp13ssBFjXyNdXolmsDTtG2lygYdMTM44gVi+/j5OjdG179WJap/fh0PX5mYF/2nQ8jFAQj+qlk7qIUC+aDmmrYZmlWBz3yuDK/K/8I2I7pEJz4aFXJqx+HO2nszjZDSiUYDx41EmZpjMt7AFJwPMOUEpad5MIVprJQs1sx85DLTOm//UJG/CvjE7ZVZUdRYOSPAwd2SZhm01A2EvPQHJQ3ZrIu5mt3ihUw1ZA8gG+6l+OzrIsvFC6ftg0NPKPXnJqqnifLCjPqB9fmyT0Z1BcZ0CCEBBGo6yLvW+wLR1t3hF28rCoT7uV3huj/GTep2VCaF8D05lPUJ7+5d3tQuu0v8WlyaCPhfJfEBy+8FH6uQsVXTpjf7RqDifPCTqX1HWKaDtdLY+6DNm8dbJA1YvhBVk6nXy+AxdhQO0e6qEeSuEY64c/Rg4jalIkXjmDTBEVDxprRuYIdT67203lx3YjB8PPy7qkBoQd8X79713Sl6OelCucKmwzYSKsWnInRs4Yi6rcem1+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(396003)(346002)(136003)(366004)(451199021)(478600001)(2906002)(558084003)(7696005)(55016003)(86362001)(33656002)(71200400001)(122000001)(38070700005)(9686003)(26005)(186003)(6506007)(8676002)(76116006)(66446008)(66476007)(66556008)(64756008)(8936002)(66946007)(5660300002)(38100700002)(52536014)(316002)(6916009)(4326008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXR6c1JIUzEzSGxsbUFheXhNL2dyMG5OYnJpZFZNQjNvQi9sMFA3T0ZxZk1M?=
 =?utf-8?B?RnE5bjF1SitvakdMd1JtemVHdHdTSEFwRGlOVE54Y1E2ODJtZUJKV0EyZWxD?=
 =?utf-8?B?VHZsY1h3YlducElHR0txdVJRNkIwUmNOMHlxT0hwTkU3NStqOGNHd3NCbGFL?=
 =?utf-8?B?Smw2d2YrNVZFVCthSmZsenprdHQwQkNPdVNkQlY2U3Nxd1IyZTZuVHBoWjNr?=
 =?utf-8?B?TzY3VVA2bkVSc3d2RVJoS0l0eE44S0xkbDJTQXp6RytHZUR1ejhsMWV1S3E1?=
 =?utf-8?B?V0dkVkJGdU5iU2ovRkNuSnF2dnRGb2FJUVZmaFFaNHI4Z1IyMVdYaVJ5L1Bk?=
 =?utf-8?B?OHpKT0tCT21SSnovMXNVRVM2dUFEZ3hTbWhtbFEwalZXbXVnZ2IySUVlQ0JO?=
 =?utf-8?B?cnZzVlBrejFKL2xuR09WQkNMYnI4UTVoZG16bTB4OTNRdW1wdVZRYTIrM0pU?=
 =?utf-8?B?SDJpaktiSGtURVlvVFFEZlFlMTRWOHdkNis2OVllRE01WjJ6clBzNVlhZ1lN?=
 =?utf-8?B?djU3OXRiVGRPUkxXNm5MbmpZNWtFbXJJZ1ErSk5ubVFVT2lEbHlaeWlJMEEz?=
 =?utf-8?B?Vk92S0VaRnMydExQNjhWdGl5ZlNBcE5CZWlKK0FpTTJtaDd0ZXhXQWEyaVhX?=
 =?utf-8?B?REp3bitNNnk3M2hvRFpvdHJRckdpQ0pSVU9FWElIcUdxL2pwbmo0QVdXSGxv?=
 =?utf-8?B?ZnhqU1FnMEFYVXRTQXc2d0xDa0k0b2tyamJsOXZheGVSdjQ4TVRyV2krUWdy?=
 =?utf-8?B?RnBwSjB1TVNqQnFTZUg4L1FoS3Y4WUlyZlZ2MWY1SGNzcVRJWUg2NWZSbUJ6?=
 =?utf-8?B?dklSRmJ1bk5wMjd5SGMzK01CdkdzaVRmWmFwQ1hlSEZRZ0FyQVhVMVdTbk8r?=
 =?utf-8?B?VlBVV0h1NDM0WFJ0Mk81RnZWUkdPUnd5TWMzVTVVRmJyTXluY2xmWFBIU0ly?=
 =?utf-8?B?cEwvZ3JTc1ZUYTRVNUcrK3RxRDRaK0x1MUxlc3NNVDNYQU9KeisvNGtleWFM?=
 =?utf-8?B?KzJMeW5oZy9iWlF4bmt5T0U1RUxBZzluUk5WU2RXYnVadHQwM0NLTVhIVVNv?=
 =?utf-8?B?Sk14UEh3bEliREZpUkw4bWVjRXNBQnJWUVBHWitPREs0cEQxTUJmS2dvNVo0?=
 =?utf-8?B?NHV2Mkx3SlRsaWwzOEtTbnpZQzVQZlFUMGJIMWpaemxWMnBlWGhlQXQzbFN5?=
 =?utf-8?B?ZlQ0aFRHQjhmUGt2bVIwSGVlMWJuUFRRU09NdkxlZks4d1VpaE0rM3ZJNnl6?=
 =?utf-8?B?SnRUcGxPUHg5Rlh1cXMxb2s2SDBMMEtYaFh0S3VuOTV1R1RaTENubVR4Q0tS?=
 =?utf-8?B?ZEJma0ZFRk1HNXVNRWVOcXFncWFXcU5keEgvS09xSVBRMG5rbG00WHZzeDZh?=
 =?utf-8?B?OFU1anZqK0J5SFJubkFmSUF5WXFZMVc1RjdJdmd5ekF0V1JpSHVDcW9xTDBq?=
 =?utf-8?B?WjBrR0gxbEE5amowSGQ3RVZia1p5V1FEZ0JxdTJTZmJOeHcvMDhoS0wyblpp?=
 =?utf-8?B?NmNFdFRLT29UWHppNEZ0Zjg4TG9nUVBKc3p3eW9QeUswMm5pY0ZaYkJyVFMw?=
 =?utf-8?B?RW9ZLzVlTDdWT2JkV1ExZ1JRY05VSW1BUlIrcVF2ZktuaHhhbi9LSzArK2t4?=
 =?utf-8?B?N1BIVVZ0Lzl3dHhmS3VvUDFYUUlIZjRBZ1RSUUZBN3JDVUNQN2ROZjZuRXJC?=
 =?utf-8?B?dGdBMGhIRnBQM1pEaFRpSnpDSUtncmpCdW1FR21BSjJDQXZTQldBOW1uWW1a?=
 =?utf-8?B?UUdWUVZaQTIrRGV0SFEzOFZqU3VZcVpnWG9HQVlWUVIwMVV2RVZBbUdCK2I4?=
 =?utf-8?B?VklhS3p2YUUzbVpLbVJsaERpZ0FMNGtaWjZQVjFubFdicTkvTWd6MGVIN3Fy?=
 =?utf-8?B?YU1rZ2dFQXNXTDN1YmxhRncwRWZlMUV5S1dUUCtKN1lYWG5JQlJhOGRYYTBr?=
 =?utf-8?B?dnhYNncrQzFxeW0wTUZvbHVNYzFDd0lmenRjeGVGbEVBeS9wMVFTWXk0dEZ5?=
 =?utf-8?B?RmtOOVhhVWYrWU8wYzB2Nkx1ZjdCazZRYkJabmhLcGJYcTcrOEtVWnFYSy9K?=
 =?utf-8?B?Sy9kTU51RjVPRUFUZUhNZlNXVklxTzVqZm43TUE3bllYQlB2OUNTZTk3ZzFx?=
 =?utf-8?Q?adi0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 609a2c36-1d50-498a-5f49-08db70dce005
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 15:50:15.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnMEuwO2pzVQIP7kaPqHLtxFCJoalWnfRfZOdlrhkFDUFyXEVxw0woAgXXnlq3Oa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgRXJpYywNCg0KT2gsIGl0IGlzIHRpbGwgYm91bmNpbmc/IFRoYW5rIHlvdSBmb3IgdGhlIHJl
cG9ydCwgSSdsbCBoYXZlIElUIGxvb2sgaW50byBpdC4NCg0KQmVzdCByZWdhcmRzDQpNYXJrdXMN
Cg==
