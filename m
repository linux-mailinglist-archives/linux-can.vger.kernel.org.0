Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E764967ADAA
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 10:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjAYJVq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 04:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjAYJVo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 04:21:44 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2070.outbound.protection.outlook.com [40.107.135.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C404A46D5C
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 01:21:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Knp79nIquTO6VrCea17A3/pzrP4SlwCyNa0NXJpPT5uzYJtKdY59qer3+nUNTPV9jp4rSwZdS6mBhFB0Wa5sQZE7EjJk+1vCBMkPGocZ3TKa5ZGHT9isUFLat9McWvOIzovy3ZaRFYwaG73Q5iCZomonoI97XWB1wLIokcLAEOOrzEdUFhLXFxD56x7xZMwYwmECnaWozi3AbHIdt1rWsFfgTqfq/5fY5A4e/8Uh8DlWKKwEWpRh5wey7Plx6H4yabmdF8THah82wEzD7lm9SPKEMxSYUBMn2qmHgnynsfo9oh15j48wBFuLA1a/U4HudtdksHx2M6SGPSakkuaf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL7cXoUksmutc2r8UIUJn2zTzefK1n/dA1NSvbnRYfY=;
 b=A+xT6WnhXnXr1uQvmSOSL66LypQaOvyKJGH3p7oyFVYNCxsQW6MElLbGO9YTD/aYQTrZeEFG1SvVrSBUZWdyc3JywiqiOhZrzK9L+gEHD6yZmi3PX+w/YbnTCFFNNI5LO/eu7x/6NmD++3qcRgmHpklINKn+eZ4uq2/6+o6SoUwLAV7YwY41O82z3k+OSzI7t/rYJtueK6GOqPhnUC7KQDCyVt2F1TQoCNSD3zdko2JMGo7BtQHzLSanW/EeZni0gVatCKSrN/iZW5JtANtfcdt1RJFxAQBrqBmT8pbX2wWKfHU4oVVE+XfkjRJSS6ps0euV3NN4BYn8kaTk7DXHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL7cXoUksmutc2r8UIUJn2zTzefK1n/dA1NSvbnRYfY=;
 b=yssXw0I4vQBV67H5kbieY473tJNExcHcZTojajrPdYrq9ZAMGa78hya43qAg1lF0KSUDM7vp74qi/jtt4OPf2WcP9MgBz+NQ7efO31JpRQuk12G/CE0hybzd9XKKTCn7gYuEQFLAptzjLXe8wTOIxeUpj6ADK5QOyzf3yvf2Zx0=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FR3P281MB1629.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 09:21:40 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fa47:ffd4:d4ca:76e1]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fa47:ffd4:d4ca:76e1%7]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 09:21:40 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Tom Evans <tom_usenet@optusnet.com.au>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Topic: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Index: AQHZMJCRtPZlzMMAzkyw+q4DrZcdvq6u192g
Date:   Wed, 25 Jan 2023 09:21:40 +0000
Message-ID: <FR0P281MB19663D7614B7A77DA4C6381A97CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
 <a269b5b8-a88d-d2da-5bcf-59f2aac40f87@optusnet.com.au>
 <20230125074226.k2pw7prjerab2l6t@pengutronix.de>
