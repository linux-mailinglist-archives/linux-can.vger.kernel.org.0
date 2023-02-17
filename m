Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28CD69AFC9
	for <lists+linux-can@lfdr.de>; Fri, 17 Feb 2023 16:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBQPwj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Feb 2023 10:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBQPwi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Feb 2023 10:52:38 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF45FBE4
        for <linux-can@vger.kernel.org>; Fri, 17 Feb 2023 07:52:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW0ttrQSIxPbIAfuT3biJe1QmSiyLchTxyQ8SC4UJi/IXz53UlHBFDf6G2ZHkBiqM77wJurvqlwwZe4bApwADJIrAFln/BVvETr7T+jPGRGdU2Q7dRP8wAqwSUtU136rJjCHxDHxLsNLERtgSoZjwEX1mGGMBcRSRTURSw6eyP+68FEYmPdBAAwWIsf/pD+ddN3RuqGwiczPoM/RWbKr3hQr1IhyCKr9yajIUwKiHMMXMsR0j6u15O5HiUf6C4CWFYd+Z9w4nvpAFFJ7vFrl9bg2HrbkMNK9pZAXFJs0BkF3u+elsxVVwAEja7NZE4+vskGqnlt86WRgKnquj31zLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2FzkVmXEJGKebtRbXd05T/kbcpZofnAk2dYpV89SRY=;
 b=oXyy4giELWlXiGGxs+8C0WQX1IkBXnq/KWCg5PdVj8uZjZsFVyRipd843oZFn1soNuY7sBiIiclVGPD2HI26h3zI+i9lZpwwuC/LZCXl2olTSPnDiEBNPy9NcDyFv2c/CqBNoNFeWBqIfthSiGRSsmQP4wH9QVVCGcwsRl3Hzx2+BDPNzJf1GJNPavBKM7gOzNXfNedS0ogJVBZ0675H+yYeWfxMCFPwNA+E/2ddWZE7vrzA2vRMbYZEG5moB6mHjG2KVFNRrSoIta+dpWV+apsAxSnAyfc5mV0j6cuTEyZxkdiJfgTpC98qNEzJv1THzkcUsTg4eCoEgFiA2b1P1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=visionengravers.com; dmarc=pass action=none
 header.from=visionengravers.com; dkim=pass header.d=visionengravers.com;
 arc=none
