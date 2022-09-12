Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4E5B53B5
	for <lists+linux-can@lfdr.de>; Mon, 12 Sep 2022 07:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiILF4Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Sep 2022 01:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILF4Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Sep 2022 01:56:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F826101
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662962180; x=1694498180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LeCyjtbiBnowa0QZZnq85Gpja84tFTaUQge4VkT3R7M=;
  b=Mq8JVkYamtkA5/uiye9iKse6K6TdycKgJ+eGTEUPXvatI3AwWdAKXnN8
   txv66d367F0lbQya8r0mf5nYBvMl0+1hHbYU39XUoU2lACTvo82mEcvQZ
   /tXb0Ix2Lz+dSF6Ua2YZ04M44BUFIecZhcHMemM46ge7PMXHVsHwve0Cr
   29GG5KxdZV7GLuI1g+igBR5YTqJXFm6yKNkkL6skswTKgtjBCr90cFHgQ
   GKsFNnY2CT2bYXoY2Yz4G+Swzz+Dnzf7Wr3abomk1vHWlZkwreeUfw7AK
   fPk2x6p8ge+9V5yEb2ed935eGQOjB/g5Tiu2aHAnBqYpuU31guHnRKKqO
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="113169933"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Sep 2022 22:56:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 11 Sep 2022 22:56:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 11 Sep 2022 22:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWkQlefVq4SJm2QdDzY7rNAxvcO4DjDCiww786ns3tkpWQBj8oDl7qoh1szjYxIAGi05kliqpxkwMIgVQ2pC7qUxVgsnYWjpOxWzGmaWEY6n6KhU/ejIoEKOA0jm12ht8iZZMuaFF/2RLIw85FZi1BAJbar5lDWqw1U9WopMux7RdP2V/dw1cIJYstN//7KNpi0Sk39p6Fvqp2XnLk5k2DKUaZh311//A3ffE/7pnusDSbHZ/QXTfU9JhYxbwL1m8DLNn38gR0pWUfzxJ/tSxY6ZYTymnKOvrPkLHKrPyfC352MKDx8Yuw74qPpbQL6my2ZK/xADRkaJWvmiOhD6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeCyjtbiBnowa0QZZnq85Gpja84tFTaUQge4VkT3R7M=;
 b=Or8qGgbXf/0Sp9Ohvvy3J+dyp5MWUoZHywu0l+GspPBLZupmodr1WQQ0Ti0g8qPEZUK0WOAsFPMjxCnI9hwiTQbJWSOBbL5NwYI327UVFj2OvniZ4ZLSQACwgbD9cJOVh10aCqDT+I1V5NKxGIAzgrgF9igH0+EDqNAsDBJgv75XW7JxgoKXli1IbpZoUDqPL+vDCIM/xUBUB2vtLGULS8OkgQHMeHzIGPx3qRymaWYAMYa8FurLfZZ2j5vXHTzy1nbAJgc283SM7Hqw3BwJLi45vygzYcbIY3z+EO4iyTuXXjR5wGq8kQG1JZokzdT9BK1H9POA5hzMyOGIHN0kNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeCyjtbiBnowa0QZZnq85Gpja84tFTaUQge4VkT3R7M=;
 b=AtceGhvV1WKs9N0dizbSTU4NoO704if/F3JLCrIOaV+4h7sMC7pezlq2GWcWeIJG6Mx2S12dVFpHCu11FX2xS7yZcnf1LH9GsXQdmA6+N6k/kpGOtPx6lfM2ChlGZSDTgTg9hLcxGDxTEpYvy/mrbbaGK/xuWApJrFCLiAYEUzs=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by SA1PR11MB6942.namprd11.prod.outlook.com (2603:10b6:806:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 05:56:15 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c85d:9586:fe68:476]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c85d:9586:fe68:476%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 05:56:15 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <vincent.mailhol@gmail.com>, <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <mark@baggywrinkle.co.uk>
Subject: RE: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of
 min3()
Thread-Topic: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of
 min3()