In-Reply-To: <20230125074226.k2pw7prjerab2l6t@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FR3P281MB1629:EE_
x-ms-office365-filtering-correlation-id: 1d5f0add-f0c5-43a9-137a-08dafeb5911f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MAz6p3AHN+yDIWvra49fk5dym4+UUZuWfmFhHAenpgp/CdWim678YPDVsRvQ9/xx75b7+AzGugJ35rUGPK8Y9YsH1KHgwB1zZEDKcHQIatK5sWdhVoLchqAbsc1cus4ucs5QxRTmk57AzI9tCTN/vvxaWCQUJTRr/rHTFRmhFwBEhAUw9BVDEdKqH5Zr+XB9m0o3vL9c/APRbMnUu5B5VDymtuy8Dpi+Ymhn/l0uCG9tCAZ67aSAr6HmEAEPXQCcAk4bBiej9gSaRqkb0V9kGwgaCWh81Yw8dWq6CjyxJFa0SjXOItGeNbe/6OjzdAYrVGGIlKu3foWzSqJP5HHEuExgAR7qAGQa6AUehu0WI/ZVUfAK8Z/A1Ayo3Ff0L8/ZZ4M7kK0WRVQH+EvOKuM7sRChnAJNMtmHwQYtoKsxw74Sz5aizDGjcKt75XHUrjmQ8YCvQrcO7tdRF8s0AV5rAJwOpUqi8ZH22IspVRTiCgOljTHiybHy1bdjYFqwngxNJbKYU5ofUb2jdxRr7DBjcX0RGi4mh3njVti7U1iQZyH42T25yqbHN5/9AIOjmhz4wYmSlf57AQq7oH/EWktKrb3wBAWrWnAPzLcAy3oLOwnXQ86e1A1mzGYTnFhRgJW5b6rEwINCz0cFA60QaN64dRHy84dhM1TG9eVBU2piM2w+26vG++otmnuo7OanyWZOiMCwCS9WzeawM8bUlQp3Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(396003)(39840400004)(451199018)(33656002)(558084003)(38100700002)(54906003)(66556008)(66446008)(64756008)(478600001)(8676002)(186003)(66476007)(71200400001)(9686003)(122000001)(38070700005)(76116006)(85202003)(110136005)(66946007)(85182001)(7696005)(55016003)(2906002)(86362001)(41300700001)(26005)(5660300002)(52536014)(316002)(6506007)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bCthT2ZEVGJRdWNYVzA2TTBnbGZQZXc3WDE2Zm1KOHRCcjFCcXBoTEdiNlFh?=
 =?utf-8?B?V3FodzJidy8xQlRZMXlNWDRXUlh3UjdLaUs1MW9iU2ZqUjJ3U3FqSVdGbnBQ?=
 =?utf-8?B?NjUvNW1pRUFJWWhmb0JJN2RMNTFVcHN3V1VZS0xZelRqOTNrd2c2WUVHVVZv?=
 =?utf-8?B?WDRPNEo5b1E3bHRNdnROaDdDRFFwRUN3N0VsN0JjaGNUVHNETCtBelZIWklJ?=
 =?utf-8?B?ZTdRT0dVZWJtK3ljVDN1bDdGdEhnSFFtdlpMM1lBZHBHR2FONms1YlYrRTFn?=
 =?utf-8?B?V0lmZXRxOU1zaDR3dFhPbmMzWEtLNy91TXRHN3B2Y0RIZHBwdUQ2dzRieG9j?=
 =?utf-8?B?ZVZjRktrRkNGUWlzVFZCNHA2S1pXYUtTbDFyNm5zZjlWa3hOMGJvWDM2L3cx?=
 =?utf-8?B?aG5oNy9vbTZ4VjQvREpDTGM1U1Ezc2toK0s1Z1pWbjRwK3BQaUZZTDd0Mmcv?=
 =?utf-8?B?ZmlBR1hDZ2FUcGtrd2RoaUlBenZVK1NsdGpiUHFIMlRaQnZpYlNhc2hXMDFO?=
 =?utf-8?B?VWNSRTJMY05sdUNzYWxOQm5jZkZLQTVMbzFnaFFvdmQ3S3RYVnhmbzM0dVdM?=
 =?utf-8?B?U2lMTzhUU1hoLzZYeVNwU3lKeS8yYk16cWYvVWpqWEZGNlVzYzcrbGJvR2lw?=
 =?utf-8?B?TG5HUnlENHZBS3Q2UXBydzlXdFFZc2JwUTdnNlI2Vjg0YkxKVlM4UVE1TVky?=
 =?utf-8?B?eTc1eEtxSGxzYlVheVBpdXV2WThvbUNkS01KUnVwaTVZQUNrSzJ2TnQ2RWF3?=
 =?utf-8?B?eU9uakc3TGxIVlhWSSswdjlsUzlzeS8yWFNJY3lVdEZwaG9xMENvQjl3OHdy?=
 =?utf-8?B?ajd6OG90SVJIallFdkpkUlJac0gyblFlY0lMS3BCZmtkTjErcDVUZkVueW5n?=
 =?utf-8?B?OHFEYXBmYTB1ZDR0SFNzMndkc1ZybFJQWkRxUnhBZkZzLy82Vmh0cFZGT2JD?=
 =?utf-8?B?QWdzTXlNTTFWUFdyKys5TFhGVTJwQVU3Qm10Q2pCK29BL0lIQm91YnFSVlN3?=
 =?utf-8?B?NWJ2UHRoQUZQM0t5bWhUQndUU1ErVjVzamZrejdYS09Pc3lIdmplZDhuTE1Y?=
 =?utf-8?B?azh0QmhpWHBKeUxScnl2ekF2NjlPdFhUVWFtYWFOeVRldlVSdDlQUDNYcFo1?=
 =?utf-8?B?UHBYcGNnWW5KSWVlQlRkRkVLRFZXeHN6U0c5UytIUTRtbndDMGw0Y3YyaUpj?=
 =?utf-8?B?QXdyWG1RUHZiK25FTjBydmplelZFVXl6RU5DUUh0MDNzZU5Rd3BjalAwU1M3?=
 =?utf-8?B?bmpEVFV5KzcxNEZhOVEvcm5FYWpJSmhNNXA5RlR0UW1ocjBlVUp1bmp4K0Uz?=
 =?utf-8?B?cmV4MVBtQjlzbkQvV3lkSEd0RjFCQU0wcG40NHV5RW9qVXI2T05YbkZndS9l?=
 =?utf-8?B?YTlMZkp0QVA2WkhpdGNOc3V5aVM1NC9LRys2S1V6NkF3VHNVU21uR0psaHI1?=
 =?utf-8?B?VVo5ejJHeHdYTDRPRFgvZXlCaVhyK2pIRkZEd21iNmhjdC9Pa3pCOVhVYjJo?=
 =?utf-8?B?SGx0SnIwbHJqR2k4S1dtSHBqWTFraVd1UnQ2Z1NsRWVjS0FwTyt0ck5hbU9C?=
 =?utf-8?B?SFlGSyswVC9zOFJBWlRhdmRXR0Q4VDN0T2ZDQ3BHL0xsNzRmVDczWTdaTmFy?=
 =?utf-8?B?Wno0anI2RGpQcFRVcU9hMXltajB4WlJrdHhuSWNza2hLM0NsbUdrYUd4cGJL?=
 =?utf-8?B?K01HUDJ5VHRTanlTVVNqRmxoblE4b2xmSlljYlZOS3Q4aXV6OGRVWDRCRDBG?=
 =?utf-8?B?OTE4UmpRL0l6R1RQaEp4SXhUamNISlEyL1F5OGZ1dXdOQ2x5eCtYZE5RN2R0?=
 =?utf-8?B?bElzQm9WcUczY25iU1M4eE9WVSs0aXJyRUNKb09VWjc2dnhGTUt2WEcwekNx?=
 =?utf-8?B?ZDVIN3hMWGJlN0ZNOVdJdVltbU5YUldNN2xnR0djY0daKzlQTWgvK0RBVDli?=
 =?utf-8?B?d2JFY3J0RTVyaVJ2U3hJTUFYdzRNNXRqY2cwZS9EcENFNnNJSVpxQmMyVTlP?=
 =?utf-8?B?aDNxZGVBU1RmUUZic1Jnam1wZ1lQWDhJckZibUFabEdMKzVNbDhrMFkrSGl2?=
 =?utf-8?B?SjRjbEloQXN2TWl5WFRDVUJYYk02UmVidTVKa0FlQVFwcXVwa3VmSDNFUjlo?=
 =?utf-8?B?WWVyRUhCWXpBZkNmcTFwVjFsT2FlVXJiTmdodXRhMVdWRFVoUjZZSUZSd0lt?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5f0add-f0c5-43a9-137a-08dafeb5911f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 09:21:40.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtC8PgTnJNY/SSPNpdce4Vq/LLvAQpYwejchgd2FMo91CfZtCeRuQxNkRdFW1bPCH8KYeB8sT2mvo7dfxxoXLMdj/Kxp94kL1xz+9Ec24W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1629
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBJbiBTdGVmYW4ncyB0ZXN0IHNldHVwIG9uZSBTUEkgYnVzIHVzZXMgMTYuNjcgTUh6IGFuZCB0
aGUgb3RoZXIgMTAgTUh6Lg0KPiBTdGVmYW4sIFRob21hcywgd2hpY2ggY2hpcCBzaG93cyB0aGUg
cHJvYmxlbT8NCg0KSXQgaGFwcGVucyBvbiBib3RoLiBUaGUgcHJvYmxlbSBkb2VzIG5vdCBzY2Fs
ZSB3aXRoIGZyZXF1ZW5jeS4gVGhlIHByb2JhYmlsaXR5DQpvZiBoaXR0aW5nIHRoZSBjcml0aWNh
bCBjYXNlIHZhcmllcy4NCg0KLS0NClN0ZWZhbg0K
