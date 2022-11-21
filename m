Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC4863219C
	for <lists+linux-can@lfdr.de>; Mon, 21 Nov 2022 13:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKUMIy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 21 Nov 2022 07:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKUMIw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Nov 2022 07:08:52 -0500
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2119.outbound.protection.outlook.com [40.107.127.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE936A681
        for <linux-can@vger.kernel.org>; Mon, 21 Nov 2022 04:08:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjNYbRJcsNDLGvTLMpC0ZhAs4RXu/60vogHiwkxuPna+lQFtKOuHX1t/MKCq0CzAJWrDVFmu8sdLhCwa3U12+DC0nYy0tJPBtHvdNwXTO5dSQbcg6PjeXwfHWdgyTV48jjnTzaRX2aMy/CHeu8bbI/amsJj0WstZXDfORYMNBKxx6gtP3dGC+d3zSjNpEe8o4+YtATNrud7S0A9tTW5DQ/+ca+r9UPR9bXi+uzApHW9xsdKUoSa3xsp4DlvS4f2Gn4wbYI22VkUpgSvmNG+cg4Ix6819yC5knt5HDNLvVOo71ByhhltUUR1VrbC9CoxViuGejvxYMkdUDqUo2hO6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwlPk6T1eBW0Tdv9YcKuUY0erXVMbeugyHv+itMRG9Y=;
 b=PiNj9WfTx19NOPBSHPrdnWyQkqjpHnQOGjJfnC+7YQmG69GYRlyBZgrCzdLwaneqTMzv6ZQLbLDIe6O4ehAimK2ruw3+UXrzkzsRP8/R0u8wiEbdGfjR6fhsOxDVxRumDebdeMjZeT8cF9354AY6NSOxudGzrc9EXQaZHQLBoOVdQEjR9eml11dJx0JWyZPQjjIpsGC8pDvt0I1Qhcf6pazaSeFAH0Al14MLmoe8sreQ36NbaKyjvTNpOtWrlJ8C2KDErmpDKdjfGSK9RANnR8lj1Ikj6RbnKABzD39nA/LlHOLVVfyNd8EF/AGdwQv9dJKkyt9ARGiLXG6GfERDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dintec.solutions; dmarc=pass action=none
 header.from=dintec.solutions; dkim=pass header.d=dintec.solutions; arc=none
Received: from FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8e::7) by
 FR3P281MB2509.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 12:08:49 +0000