Received: from BY3PR01MB6515.prod.exchangelabs.com (2603:10b6:a03:356::12) by
 MW2PR0102MB3419.prod.exchangelabs.com (2603:10b6:302:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.15; Fri, 17 Feb 2023 15:52:33 +0000
Received: from BY3PR01MB6515.prod.exchangelabs.com
 ([fe80::523f:b55:348c:22f6]) by BY3PR01MB6515.prod.exchangelabs.com
 ([fe80::523f:b55:348c:22f6%9]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 15:52:33 +0000
From:   Hartley Sweeten <HartleyS@visionengravers.com>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Michal Simek <michal.simek@amd.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: xlinix_can: bug when sending two RTR frames
Thread-Topic: xlinix_can: bug when sending two RTR frames
Thread-Index: AQHZOzUfWBTdxO8rPEqAP4DTfIcja67G6HAAgAqSEYCAAEKXMIAAH3wAgAF671A=
Date:   Fri, 17 Feb 2023 15:52:33 +0000
Message-ID: <BY3PR01MB6515AB04C38C68ECD442961BD0A19@BY3PR01MB6515.prod.exchangelabs.com>
References: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
 <a2256c85-4253-dff5-fa8e-00fc02916095@hartkopp.net>
 <ea15524a-1ed9-0dbb-9511-c333a66a2555@amd.com>
 <BY3PR01MB6515CC4390A51A5564C69634D0A09@BY3PR01MB6515.prod.exchangelabs.com>
 <5b5acff7-30ee-433c-ab59-59da4b371a49@hartkopp.net>
In-Reply-To: <5b5acff7-30ee-433c-ab59-59da4b371a49@hartkopp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=visionengravers.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR01MB6515:EE_|MW2PR0102MB3419:EE_
x-ms-office365-filtering-correlation-id: 324850f8-cfdb-4bfc-5970-08db10fefbef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jguxM7+Cf88vnEC/bnetWxfGJQI/CDu46msMfDbaXeuhf4sSH4sej6Ea8mJHG0v8F7XCFbzz3RQ1VC0xZ8FtkpaPxE9J4PmLm8RVQeN6tbb4RtX18cA4LQwmmkz+jth2k0AlJHy6YJl7HwlXP6fJfgAyvcOyuARAviIUJW/HgrF6m30X/ZSSRklIMc9p1p+KPB/wBCrxdLVd2r/iDvnnn4M4ijkPF2jrSxsqoCunXnu0iknLxN/KRRVZonTSHXfJran9qiuDS3pkP0a9qdXfdBhQRizlHI/Osn9u14LxjR1pxu0XmkBEnAONo3ZtX7sA0tx2LvVhFRwAfvuxBPU/Pqet6AGEORckSWtWm8ITsmRU2XMaG04D8R6nX149prSEym9JON3788rdB9S+falDRyS7Lbq1eSdgis/TVAtpauOfpBd9bweA73NDKfK75rgRAKvHobtZoz9/K0isu8pSF4DZ5PaedvlYlWicXjVnFgLeCd9Ij9SnAWA8VCpmftQR/NISx3mlimZECJcmy8Ys5cuiX+bdjvNcS7GmFaO39i07VFYCoLEhrZQQC+d0WxG7qkXoYoiDtE6JnmAZlnYz7s0EX7nuY0ZjHVAnaH3ycu2T4uaG3zHX+9UjGt+1I+zSqG8VMWy/CHXDLmXpPPI5SSpn4H6A2GN/Iil4vXUY+PLfIuj+qcdUiExqA3xX9e9o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR01MB6515.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39830400003)(396003)(376002)(366004)(136003)(451199018)(86362001)(2906002)(122000001)(38100700002)(38070700005)(966005)(71200400001)(7696005)(110136005)(6506007)(53546011)(26005)(186003)(478600001)(33656002)(55016003)(9686003)(64756008)(66946007)(8676002)(66446008)(66476007)(66556008)(83380400001)(4326008)(76116006)(316002)(41300700001)(52536014)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHJjOTVVYnBaSGpqRUZ6VWVEZG0rR2ZMSlIyR0VsSFBCSDlSYU9QL1N2MXMr?=
 =?utf-8?B?TnFwd2lvZm5RdTZ5RWhZZmFDaStxOEtQUENpcmlMSFgybmZVSG00cVViU1Ro?=
 =?utf-8?B?eEZlank2Tld5YmFkVkRJQ3kzZGM3YnJvMEk3NHJEdjdCTGRSSU1haUlhcWtn?=
 =?utf-8?B?clRjazBwQlpBN0JaL1g3aWM0cDMrYy9VNnYzUDR3ZXpFdWpSeWhFdDJqWExk?=
 =?utf-8?B?TS9mSVRPUnVBQWMvZE1NYUxERzRseGVnTUprbFpXZnJ4RmxtL2JGY3JYMXls?=
 =?utf-8?B?MW9mc3hJNVJtaVQxSTdWcTN3eGkvUWNkSThuWEtFYWtmeUROaUNoU0pnNDNx?=
 =?utf-8?B?TTNUN1phbjNBd0ZVU2w5d20vOFo4K2g5dlJKRnRZd2kwMzdWRWZxbGh6NzRN?=
 =?utf-8?B?UkdSdmhGR0I3QnNsVUNZWlpVZzJaNGhGSXNkUHN2azFYYmM5Yk1teVBaNU5W?=
 =?utf-8?B?SEJjY1BJdzcrMjdEQXRrYUhOaEtzSkFLcHZZVGF2RXF0NHpsU1JjaHNHajU2?=
 =?utf-8?B?WUNIbUU1NnM3K3MwQm14VkJzbHFoQTZmZlBHWnZJcmhHQkFTYXFGZGhGWVoz?=
 =?utf-8?B?ak1TRS9YMVpMdUgyL1RwSkh5YzViVGh5eElyTlh6cm8vSjVCenUrc0NnYlJR?=
 =?utf-8?B?bVZoMVRBTjFnOFRqaXk0SWFvdkUzWndvZE1ZWlQ1M01aRHNtNlUxRVB5eFJk?=
 =?utf-8?B?aDd0RzRHbWZCZHpwSDJBTkRrQ2MyOE96N2tJVkVYRTZHckMwNnJqZVZFVS9X?=
 =?utf-8?B?SWtER0d1SzFqbnBTNHlBWFVvdTVyNHVHK1k0TEpDNmZ2akFtNmxPNVk0aGdG?=
 =?utf-8?B?SW9uYmNURnV4eHJ2NXVqLzhaVVhvY2tGUGtGcUJXRnZKQ1J4anE1YnJGVXVr?=
 =?utf-8?B?MUM5bmJYT1BvOFoxNkVUeUpxRnlHUWUvQVZIK1AwN3JOZWs0OHlDMlE5V1FN?=
 =?utf-8?B?Ny9QUTljNUFTeVdGc1Rtd09uU2pWcVhjOUdFWlNtMU5MZXRmdmJVRjlGYU5i?=
 =?utf-8?B?N05CaVI4bHNEeko1ZHlNMm9PY1hnUHVyeGVJY0RnVVJRRVovY0NxTDJTTjZE?=
 =?utf-8?B?U2N4SDJXdjhLelpPYU5ncE9RY2NmSDNUemJUaUpUTGlKR2tPQTJlMU96ZnJz?=
 =?utf-8?B?ZFBVVGZyeGFGMW92THUxS0xPZnNRUWsraHl6T3dLMk9NL2c0c1FFemhHYWRy?=
 =?utf-8?B?T2ppRnloem5LVUtrUDlaeUhuakhOMngrN202K1BiNFhid2dSTXlwZTQ4bmdr?=
 =?utf-8?B?ZFpwa1VaWllxTHJWa3BmV1Q5RVRaM01xNWM1NkVRVlBxR0xhM0tnMS9rZHYv?=
 =?utf-8?B?ZHRUWE5oUzhiZkVTMXdLY3Q3ZXR4cGFYZVhpYWJBQlcyMmQvQ0F0YXo5S2Zh?=
 =?utf-8?B?YThEWUlRZzdGVUNkVlVzNWdRZ1hBREkyUTNhSk5kMDJ0d0NXVGs4VE1vT0g3?=
 =?utf-8?B?RHNGSitvU1Z2QVlBWXJzR1BIUHFqb0R3ekdIU3Foc2xIY1Q2QTl5cHNNSGhC?=
 =?utf-8?B?RTQ5MjZGVUsvNG43UWZjaTdveWxwdzQ4QWFWbVM2Ym1hMDBrOHV3ekdFeTZY?=
 =?utf-8?B?aDhxMllIZTh0ZDdSOWw1aWpHTVk0NlVXU3c4WDNWYjJ3eVVESGNlV1Q5RWVj?=
 =?utf-8?B?M083cEpKOTNDdnFPa3VXNkhVUTBWK2hQcGJkVjVnTGhuZW9hUlpHd3BzVGFV?=
 =?utf-8?B?UW9FK0xQWHp3alRxZkd6cGFwMUZDWitzemFmNThHVXRzdzhuTitNWHFsRW52?=
 =?utf-8?B?NFdBSzExVi9jQ2wra0s1MWh0bTdHUmlpNUxWUzRuV0RuV2tXLyt3Y0VWcmgv?=
 =?utf-8?B?N0FBS0EwMFdLNkE0STZlMzlKaDRNT042MVR3ZFVNWW5yaGNnWlB4S3pQdEty?=
 =?utf-8?B?dVgrMFAxQ21xc0Z5aHZHSzhHQ1hkaHcycEEwNTBqbStzSFc5Y3BVd3lNRXBu?=
 =?utf-8?B?b2hUdTJGWkFlT0NqaVBNODc0ZFgrNHA0a3VteVpGZHJ2MTV5cXN6c2U0dDBF?=
 =?utf-8?B?a25henp6aEpXQnlyL2R4YU13VWIyaC8yOG9JdjNOV3hWNlN0SzlLYlBic204?=
 =?utf-8?B?aUttLzBTaWhqTTZaUXNlcnBvcm1CcFhhUEFRdjJYOEltc0I1WDNsOWhMSlJB?=
 =?utf-8?B?dENBMjNmMUx0Mm9pejFINnFHcm9sWUUzVmhkZDJJbkZnTDd0bXIzZVVMZHFR?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: visionengravers.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR01MB6515.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324850f8-cfdb-4bfc-5970-08db10fefbef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 15:52:33.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d698601f-af92-4269-8099-fd6f11636477
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxC3qxCfXs6PWCNXGtDsGAWT5mJF8OGkKoYpBhu/K23psQPp7u43KYs/2zGZhKRhQ3CFz6qht3XDQEEDz5bE3Bo61QVoggBA0iEIwOxIE3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

T24gVGh1cnNkYXksIEZlYnJ1YXJ5IDE2LCAyMDIzIDEwOjEwIEFNLCBPbGl2ZXIgSGFydGtvcHAg
d3JvdGU6DQo+IE9uIDIvMTYvMjMgMTY6MzQsIEhhcnRsZXkgU3dlZXRlbiB3cm90ZToNCj4+IE9u
IFRodXJzZGF5LCBGZWJydWFyeSAxNiwgMjAyMyA0OjE5IEFNLCBNaWNoYWwgU2ltZWsgd3JvdGU6
DQo+Pj4+IE9uIDIvNy8yMyAyMTo0NSwgT2xpdmVyIEhhcnRrb3BwIHdyb3RlOg0KPj4+PiBIaSB4
aWxpbnhfY2FuIG1haW50YWluZXJzLA0KPj4+Pj4NCj4+Pj4+IEhhcnRsZXkgU3dlZXRlbiByZXBv
cnRlZCBhIGJ1ZyB3aGVuIHNlbmRpbmcgUlRSIGZyYW1lcyB3aXRoIHRoZSANCj4+Pj4+IHhpbGlu
eF9jYW4gZHJpdmVyIGhlcmU6DQo+Pj4+Pg0KPj4+Pj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4
LWNhbi9jYW4tdXRpbHMvaXNzdWVzLzQwNSMNCj4+Pj4+DQo+Pj4+PiBUaGUgcHJvYmxlbTogV2hl
biBzZW5kaW5nIGEgc2luZ2xlIFJUUiBmcmFtZSAoZS5nLiB3aXRoICdjYW5zZW5kIA0KPj4+Pj4g
Y2FuMA0KPj4+Pj4gMDAxI1InKSBub3RoaW5nIGhhcHBlbnMuDQo+Pj4+Pg0KPj4+Pj4gT25seSBh
ZnRlciBzZW5kaW5nIGEgKnNlY29uZCogUlRSIGZyYW1lIHdpdGggJ2NhbnNlbmQgY2FuMCAwMDEj
UicgDQo+Pj4+PiB0aGUgdHdvIChwZW5kaW5nKSBSVFItZnJhbWVzIGFyZSBzZW50IGRpcmVjdGx5
IGFmdGVyIGVhY2ggb3RoZXIuDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBmYXVsdHkgYmVoYXZpb3Igb2Yg
UlRSIGZyYW1lIHNlbmRpbmcgaXMgaW5kZXBlbmRlbnQgb2YgdGhlIA0KPj4+Pj4gdGltZSBnYXAg
YmV0d2VlbiB0aGUgdHdvIGNhbnNlbmQgYXR0ZW1wdHMuDQo+Pj4NCj4+PiBJIHJlYWQgdGhhdCB0
aHJlYWQgYW5kIEkgYW0gbWlzc2luZyBkZXRhaWxzIGFib3V0IFp5bnEgYm9hcmQuDQo+Pj4gQXJl
IHlvdSB1c2luZyBhbnkgY3VzdG9tIHp5bnEgYm9hcmQgb3IgYW55IHhpbGlueCBzdGFuZGFyZCBl
dmFsdWF0aW9uIGJvYXJkPw0KPj4NCj4+IFRoZSBzeXN0ZW0gaXMgYSBUcmVueiBURTA3MjAgU29N
IG9uIGEgY3VzdG9tIGNhcnJpZXIgYm9hcmQuDQo+Pg0KPj4gQ0FOMCBpcyByb3V0ZWQgdG8gRU1J
Ty4NCj4+ICAgICAgIFR4IC0+IHBpbiBFMTYgKExWQ01PUzMzKQ0KPj4gICAgICAgUnggLT4gcGlu
IEYxNiAoTFZDTU9TMzMpDQo+Pg0KPj4gVGhlIENBTiBpbXBsZW1lbnRhdGlvbiBvbiB0aGUgY2Fy
cmllciBib2FyZCBpcyBsaWtlIG9uIHRoZSBaQzcwMiAoVFhTMDEwNCBidWZmZXIgLyBUSkExMDQw
VCB0cmFuc2NlaXZlcikuDQo+Pg0KDQpKdXN0IHNvbWUgbW9yZSBpbmZvIGluIGNhc2UgaXQgaGVs
cHMuDQoNCkkgaGF2ZSBhIGxvZ2ljIGFuYWx5emVyIGNvbm5lY3RlZCB0byB0aGUgVHgvUnggc2ln
bmFscyBnb2luZyB0byB0aGUgVEpBMTA0MFQgdHJhbnNjZWl2ZXIgYW5kIGFuIG9zY2lsbG9zY29w
ZSBjb25uZWN0ZWQgdG8gdGhlIENBTkgvTCBzaWduYWxzLg0KDQpJZiBJIHRyeSBkb2luZyB0aGUg
Zm9sbG93aW5nOg0KDQokIGNhbnNlbmQgY2FuMCAwMDEjUg0KJCBjYW5zZW5kIGNhbjAgMDAzI1IN
Cg0KSSBvbmx5IHNlZSB0aGUgMDAxI1IgbWVzc2FnZSBhbmQgcmVzcG9uc2Ugb24gdGhlIGxvZ2lj
IGFuYWx5emVyIGFuZCBvc2NpbGxvc2NvcGUuIFRoZSAwMDMjUiBtZXNzYWdlIGlzIG5ldmVyIHNl
bnQuDQoNCkJ1dCBub24gUlRSIG1lc3NhZ2VzIGFyZSBhbHdheXMgc2VudCBpbW1lZGlhdGVseS4N
Cg0KSGFydGxleQ0KDQo=