Thread-Index: AQHYwqZenOUWK016+kGFWKotr+9Bw63Z6mSAgAFmw2A=
Date:   Mon, 12 Sep 2022 05:56:15 +0000
Message-ID: <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
In-Reply-To: <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|SA1PR11MB6942:EE_
x-ms-office365-filtering-correlation-id: b4fc3b7f-4824-4340-1169-08da94838112
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwAqdhg9Ha+6w7L30HfcyUCBwnUjRn/nUCP46+E1NuPyObr0z9TvXFvI0b4kYASquG5jRir7dTenr6i9oM3mFdka/hVcekhA7jcFRWRpvky99fWhuZvBDNvCh0dOKPu958VOZDTTJ0dGA4GhIFN9wkFeDozx0QBqm9W88l9FCdH6Pl97y5wVg4NtF+g4ZwM7RilBwhwVwSoGOX8BlqQlYOqK97y/3J3YGbhePLev1N4s7orVbw+HOBMpKJF0Fyc5l0HBlgcYW5snUuhbHuYQubpU/H8X0+QZ6WM5WxxZJ+67+fyp6UHawLeOuENOquH5YLFseZkdYT2mR33L+dTpG8aQsGydpOnZ5f5pmObFBhTHFm62hAd8G6rLMmRB+3W14x8lDxiD5lMvKEApSA5q6SAR/IbnFaIGpzORYDm1PMns7sj7OcQokIH7HSN+lFsde738xBlJO9PqxGLV56X6+svZSKDe4Y5SMDxan42TFBV3XPvfwx5cBhmh2yLm6AdCIg5kl68Ps+9i0k1MBcg8FZJIs1RX8/wSB1X8RIpTJ1ivo3N5GOqE9jZ+2tgKMXy0R+GOqAMlE/gl4hH31laC7uzTO70oeeFxehjMWJsmISFyIhWXfJWWDrf2GPaPBLDe/dmFN1XBKOOdI2xt0m4DQb+7489prhEhjZcPglI1tgzFfigUee5q1rOq9ShvfM+0zjrD1T8If9VuLH8/ie1gIZ5lA7hSKn1EePRFR2QJ1vgWJdYa9yqqr5OYQ3rnXLIU3qL2yFCacA0wmF+ZtjCexw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39850400004)(136003)(346002)(55016003)(41300700001)(478600001)(71200400001)(54906003)(110136005)(33656002)(66574015)(316002)(83380400001)(186003)(38100700002)(5660300002)(122000001)(2906002)(76116006)(8936002)(52536014)(6506007)(7696005)(26005)(9686003)(86362001)(38070700005)(4326008)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmcyNzhCNGxaNzRCQXI3emV3a1BHbnhCVnZJWDIyeGQrNFhPVEdIb01XY3lJ?=
 =?utf-8?B?c0lkdGZITlE5WFZ3YlhxZHh2UnBnM2lXMFc5NWtJSk5oMEptQldwYW4vdHl0?=
 =?utf-8?B?SVVDVnFDZldiL2lkSStFM2VuY0JMNVUvYmx0Yk9YL0QrVDdkVmJJWUhoakJr?=
 =?utf-8?B?THBseXdmdnFqcVY5bDVEVkpOK3BNQUN6cFR3VTBKUng5WkVEbGdGdnNuUFkx?=
 =?utf-8?B?WlJaamFSVGRwVjJORExVVGJ6eVNHSlpuNlVxZkx5MkRuc0dJcWhzbzYwTXZY?=
 =?utf-8?B?MmJpcnBQRzBodHJlT1hDeEFMNW5lQUtXV1htL0ozUnFGVVU5dUM3MElmd2xp?=
 =?utf-8?B?dXZxd0duQlR4N0VoTW5zdUlXMllsVFk0eWV5SnBDTU56cTNENFdrQVhhTm8w?=
 =?utf-8?B?Rm9MaUc0T29xVXVoWVEwWmFaUUhDUXJjSUVkd1VvUVNtQVEwZWsrV3pHNVhy?=
 =?utf-8?B?cVppcm1YYnZxRXNWOTkrY1MySDRPZWJSbytwc3dLM3RPSWV0cnNZSDN5NUNE?=
 =?utf-8?B?azhBWW5NQ3NNVE9uQjQyZU9NSlRmVGpoQytDSmVRT3BWRmg2REpBdVVZQ2o5?=
 =?utf-8?B?NC9sVUZCTFg4emhiSmVodUlhaGQ3b0xleGd3YkFGYWZsdUhBS0lkZnJMYkN4?=
 =?utf-8?B?QjBwQVB0TytSY1dyY1h6R1NaeHp5MEo4eUVGS0Vrd3FBZmpiNDIvcGM5cXo1?=
 =?utf-8?B?R0pSRG42bGdjRFBrMGEySTVUM0NweThHV1NMcnpJUTFoYmNFZ2YrSklGK3lZ?=
 =?utf-8?B?V3NOYVhxbEM4eWlrMFJTQnNORlJGcllSdnVsQUpibVd3eGNzZ1c1RTJzRXZX?=
 =?utf-8?B?NExCbGxudTFYbnJIaHhMT0pBVmtqdkJraFBJcDlHeTZjUHMwbkxUZDhKUytu?=
 =?utf-8?B?dUtaWFhvejJPM1dyUjRsTmk5My9jRTV5QzI4dXo3dUtFK0JyVUVDeWpUT21R?=
 =?utf-8?B?RlRXYzg4WXRHMlpTTHovV25wU2Z3RzlEZU16MVI1TTlRUjNabTRNc1BURjNN?=
 =?utf-8?B?S1Ftb0VaMnFNelVUWWpZa3lOTDBkMi9VWUNIcVBBRG1MRlI1M0pVTDUzdDZi?=
 =?utf-8?B?RlZuSS9vMENKZG90N1pCeWEzelV1UTN4aGp5cjEvdThjOFk1MU8rVGU0SEtq?=
 =?utf-8?B?ZlM5bys5Q2J0Nm5UV2VzTmNHUkdmRHJ4bWJYMWZGRGJhL1pCcTRsbkp1RkJo?=
 =?utf-8?B?UUtEQjd6TkFEV3Z6Q09FMS80U2F1Vm8zK1RpMFNkSHJqaHhVZitTd0dmdERa?=
 =?utf-8?B?QWJPdXZUU1NKandtT1pxTEI4cmZtZzlSRnByT1owekVMdlZxMUp2NFJRTXEz?=
 =?utf-8?B?cUJHZXkyQW1vbmRWNi9hVGREL1E0aHRTa3g2RmpmVWNXVzgxM2ZyekxBaUhY?=
 =?utf-8?B?bzBoNWh2MzVDSzhVRm1sZG85UTdUZjJhOFZJMVY3QWMzbDVoenl4SGVFcFFt?=
 =?utf-8?B?K2pLdk93K1IrckRDd3ZDbDdkQjZwMXpNUmQxbUJ1c3hjR3JkYTd0UXZsdE9Z?=
 =?utf-8?B?VzFmbnlOTHNBQUJWOE04azZUZmdMSUcrcVZveDB4RTNhd2Y3Zjk5ZHBPZjlH?=
 =?utf-8?B?bk1CQkUvVmt5Z2o2cHlXRVh5c0hqTVFmbHk5VG1yTkVyaHUzaERFS29TNzhU?=
 =?utf-8?B?bndPWnljaU9URUlLRFRJOHV6V2pUR2Z2MUFmaEVrSUJPUndhRmxlSDRqeGZy?=
 =?utf-8?B?MkF4bnR2aDQ3Ynhwa0R2RTJ6UFVwclFVYzRXMWpOZGFsb1h5ZVZKYjdvT0Z4?=
 =?utf-8?B?K3IxOVEzajFTYVVKVVRnRnhNcHB3ck9aSE13dEtNRW1LLy96c3haL0dkQXFh?=
 =?utf-8?B?T0JmUkVWRjVZaW1QRUgrMVFScmREcXRVU0d3U0ZtdXdEZERXa1MyNzNaUFNO?=
 =?utf-8?B?R3preTdML1k4a3FnMU9lWnlya0dTSFptY2lVWXB3cmRZSXFubWxzTWlpOGFy?=
 =?utf-8?B?L1VPK2JJOUFXNWVDNm81RkhkSHJpTWQzSTNPV3JXbXFIRTUxL3d5aHFVWVV0?=
 =?utf-8?B?QlpJMU1UYTZoWCtUUlg1N2VMR2RCbDRzQzAwRy90dVMyRVdHbVgybjZjeWl3?=
 =?utf-8?B?S3lBZ1BvNG9wT0pFTzRZYUxpYnBJKzlMSHp6WjY5aUtKNVRwUVJvQWtldkRJ?=
 =?utf-8?Q?zrWgwdDzfwFNEYEA7439ljJJB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fc3b7f-4824-4340-1169-08da94838112
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 05:56:15.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAyx/zQ3TESsz7FxfeVQN5B+J6NezDc1KLqnjKj2LIOxqjldMi6utJjhxAULix8KJQDt5mFQy7BLUz8URc0YqQG+hKxzDrLbQEH+FydyLQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6942
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiA+IEluIGNhbl9jYWxjX2JpdHRpbWluZygpIHRoZXJlIGFyZSBzZXZlcmFsIG9wZW4gY29kZWQg
Y2hlY2tzIHRvIGVuc3VyZQ0KPiA+IHRoYXQgU0pXIGlzIHdpdGhpbiBjZXJ0YWluIGxpbWl0cy4g
UmVwbGFjZSB0aGlzIGJ5IGEgc2luZ2xlIGNhbGwgdG8NCj4gPiBtaW4zKCkuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9jYW4vZGV2L2NhbGNfYml0dGltaW5nLmMgfCA4ICsrLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL2Rldi9jYWxjX2JpdHRpbWlu
Zy5jDQo+IGIvZHJpdmVycy9uZXQvY2FuL2Rldi9jYWxjX2JpdHRpbWluZy5jDQo+ID4gaW5kZXgg
ZDNjYWEwNDA2MTRkLi5jZTZiZWYyNDQ0YTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
Y2FuL2Rldi9jYWxjX2JpdHRpbWluZy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL2Rldi9j
YWxjX2JpdHRpbWluZy5jDQo+ID4gQEAgLTE1OCwxMiArMTU4LDggQEAgaW50IGNhbl9jYWxjX2Jp
dHRpbWluZyhjb25zdCBzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqZGV2LCBzdHJ1Y3QgY2FuX2JpdHRp
bWluZyAqYnQsDQo+ID4gICAgICAgICBpZiAoIWJ0LT5zancgfHwgIWJ0Yy0+c2p3X21heCkgew0K
PiA+ICAgICAgICAgICAgICAgICBidC0+c2p3ID0gMTsNCj4gPiAgICAgICAgIH0gZWxzZSB7DQo+
ID4gLSAgICAgICAgICAgICAgIC8qIGJ0LT5zancgaXMgYXQgbGVhc3QgMSAtPiBzYW5pdGl6ZSB1
cHBlciBib3VuZCB0byBzandfbWF4ICovDQo+ID4gLSAgICAgICAgICAgICAgIGlmIChidC0+c2p3
ID4gYnRjLT5zandfbWF4KQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGJ0LT5zancgPSBi
dGMtPnNqd19tYXg7DQo+ID4gLSAgICAgICAgICAgICAgIC8qIGJ0LT5zancgbXVzdCBub3QgYmUg
aGlnaGVyIHRoYW4gdHNlZzIgKi8NCj4gPiAtICAgICAgICAgICAgICAgaWYgKHRzZWcyIDwgYnQt
PnNqdykNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBidC0+c2p3ID0gdHNlZzI7DQo+ID4g
KyAgICAgICAgICAgICAgIC8qIHNqdyBtdXN0IG5vdCBiZSBoaWdoZXIgdGhhbiBzandfbWF4IGFu
ZCB0c2VnMiAqLw0KPiA+ICsgICAgICAgICAgICAgICBidC0+c2p3ID0gbWluMyhidC0+c2p3LCBi
dGMtPnNqd19tYXgsIHRzZWcyKTsNCj4gDQo+IE5vdCBkaXJlY3RseSBhIGNyaXRpY2lzbSBvZiB0
aGlzIHBhdGNoIChhcyB0aGluZ3Mgd2VyZSBhbHJlYWR5IGxpa2UNCj4gdGhhdCksIGJ1dCBpZiB0
aGUgdXNlciBwcm92aWRlcyBhbiBpbmNvcnJlY3QgdmFsdWUgZm9yIFNKVyAob3IgYW55DQo+IG90
aGVyIGJpdHRpbWluZyBhcmd1bWVudCksIHdvdWxkbid0IGl0IGJlIGJldHRlciB0byBpbmZvcm0/
IFJldHVybmluZw0KPiAtRUlOVkFMIG1pZ2h0IGJlIHRvbyB2aW9sZW50LiBNYXliZSBhIGRtZXNn
IHdvdWxkIGJlIGdvb2Q/DQoNCkknZCBzYXkgaXQgd291bGQgYmUgY29uc2lzdGVudCB0byBrZWVw
IHJldHVybmluZyAtRUlOVkFMIChhdCBsZWFzdCBmb3IgdGhlIFNKVz4obWluIHAxLHAyKSkgY29u
ZGl0aW9uLiBUaGUgc2FtZSBpcyBkb25lIGZvciBGRCBCaXRyYXRlIDwgQXJiaXRyYXRpb24gYml0
cmF0ZSBhbmQgYm90aCBjb25kaXRpb25zIGhhdmUgdGhlIHNhbWUgbGV2ZWwgb2YganVzdGlmaWNh
dGlvbiBpbiB0aGUgSVNPIDExODk4LTE6MjAxNQ0KIlRoZSBkYXRhIGJpdCB0aW1lIHNoYWxsIGhh
dmUgdGhlIHNhbWUgbGVuZ3RoIGFzIHRoZSBub21pbmFsIGJpdCB0aW1lIG9yIGl0IHNoYWxsIGJl
IHNob3J0ZXIgdGhhbiB0aGUgbm9taW5hbCBiaXQgdGltZS4iDQoNCiJJbiBub21pbmFsIGJpdCB0
aW1lIGFuZCBpbiBkYXRhIGJpdCB0aW1lLCBTSlcgc2hhbGwgYmUgbGVzcyB0aGFuIG9yIGVxdWFs
IHRvIHRoZSBtaW5pbXVtIG9mIHRoZXNlIHR3byBpdGVtczogUGhhc2VfU2VnMSBhbmQgUGhhc2Vf
U2VnMi4iDQoNClNoYWxsIGlzIGEgYmluZGluZyByZXF1aXJlbWVudCB0byBiZSBJU08gY29uZm9y
bWFudCBpbiB0aGlzIGNhc2UuDQoNCkJlc3QgUmVnYXJkcywNClRob21hcw0K