Received: from FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM
 ([fe80::18e:f41d:d97c:6f43]) by FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM
 ([fe80::18e:f41d:d97c:6f43%4]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 12:08:49 +0000
From:   Marvin Ludersdorfer <marvin.ludersdorfer@dintec.solutions>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: Problem receiving > 8 byte UDS response when using istpsend
Thread-Topic: Problem receiving > 8 byte UDS response when using istpsend
Thread-Index: Adj9oXS9XKrdsZ8wSP6hlXFXAyCoOgAADfAw
Date:   Mon, 21 Nov 2022 12:08:49 +0000
Message-ID: <FR2P281MB165503FACCD9894C353ED4CE9F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
References: <FR2P281MB165556E4F729AC3CDB50F6F69F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2P281MB165556E4F729AC3CDB50F6F69F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: b48650ef-b2df-409f-a4b6-a1368ee9584d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dintec.solutions;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB1655:EE_|FR3P281MB2509:EE_
x-ms-office365-filtering-correlation-id: 81d7be5f-b473-4df3-e854-08dacbb925e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0IrsI1IUGzRVzaXck9eWh/wnw2DMOqewmUkBj97PTUaecLmGzM/rniVGWeXfq640cMdqx6cpxN+BTWfg31fuKsfV11TI19DjTSgJa7+WMVFRKUJVgqHuxnjfKCjL2lze7dVZg5ICcsXS1f72FyKjj4+QJ/ymRbTTM6nKb8eAfNcbRcjwm3jhoiFYGYojWLQ8FyBUAxwKFe2YHIkWRqU6tuo9MHhyD1+osQVFk9/V1+Pbcc+V7wZXunslTqLotdujrs4QtGKtOUSJ+ljRRmEQn2v8qK4hstJr3Y/OZEbHXRSRFPZCi0UjN/GyMXcQXv8Twt6SQpJltEfWTf8Zj52+DbhHYBYAaGwJmIBWiqQbgHPkwsI6U2iN1xSXHoqMjpwFebc9TUUK9Q8Q+pLPclxX/jew9afVLEEw2DV/kTq8LTlbPB2fwl12LN2b0IpgcdvhfE0NDeX/TCuvYXvXKoTszWpy0QiPPS36iTvdmDt/IPXBl1osbondBRkuz0kZFZiVEY4YCTU2fkSVbmdYJ5KgsX+SEGoRyM1vefhC1cLKIGkJD0nnlbvMkxkjyyaElB0eSupFS4LY0nLDZACuSuApTZTJFqz701D8A9UNyk26okXEiXrZgHSyPvwol22Ha92TZaywKwkHhEcHrW/v3xs6n+x17NJKOu8HV4yLpKp1i9TDXKv8B5dkcUie//jVzLeuPDFzsczskOeFI4vuaxn9WlhisFZFsRp/o6S/hv5d7oo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(136003)(39830400003)(451199015)(2906002)(83380400001)(33656002)(66946007)(76116006)(41300700001)(66476007)(55016003)(86362001)(122000001)(6916009)(6506007)(7696005)(38100700002)(38070700005)(4744005)(66556008)(2940100002)(186003)(5660300002)(8936002)(44832011)(8676002)(64756008)(66446008)(52536014)(26005)(316002)(9686003)(71200400001)(478600001)(46492015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7e9VSpho3t72JfiaPm3j36Gy9kLWux2Y53GhK6iffkcHHR7vZQmGDGjzhE8B?=
 =?us-ascii?Q?d/+QKyGpyp3cKyEJmINnUu7RG/+GGcC1TEIk1dZfqYCSQlmjq3acq4cIWH80?=
 =?us-ascii?Q?tCFIYpbZHVS+N9WSucjeB7Z89rY+hvwODRQuamb8o+FXbTBHxqGj0LeLLu4D?=
 =?us-ascii?Q?Ytk2ai+CCYVhChMcHyracDM6Cw4xpKDmG3zBdD+iEhdddua/FJhTs+AChnyi?=
 =?us-ascii?Q?BTocT+zOb2rfxjCTMFh1kejkDSUX8UieAfqnqu2vVfnOzEztiLdn+1X2JNVo?=
 =?us-ascii?Q?qgQDqyl9aDwd/v7+mMnDVVYnPSfWebRdXtH6eKE1vYHrPnKkmyvZ28s0K1CM?=
 =?us-ascii?Q?rAKsNCtfMnPAnXW0zLk6aF1xuUt8dbnzq6jOXVV5R3QtZxWXkvUetTzXIUIC?=
 =?us-ascii?Q?vSJf7bNnQi1rGqSxsnFUt1X6Y0ySRhv4fRL6/szGGXCo5aDFLnyXe+/5xkO4?=
 =?us-ascii?Q?AIBDuziCvxdTQrVsSB3Gaep63SUVntX+vh6HFKzJ5ewUh4hfq58PnQfblV5c?=
 =?us-ascii?Q?ObZnwe1HnxfAxrsiTXIIDaK6rA2cbVftZnX4mCh72jKwZSLX3YKprRz6IZU1?=
 =?us-ascii?Q?+iZhqRAvL03zSzeiADTbeTyuastM1QMEwO4lTY5ZpKmaM+BWl/tYbRAm9l5P?=
 =?us-ascii?Q?oDUyO/xRrg73Xe7sGuzyEanh1bB3JG/4SGBviyyqhittFomrZ0DIJqa0/tNu?=
 =?us-ascii?Q?+eBY42574AdYQCK+d0jdUzTbE8k62fXA0Av9VfZgNDLb7ye9uCBYbUPWn5V2?=
 =?us-ascii?Q?BTMsi6+yUhPJ4NAGywAr6NuxC2PimWHfVS7HSkuz803eTgKXvL8FoT/ZhsMB?=
 =?us-ascii?Q?6UVpnkCuEKzE431q/kNUiZ1jyhZgb3ny/1l/8i6rOl0alyuAjMNehH3o/QM9?=
 =?us-ascii?Q?oVQ/hhW+UW2EjK3VYZjxk8nJ1hGpbJWknR4Y0WOrZy1I18l0uKsPpLVXZSXw?=
 =?us-ascii?Q?bKhOkYp6Ks/jZM1FwfhPHXQBkTR0xdvXNchH6eRvoFg6BUuBaNGgUxoHbaNA?=
 =?us-ascii?Q?mmvw2pHWpGuPPKLfqejenucZK5Ql2HVZYjF/eq5/9AFYKUzodTHVNkUp/fbM?=
 =?us-ascii?Q?aNHRKrV/9kbc3H3Ks24ZlF9iGyqn/6U82+D+dvDXtB3NmB6UmfVUlGN3bQrF?=
 =?us-ascii?Q?5Eq0wrAwMLGs5eErkT6oi8at4WKOyXwLJa6nHU2b1we0RS5SxQPPZx2IP2nJ?=
 =?us-ascii?Q?kmwP5H2pRoRp5/5ehuEUAj/GdXsEnOo87EItvRUXksPYyqgxqrC9VIHcW5r9?=
 =?us-ascii?Q?WbezJxuqaal7iV8Z/c5KXisAYntvOw7Ao3DB3K6+4xONnqvnxqIzOdgzPHYq?=
 =?us-ascii?Q?7rB3xJh/FNXLEb4EDaeGUm6GayGsaHDX4r7yuACVfdbnfhYmqdCtRQWgP8IH?=
 =?us-ascii?Q?Jsg+dyPuwGU7CTvbvoZ5FOiOjw4W9Ks+eD/EHePv80sPKlI3sHNyU1+LBvgZ?=
 =?us-ascii?Q?cgR3TR5I34DMxUTwXvQ++x5hP+N/4tCkz5xCLn57wS+s1EuoR1PIcnEeY95b?=
 =?us-ascii?Q?CMdjJ5AySSOU12O84jLbamSfqYNU+ciFExO86E3zspOiLOpoNW7L5dFFivH0?=
 =?us-ascii?Q?uj9Ee9hWRWAgsRnMvv2ICe3CMzmGYbdVAaOAFsyWDM9zRhQ8MmumI0Id8Zuo?=
 =?us-ascii?Q?bm9R6GWNiL7JObrWw+9qa8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: dintec.solutions
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d7be5f-b473-4df3-e854-08dacbb925e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 12:08:49.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aced8699-8899-4f52-b3b1-e68bc99e845d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6oe5vo8zR8mJCHRcDGTAsGcgUlKXjYFpDdDSLf9DXJ1dUFBIyRXoCeV8MpBlEZewbF/anycJwiQOlCfW+uxxvCEdUtRb9CCW5AAGOTlJNXe45L1pONeuz74WPgHij36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2509
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I'm experiencing problems when trying to read out ECU parameters using istpsend when the response exceeds 8 bytes:

In one terminal, I run isotpdump -s 00000680 -d 00000780 -c -ta can0

In another terminal, I run echo 22 F1 95 | isotpsend -s 00000680 -d 00000780 can0 -p 0x00

In the first terminal, I receive only the FF, but no FC frame is sent (expected is a 11-byte response).

If I turn around the communication direction and run isotpsend -s 00000680 -d 0000780 can0 -D 255, the target ECU answers correctly by sending the expected FC frame.


I would expect that isotpsend takes care of sending the FC frame in the first example as well to receive the full response - am I doing something wrong?

Any help would be highly appreciated!

Best regards,

Marvin Ludersdorfer

