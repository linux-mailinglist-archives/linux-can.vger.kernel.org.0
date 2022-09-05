Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCBA5AD736
	for <lists+linux-can@lfdr.de>; Mon,  5 Sep 2022 18:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiIEQNO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Sep 2022 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIEQNN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2022 12:13:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187E54647;
        Mon,  5 Sep 2022 09:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK/M2mW2CMcmAtwQt35Z+GU12rdn0NKItMRybe6r+M4EnhNu/J1Pie6NOSh1ZmNjkZoZpKswez3IfQXeCIeFWousWfWbVqtkOD9TvL+alQIhSS2/bMntVg2zT/rkhE14UpqSJIFUgjB53DrRLixaFU50WYrWa5uPHKJzcgIM6fpMXob5idPAvpLzONEgNE8/G3xPLM91jZf+C2PxA86KIvRG2i5+BtO33Jg6yrbs/sBz1QGexJkOqCqJHyEW/hYdcZnC3HKXY8XTvYJOqnF3Hqsmep8eJwG7MQ0EJEKVo18YOnAr4nxaVNKwVcfGlpN/RIg71aBKCrkUUZL0+uHndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdKFKptjrTGJjySPYbJbw7Pw2OiK0zT+HsUpCbHEq3Y=;
 b=jC/5M/PyCqBE9qi26fwj7u+35FZT/Sh1Pc8vOAjokCy7mmIVgnt8BvdiusJMdUrw5kbymb656bIDjGEk030umtG5UT+GJA+jJd0PdJCR2jnwX28Ye3XNfxx6xeuWaxuDkcmBhEeEDSYQYrp/wd6YqNxOqliPzP9mj2SF1y4PgvxMOlPmDDhqYqKgoDdoFWZZK5GO67tayYs/ZQT41h0p8xZMDBkTA/TqisLyQAUTCpGTZe57TDQ23f8JLBphOUd1M3+e949xm9/G2Pg72X7T+M4OHvHw1dDc1Ov0hCQHgj5u+KVFFoirdQZdUe8gWTiNupoLz9Y3Hf6iJXHpS1Z0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdKFKptjrTGJjySPYbJbw7Pw2OiK0zT+HsUpCbHEq3Y=;
 b=tdsWkCTc0CCeCnTrRNn9S51LMgedVsIIsbPnlAtn3lZ5mn7HU9BJ38J6Hl0ZlG4tpjfzH0liV2l5X0ccuE6YKudZeUXFmlUl37dUThluzwUi4LMqNLTS+rctt6XUY6mqdL0m8DR1vA98YVH6fR0hMRGpY6XVwelzTPSytuPjBMA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9771.jpnprd01.prod.outlook.com (2603:1096:604:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 16:13:09 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::14d3:5079:9de1:ceaf]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::14d3:5079:9de1:ceaf%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 16:13:09 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] Add RZ/N1 CAN support
Thread-Topic: [PATCH v3 0/3] Add RZ/N1 CAN support
Thread-Index: AQHYvI/oGe6gw/6pA02aY7hpzDA/U63RCjQAgAAAQLA=
Date:   Mon, 5 Sep 2022 16:13:09 +0000
Message-ID: <OS0PR01MB59227189DB7DC3721B097B9F867F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220830164518.1381632-1-biju.das.jz@bp.renesas.com>
 <20220905160758.ieo673gvaejjjfuk@pengutronix.de>
