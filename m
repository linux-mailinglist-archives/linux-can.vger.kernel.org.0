Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0016732EC
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 08:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjASHul (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 02:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjASHuB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 02:50:01 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2046.outbound.protection.outlook.com [40.107.135.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973F6778D
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 23:47:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsjYfUDBX9zw4agi10qq6SASIViErORWuwaJrZK2pN8KACoH2JQ55Oah/O9GGVpqbCeEU9Q5ecSfjkaWT4mq2dmVVYnZHLKr0M6rcB2BneUY/FNz1zYS1ZOqzjcURvaB3WRYw03o0frUam/fgF3aE+TA59ENpYK2gSVnpiM2loKYOt8J+fEMqOAFnPBzexjtxoGZxpx3mcUWBLyUXUN5ji9Xi+GxEPN0xAG81LzLddE7I8JGMFDTFkLVvdF5ZbJ9E2Uvv/KekgEt9U96teg6+FWHynZGUk6Wxrbo78UQ8Ms+tOd1fSNd4t/sj9w5pmhVVzfDDY9z9lGnon/dwJeq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2dVpph1oO3fDIuMadrwA5Q6QhIfRxump7SbBRgVs8s=;
 b=G31wf8BunnUpHmcV9gTSuqHUJmwtoBPBkH5fGf6/1unqGvLss9ZFC3QTjtPXn6wP1Bq8cYvNXB5mH0bi9kDOQcQ6CzAetRGOJ258rKBmfHJXKbqRfOY/uXbl3cdaC6dtZULDEXE2WUCn6HQZVbO89rEvduyY0ejEGy17g1zaYJPwFhjfXt2gVzMnOCnUujndXAH56UbRroTqZdM3rgtpRL+Q0SSMkgy9w4YQkE/LxC2FX40IxL/v/V5p+uoBhEJDCQCusO6F6B1JXHGQ2pThiyqoJOotZDL8UpCfg69z49h0Y4QcJzdY/Sqh4cEkEdcMgXG5nPOAJic/ZiNmsObrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2dVpph1oO3fDIuMadrwA5Q6QhIfRxump7SbBRgVs8s=;
 b=ZzgdZT0CamK1dHB0wNWA94t8WZfq5l9vkCpe2p9+8p+PlRwejABijeffYUhCKdoM0nsZerPtgPNXvCOceHK/ax8z3BzdAyuYf4HwTOEiaNZVUunV/uwwQZphwAVWuKKEDJViUX8exVeVZSbtyZIcogZQ1O9lA92wh1gFK1U9c50=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FRYP281MB2474.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 07:47:44 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%6]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 07:47:44 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        "kernel@pengutroniux.de" <kernel@pengutroniux.de>
Subject: AW: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Topic: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Index: AQHZJgsgtPZlzMMAzkyw+q4DrZcdvq6heDUQgAAr7YCAA7v3MA==
Date:   Thu, 19 Jan 2023 07:47:44 +0000
Message-ID: <FR0P281MB1966DE37CB113260C5EF1F8C97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <FR0P281MB1966455B1F0ED61EBCE5702097C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230116221559.nx6syqwnjmumwily@pengutronix.de>
In-Reply-To: <20230116221559.nx6syqwnjmumwily@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FRYP281MB2474:EE_
x-ms-office365-filtering-correlation-id: cbbba00b-7dbb-4625-0849-08daf9f1733b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zbuc/lrGNnj0vOosU2oPqMnCrFqof0fK8/wRHuZ6WsDV1DSTHs1bywVOgXU8n10sCMn+7r1j9tCzPhaYFWRo8P2USjekVkRMVwzVAokGVRtRiPgJ1jQOLnMzcx3OP6IkRNFQ5IWIJKMQsRkIjAo7RJFvJff2wEdEmXWIrw4QBZDjOUa3lofS4liPVhndzxpiNO0LzdyDe5qGyGFidGFB+iqUngt0cKubxP4Z7PrUhPxnNMiDC+m2jrBNKLBS+XC3y5nluJpxu0KZ+wIYt8bZSxg7haSvob7rZWBhEQ8nBhI0kH1yIEw94XT2/OLfxe+Ms7lG1vM1iIwissxwBLeuDB7NtxuVTNzVnsGnTqlc5Gdu8iRHUHYgpD170Hgp2rr3qHozjcEgNShjAg9u/kGWJIaDLLHvfsfTjIEvns36GeXO3otVkAT7K5EmviV10zDUiIvIm/INCuZ7R5P1e2At5IsBNzlHRVefVBY76RxxuHK8cqRh/GITDRNxvuXAV9G5gtMNB7EvCsnU4GOmX3ZeaX3IQRrRZpMQg8hhxWjtx2cCUZpcb6KEOlRWcoNkc16Kn8wz9U7mfv/jkGMan56dXGGKYw9cELs4YbL5oIOD6sGWw7h9qg19HM3DOfneDshcKGSRo4ziyGVSGhaKs1bRXlB76Ys9XjiN4+LcBEb5mxn2c2/hGgu07yulb+bUQQUTXfsApnZlITP7NciRgS3rYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39840400004)(346002)(136003)(396003)(451199015)(26005)(85202003)(478600001)(66556008)(38070700005)(41300700001)(66446008)(33656002)(186003)(86362001)(71200400001)(316002)(54906003)(85182001)(38100700002)(66476007)(55016003)(66946007)(7696005)(6506007)(5660300002)(2906002)(9686003)(4326008)(76116006)(4744005)(6916009)(64756008)(83380400001)(8936002)(8676002)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkFVTEVOWXlEc2w3SDhzNkk2b3QyaHVlUWRyR1BCT2cxZDVhUWY4aHpZT3lo?=
 =?utf-8?B?cEdybnRuMzNTWEkwbzlxczlFUStpSG5NdnZ3MkFpdnJDdmtYOTBvaHRSYmNP?=
 =?utf-8?B?TUEwY3JydmVaWXhQSlVVNmpWaDdqakx3d3Y4ZnFneXdxcldTZFIzVkJEaThZ?=
 =?utf-8?B?YW1kTXVCRXV6ei9xMmxsNE1hMXIwQXJOOXl2MmdIaHRxOEdIb1NwNWFhS2h1?=
 =?utf-8?B?UkcxWUxLdE1kSUNwSTJBSldka0FncmNETHhqZ0NzSTloWXh6TmJCc203Z0Fj?=
 =?utf-8?B?SjNQZ2w2d0QwUS90ak51VDhLbjErZ1UrRkRldFByRmt1clEwbm0yMXpVeDJT?=
 =?utf-8?B?WVNXSHk0NjRXRFg4c09RUG01aGRGSHR6VDFTcFlFTW4wK0gwUGdNbUc0K0dV?=
 =?utf-8?B?WnM0Q0wyYlExbVJ5czNIS3hMUy94blJvNnNETWR3aEJSd3NlYkdhaC9xQ3RP?=
 =?utf-8?B?NUZibkUzdlYzVEsrak4ybWxUYitEQ01yUi81T09yYjV4RE0yZjRieFpYbDRD?=
 =?utf-8?B?UXF1bTBOTEROUUQxRjMzdVE2eEErUDB2SnFjRGJuVzZvNFFpcW9Ba0VnK29l?=
 =?utf-8?B?aGZJZU5DSWYyMTY2TmIvTCtNcWZVTllZUTl6VmpzZGdDRWsyOEcybzBFQkdY?=
 =?utf-8?B?eWtxdHZtaW81K3RtWXNDRlVFbTRHRTB6c1gvQ0UzbDJSVGN0K0NoQjh2MFhq?=
 =?utf-8?B?bWpqWGh5dElWZXRNL0VuRHdSMk8vZjVnem8zSzB3bnZLUEFKcFdkZmg1NG01?=
 =?utf-8?B?V3gxWG9VWGF6T2VodzRQWHlLbXNEM0MxZExOeDRmQVRpSEM4cDhOcVJScDdo?=
 =?utf-8?B?elk1dWxSSEpCNDBxY1dxVmRaODc3M29xeGZsK1V0eURMRTNQZDZYc1hLR0hp?=
 =?utf-8?B?aDZZdTkvelNXWEVNZ212WDdwZGlhM0RYSEVxcHdxMERTbTZicDlKUG04bEZj?=
 =?utf-8?B?QW5QS3dBNG1MVG1rSUdnT3pmZHhPeTNrTnhTQ2M2RlQ2VGp2OC8xbDh5R1N3?=
 =?utf-8?B?TngyTDd3QnZTNmxjSmduSUV5NFZmVmtuRmxsRS9ZZm4zTk9FUWg2bFJGcmNE?=
 =?utf-8?B?SEthT1pGdEN1c2RMeWk0K3lSaHFwSEkrTlFMQllQekZ4bjFjRGVPYVJBNzRH?=
 =?utf-8?B?VFFxSEJTSUh4ZHFjSmk1Nk1GaVlMNmllanZuWmZLQjZQUUJ0MDlId2gxeVAy?=
 =?utf-8?B?aTkwUWROQnhXeExRTlFkZmhNS2R3NGZGQjZjTVJNMXNwUFkvMU84QTZJOWU1?=
 =?utf-8?B?UG1QWVZFS1V0K1Q4QlV5UDFqOHNOaUEvZG1oWXV4eklCU0kvNXA0cE40VG5s?=
 =?utf-8?B?a05SaXFJZUJSZ3JMaStDTDZSWWlDSlhyN0F3RGRoakpUN2U3Nm9hOFZSanMw?=
 =?utf-8?B?VDFJcHRMeGZKZ0xSLzFGeitrR3BVckdGbzRjdWV1N3ZwY3d4cTg0emFDcy9O?=
 =?utf-8?B?enVERUcxM2hBM1ZUc2FHN3l3RVlNeTRBbitoN0NadUFSRmd0VEZFQnpvTy84?=
 =?utf-8?B?a2lhQ2NESVlIK0JZSXQySXNYeWpjSTdaWjhES0hVeWZOS3JFNlBCZDFsN0hC?=
 =?utf-8?B?UytnYTF2T295WlVHM1RIZEJWTTQ1UHNPcC9aOEFvdkhjRHg4UHArTmthS3FM?=
 =?utf-8?B?Z0U0dlpTRHlxL3RodSszbitHVFFpSWpGVHU4RlNaS0x2c09PREg3UEh4K1ht?=
 =?utf-8?B?bU1ndnoxV3Z6MndQejJEWmw0UWJudHVFalZTWFRvZ0ZqeUFidEI0RWhmSER4?=
 =?utf-8?B?NDFoalFnZjBBMXRJSEhDM0VSa2JYeFdOZ3JScnZhVHFIcDFlcUdIaFpVYlk2?=
 =?utf-8?B?dEVJZUJRRHdIYzczbVZleVYvL0swTDA3MGNCNkpZMFV5VTM3Zkl0OTNPK2JH?=
 =?utf-8?B?STFLbzB5Y3hZMFdtSC9NVTR3OUtQcXFDV2RrUzhtYWdJYXMyVjhrZFRoR0VI?=
 =?utf-8?B?aFNOQ2JoT1NtazNCSDAwVWZDTHBWT0FhaHZOV0psMFF3VW41TTUra1h2NWRr?=
 =?utf-8?B?U3dlbzQyZkpHUTZpZGphTWVNcnB1T3J5REN4VzdGNmhUcGJTMytGdmpoNEVh?=
 =?utf-8?B?UVAzVXhpVFlQNllyN3FWYWxvMjgxNUFNa0Y0N0VWUHFjeXR1ZFNZWXM5bEFi?=
 =?utf-8?B?N2ZLRVZaUktHWEM2N1hrWk0rVmhVWGcwWXpuekRrUEVVQThkWXNUeDRqcENr?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbba00b-7dbb-4625-0849-08daf9f1733b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 07:47:44.1404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qu0dLwvjMkK+k+rHVRRHo09jADdUHCUSZGiDSLVl9A+XR3oFkRyh2KVUhbkK29Y8f4TmkPTw9+UU8ua4yawS20RSiwO3+c35txkXDg0Q3bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2474
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBCZWZvcmUgdGhpcyBjaGFuZ2UgdGhlIGRyaXZlciB1c2VkIHRvIHJlYWQgdGhlIFJYIEZJRk8g
aGVhZCBmcm9tIHRoZSBjaGlwIA0KPiAoaXQgcG9pbnRzIHRvIHRoZSBpbmRleCB0aGF0IGlzICoq
d3JpdHRlbioqIHRvIG5leHQgYnkgdGhlIGRyaXZlcikuDQoNClJlYWQ/IA0KDQoNCk15IGNvbmNl
cm4gd2FzIGFib3V0IHN1Y2ggYSBzaXR1YXRpb24NCg0KICAgICAgMyAgICAgMSAgIDINCi0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpOfE58T3xPfE98MHxOfE58TnxOfA0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCg0KQ29ycmVjdCBmaWZvIGhlYWQgaXMgWzFdLiBXaGF0IGFyZSB0aGUgcG90ZW50aWFsIGZh
bHNlIHJlYWRzPw0KSXMgaXQgcG9zc2libGUgdGhhdCBhIGZhbHNlIHJlYWQgb2YgZmlmbyBoZWFk
IHdpbGwgcG9pbnQgdG8gIFsyXS4NCkluIGNhc2VzIHRoYXQgSSBoYXZlIHNlZW4gaXQgaGFkIHBv
aW50ZWQgdG8gb2xkZXIgbWVzc2FnZXMgYWx3YXlzDQplLmcuIFszXS4NCg0KLS0NClN0ZWZhbg0K