In-Reply-To: <20220905160758.ieo673gvaejjjfuk@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68cb1ca4-0982-47af-ed82-08da8f598624
x-ms-traffictypediagnostic: OS3PR01MB9771:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awKJSZZC7fej653JkDxT18CNWEJNTUnBeqzb7yk5kf9bnPIDTUVr3TOvjifRXqkawl6eSSQkinZVHgYC+ItuO4ahuVL3iu1/SKQUTjRqmoSeDGFeJTnQ6WSHJLArGEq1qKxAAnD/4zqNkhlSv/irCeAjRGE5+krIWywfX8oIAiwpsGBG7q9sLg4yhzaObp4OIyZmmjQ92/qKhLM0OSeuEAXmSapHCRZ/Ipv1EADwY+ji6+T2+nbFp2nrX6q0a3AzDRMddbgt2SCU7pIaXaL4kOzlg7tFvPUz5s+PTpBjFzS98hGXS3O2p3e9GX52st8qK/cPFZ/fMBclLeePPPePM0QclAMQIc4TXqI9GX1BFaN9MTTBSIPx00Y1X0FLQhOdJpGxwWympwm6BPUduU2gRWpkTqTOnH5T0XptUC8+q/ZUEqx294jSHJ3h4+d6hll9t+L2vyv2KNjT18LmTXaySavrTNrUeTJVhuuIx0+xoU/9X0sSmDAgj21KIT5MR/2sOSR3sMTUJM6j3RtPXnT11/KtnSOox4rgFZwTOjuWsHeJyGB3DkWeZqbl/xrSKX+4YfaNEX7mKKnP1lIpIUtfYC6kA/lU1iu+ZcephPHFP/2Mpiz4FDcuf225p0buNFsGWlhVTEIJiOCO7sRAwZb7Nq7TtYoWjO9tkv9O19XexnifvzV970RGFNftEZij79kWQzHh0ELeMIXFahBx/bAxX9Dqs8qmH/bGA2EG3v4RpGkiNVFsQ5fy1PNTxmz22g59Y53R3mN4GabFd3NNebRBO7kHv+XUk91218xFzT9pCAQ8Jy2MbyO5bXo/XSUfIKbROQJ1IhJ/Smv6ZZd9oRKwPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(52536014)(316002)(5660300002)(966005)(41300700001)(33656002)(8936002)(478600001)(76116006)(38070700005)(186003)(66446008)(8676002)(83380400001)(26005)(66946007)(66556008)(66476007)(55016003)(4326008)(53546011)(86362001)(64756008)(6506007)(7696005)(9686003)(2906002)(71200400001)(6916009)(122000001)(54906003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0JrcDhhc211OGdHVG55bk94RWhZR1owUEYzOEp4alhSRmE2ZGdsTHFDTWNZ?=
 =?utf-8?B?U2ZlUEJjOGdRenJkQWEwSWhSWDFmZGFQUGowa3ZWVG1VUWsrS1pEb09YVkVV?=
 =?utf-8?B?SzhoZnFDaFZ0bzVnVmxEZVM5SkhVTWJyS0Vjc3FaMlJhOGJsZkgwb2M0a3NM?=
 =?utf-8?B?ZnNITFJtWmljK3kva29yMVdDZ1lPMU1SYlZCcFR0ZG5iODNyMHNXL2NReFJ5?=
 =?utf-8?B?UDFOVlNCT0dld3pBOUQ5WDFLOW13ZUdmZUVPZkQyeDdjOHhUejJSNFF6T2w4?=
 =?utf-8?B?L21xOGJXcnUwZDZ3VXJDVWo3S0t1cW8ybDh4OE5XQXk5SlRFMkhTYzRuVFFx?=
 =?utf-8?B?TFd6QW42NHE1RFQ2UEZFZkt3RzhYS0FGTGRTZDlDODZEZ0xZNXdYUEcyQkYr?=
 =?utf-8?B?cnNKdXl6ZWdENW1mZnpMVys5ZTBaU2gwNjA5U2w2N2J6RTd3eGJFWnpIckJ1?=
 =?utf-8?B?Z0QyNFRMQnRML0d1UU5Vak12aHFqVzB3Wm9TWnlJRjF0K1VKblk3MDNKK0lq?=
 =?utf-8?B?VHNtVUtzVzgzTHd1ekwwbVhqQndnRXREZEhCbFRwOENtY1pYMk9oZU9HY0dP?=
 =?utf-8?B?TFdiMC9kUW1kamlFQ2J0MUNjVlJaaEZrVzJBNjJod3FIMzM0VUk5VXM5Yk9l?=
 =?utf-8?B?RmFEQkxmWEZYZk5MUVNhNCthYmZDRzhIRnRsajIrck9kaEFoUEpPcm1NNjNX?=
 =?utf-8?B?TStwNFdxaWtMbElkWFJ5MXB0ODlKcFlxR1pya2NUKzhCbklTUWF3SW9TYStH?=
 =?utf-8?B?RXA1eE4wSEJaU0xPV3VBUFE5cTZjLzhOeHE2YUgxWC9EbVNVd2JVSEpnZEM0?=
 =?utf-8?B?NTNYWmZWVzJ0enRZZ0Z2S0pPTDYwYkI4em9tSmlvcE9qdllrOHlWN3hxRTVB?=
 =?utf-8?B?MGV0a0FFVHVxYlg0K3hRV1BDUXFzT2NwcU5Va2xYMHRDeHJzUzZOYTE2VTN4?=
 =?utf-8?B?NEc4VkdTWFpGRE4vaW1PM0Y0QnNoc1V5YXRzR2F0N0JPVVBOZUhJM2JHK2hr?=
 =?utf-8?B?bCtmRnpKSHZhcUEyQU1yVlpGcm1hMGkxQ2pPekJQeER5VlJFbEFYUkdNb09Y?=
 =?utf-8?B?TUg3ZjJtTzRGd3NMa3QyVXhuQmVPeEV2S2krNE0yV1dab2ltSkdLLzRNaFZD?=
 =?utf-8?B?NTUrSU9wMWNPN2xaMnEyaGJWMnFXUEdSZUpMbDBZSWVQRTQxQWxBMnhYQm9T?=
 =?utf-8?B?Sk1najNldE5obm5DTEphQjhIdGx0MUlsUDJmd0FVZmZDRU5DdndVT1FRbUQx?=
 =?utf-8?B?ODhPUGhqbDFwRFBjYW9CbEMyL3ZzSldNdHMyaFdWRFcveFhMbXF2OGlzTmJE?=
 =?utf-8?B?ai9JZVpPWUQzTllBUFMyU3JTdURlZkpjMVNTUDdURTl5Rk5PdmpuSmtuMHVF?=
 =?utf-8?B?WFFoZExUeTgyVGp0NGFxRVNEdDBRd0I0akRIaUVRYzlrbG5lRGFkVm9QZFEx?=
 =?utf-8?B?emMreXdURStTRmtQMGxVT0ZRdXA0bDBnbWVCeDNvODk2T0pWNFM3OEtBS3ZX?=
 =?utf-8?B?SVNsY3Z6RHoxVzZxWEhQTm0vY2tFZnNXVXk5S3c1QmlUVEpaZ3pZMkdnUTNN?=
 =?utf-8?B?UFliWUhkSllZajdBbEF0ZHQrdHZIQUNYam5WUUxPM1gveVFBZWdITEhrNmcv?=
 =?utf-8?B?ejliSURibUpoZHJwdzdRZVBYU3g2NHlvMFh6K2xGRVBRWFMxOHRvRWZpU3Qv?=
 =?utf-8?B?K2hHVC9kSEdlWjNsTjl2bVZqZmFjdy9Jc3hidTBQSkwzQUE1bG03a0laRHJr?=
 =?utf-8?B?d0g5MlE0aUFTbFRlaEJkOWljVVdWWUxqcmZ2b0lDZ3VYSGFxRjZ2aEQ2OFZM?=
 =?utf-8?B?d3hoRHZPekpPTS9ZMHh2VThkcTkyTEx2UVQ5eDhlR3R4ZmhvV3NDS2ljUjd5?=
 =?utf-8?B?bVRGL09za0J1VGtFeXNRWERhZTNyU1h4Z1JHUHM0SEIxTkQyYlpGOS9wbFRj?=
 =?utf-8?B?QXVuZGNMR0dqeTdBRXBNYzBuTzczUCtiMVNnalFhdjJhemNTajZNRU94RnJC?=
 =?utf-8?B?OHZrSXFYSzBJdEMvN08vYnRuZmZBNnRrakRnVTVRVk5KZUFNRzJnR094WFdW?=
 =?utf-8?B?SkN3R1QzeVN2Z01pd1hBajY2OGl0TG40ZlpDbW9NRHBGaW4vNFEwbEVHbERG?=
 =?utf-8?Q?EBUsMgqSnRsy0qSP3CU1Kf0Sx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cb1ca4-0982-47af-ed82-08da8f598624
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 16:13:09.1149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQe/JasqT196n6dF/1n89LYrcTKU0xUf4amRQKaIwMNgBcbdpwAXYizIlaPdGqAE4ChV2sXs+PtrE9im1qEa7WrtInOUOuHpjbzzp8LHM0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9771
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvM10gQWRkIFJaL04xIENBTiBz
dXBwb3J0DQo+IA0KPiBPbiAzMC4wOC4yMDIyIDE3OjQ1OjE1LCBCaWp1IERhcyB3cm90ZToNCj4g
PiBUaGlzIHBhdGNoIHNlcmllcyBzdXBwb3J0cyBDQU57MCwxfSBwb3B1bGF0ZWQgb24gUlovTjFE
LURCIGJvYXJkLg0KPiA+DQo+ID4gdjItPnYzOg0KPiA+ICAqIERvY3VtZW50ZWQgcG93ZXItZG9t
YWlucyBzdXBwb3J0Lg0KPiA+ICAqIERyb3BwZWQgY2xvY2stbmFtZXMgcHJvcGVydHkgZnJvbSBD
QU4gbm9kZXMuDQo+ID4gICogQWRkZWQgcG93ZXItZG9tYWlucyBwcm9wZXJ0eSB0byB0aGUgQ0FO
IG5vZGVzLg0KPiA+IHYxLT52MjoNCj4gPiAgKiBBZGRlZCBSWi9OMSBzcGVjaWZpYyBjb21wYXRp
YmxlIHN0cmluZy4NCj4gPiAgKiBBZGRlZCBjbG9jay1uYW1lcyBwcm9wZXJ0eS4NCj4gPg0KPiA+
IFRoaXMgcGF0Y2ggc2VyaWVzIGRlcGVuZCB1cG9uIFsxXQ0KPiA+IFsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1yZW5lc2FzLQ0KPiBzb2MvMjAyMjA4MTkwODQ1MzIueXd0emlvZ2Q3
eWN1b3p4eEBwZW5ndXRyb25peC5kZS8NCj4gPg0KPiA+IEJpanUgRGFzICgzKToNCj4gPiAgIGR0
LWJpbmRpbmdzOiBjYW46IG54cCxzamExMDAwOiBEb2N1bWVudCBSWi9OMSBwb3dlci1kb21haW5z
IHN1cHBvcnQNCj4gPiAgIEFSTTogZHRzOiByOWEwNmcwMzI6IEFkZCBDQU57MCwxfSBub2Rlcw0K
PiA+ICAgQVJNOiBkdHM6IHI5YTA2ZzAzMi1yem4xZDQwMC1kYjogRW5hYmxlIENBTnswLDF9DQo+
IA0KPiBXaG8gd2lsbCB0YWtlIHRoaXMgc2VyaWVzIChvbmNlIGl0J3MgcmVhZHkpPw0KDQpJIGd1
ZXNzLCBub3JtYWxseSBiaW5kaW5ncyBieSByZXNwZWN0aXZlIG1haW50YWluZXIoaWUsIGJ5IHlv
dSkgYW5kIA0KUmVuZXNhcyBTb0MvYm9hcmQgZHRzaS9kdHMgYnkgR2VlcnQuIEFscmVhZHkgU29D
IGR0c2kgaXMNCnF1ZXVlZCBmb3IgNi4xWzFdLiBTbyBJIGd1ZXNzIGJpbmRpbmcgY2FuIGJlIGFw
cGxpZWQgdG8gcmVzcGVjdGl2ZSBzdWJzeXN0ZW0NCnRyZWUuDQoNClsxXSBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmVuZXNhcy1zb2MvcGF0Y2gvMjAyMjA4MzAx
NjQ1MTguMTM4MTYzMi0zLWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tLw0KDQpDaGVlcnMsDQpC
aWp1DQoNCg0K
