Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC66F7D78
	for <lists+linux-can@lfdr.de>; Fri,  5 May 2023 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEEHHO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjEEHHM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 03:07:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4062F7EE8
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683270431; x=1714806431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n6g/w9suh6m7+1yqpQtYxaz3ClauRrVO0JQwpDSw46A=;
  b=GBA5HSa7Bh7msjqm8YJyS5NRGKXjEegNshQ7fic/vDKnN94YYmvEpAAo
   qO4NnfKAJZTdGrGYL6RniTSmNudJ/k48sQZyCygGIiGIUqKUPKMCmi3kl
   h58tNY7OHW6gdkQnSJ+Cyqi8D+ud39LYEi0GeDYeDCFAFRuM9LDMJ1iBE
   ibStfw6ZEcz79ZIc+gwOIN7GJPEVotKnxqxleFmzlWiIxo9rL3Wvc0fUr
   9oaLsY2k3zP2tcEzc2NMvrEoT5Dgpvd+Z0KzGvt7X7d939wwBV38gsJye
   6fMf+sUN6sCdxKvh5FAZ93LWP+j8rfjgm0PVRnz9hwHyC0t0YZl0jzBbV
   g==;
X-IronPort-AV: E=Sophos;i="5.99,251,1677567600"; 
   d="scan'208";a="209785205"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 00:07:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 00:07:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 5 May 2023 00:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9CUY68IAqf4aEag8GNtDPyZ2Kge+X00Y0YdxFCgN5BHe7xTyP6qw4EUd+7IXDLGzCl6thvOMT9hx1NbF1U9BldblqDUTxZMGdKA9VfrGL3BmGPdgW1Bs8icGJEh0Z/dT/G+ZH2ZktMV1Oj3eHqtI64BEp4Dgc8nRCsAYDulZgtjDgaMNYnyKIToRZQHAoKYAGAALKhCqKQZMmi4VUZpI9h5DVXoRnOfq0X3kP3vqQFTUS/SUkSDKrpQj/fwWtDzvLulWjEnJPUxXJa4uy1XV8R3FZAhZRtuZrrtE593sy6ggRSUeBoJBkkjVYHysQIEkFAC+zpeX9aMVNraHGWvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6g/w9suh6m7+1yqpQtYxaz3ClauRrVO0JQwpDSw46A=;
 b=V501BXpyPJI+HkgKb0qHHo4YVDdn2OdeQhUV1sO1ijf0S6QQOgLXGXwWNzIcoL17UOxcerliSGuPTX0RnPgUs/pkDzk1IkoTZk8H0BEz+xvd/AKAs11IPTJPG6LQ/0xfi6Ozv0Qh8YQW3VBOfmxNx07qsNXwaSjpbPhhlSkiVOayvUSYndO9eJurL320qk3MrE5ODxcNhCJOKJIW9phuTszmT2xiAsBwSk2Tgu2NONDz6aVWbWEmlgb3h3fcSqdzsBlpyJ9+Aa263SAnBky8pM2edFbopoorsobwuMaWIUPAZ/rOWLVExo56cWoyQ8e2AeXe24uXYr2sI1P219bDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6g/w9suh6m7+1yqpQtYxaz3ClauRrVO0JQwpDSw46A=;
 b=QQHUnsuvYgksX8vm7nw9UuqmmDLZrZbUdlhe5yDlfSRXJl7qpeXF6cX9mM33omXro07hJcVSGBr+C9tKDdXWy4tX95d3HzrKUL7rAGuyXsbN6N3zhz8jziLs9DPeojrOJTgbLsGz1+d6CsgXqO7z3cgc9iF/9LbrY+r/FgViLtA=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 07:07:03 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 07:07:03 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <marex@denx.de>
CC:     <linux-can@vger.kernel.org>, <fedor.ross@ifm.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <lgirdwood@gmail.com>, <mani@kernel.org>, <broonie@kernel.org>,
        <pabeni@redhat.com>, <wg@grandegger.com>
Subject: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Topic: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Index: AQHZfsHPIp3PLFFLr0mLQ+HLgrlDx69LPlkAgAAEhAA=
Date:   Fri, 5 May 2023 07:07:03 +0000
Message-ID: <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230504195059.4706-1-marex@denx.de>
 <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
In-Reply-To: <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|SJ1PR11MB6083:EE_
x-ms-office365-filtering-correlation-id: aa532de7-4a1a-4173-c12e-08db4d37540b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7UF1EwAdF+pbuqMf2vBqpvfgRzgCmgvYPIDZUclDjGb05GKas5j7O2irrGxC09ZQrTNDlTxurRHq7VxdX7iMsoWFs/qq3vsE3/yu3QLlsjqAKbEpsCy+3OiM70F7ceEoXrzt1Gsb2UaQwZ4NT9nIj882hXxsE2BGc3TcuFW/YBC8Cf9s9kjlFHM31nQthK/yPPHI56VoGezQ58mxhZYFxLCvAqnZk2vU7AU0KConQ1Mg7wlx1gDOc2Gfat/u34nrrK6yBOH8jdY9j5CzeSNEwCMeKJzzxUOFr1OKwpntmSJHrQ9NQubmAVqK5MfUBYLk0r5IPiGAmhx2WfLuczo013k8eteGyS0j7UtOD14ex0kGY2BzP/v1y1/eDhqSKV6sUx+lbqw2M/InZprs3gaKt2WzH688y9LRyvBo40K0ixMmdCBGd3/94ly8HFGpagmukZV0xK9+SIAafjQxJD9hBi0NFe366wJlztG/jtoM2nJBoYZgK45eZT3wmQ/oxh+pcNU66tW7Zw6T8jmQMVfrVpxxQW0I+XkFPaR05RVd66dt5PXULtQTEZhLsOZywyMfWZUf8zfrgjvk0sWWPozXvQARNvJAfXHAbf6oUaza2JDWA0gxkzZUYgmsgrV8RFj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(5660300002)(7696005)(71200400001)(83380400001)(55016003)(186003)(38100700002)(122000001)(38070700005)(86362001)(33656002)(26005)(9686003)(6506007)(54906003)(110136005)(2906002)(64756008)(4326008)(76116006)(66446008)(66556008)(66946007)(66476007)(8676002)(316002)(8936002)(7416002)(478600001)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlRkV2pQK2E3djlCMGtHRG9Xais1cCtWZjNJSGk0NTUxQ1kxYlB3dDZzdXpk?=
 =?utf-8?B?NGZpSUYweWowSE1JNHRlczNzbWN6c052Rzg2QkZ0RmZacXZvSzMwR3pCQWNy?=
 =?utf-8?B?N21wdGs0dDRMZHUrTUUzMHNaVDZ4ZHJJZ0JJR2VvMkVRQndDdU5YekNQSllh?=
 =?utf-8?B?YVkvMG1ETjVDWjh1akdQL29CZWZpd0xHa0NCRnRneGp0TXkrMjVIY3FBckFT?=
 =?utf-8?B?cFBnWXJvTTJzcXhzZ1ZSWWhMTG5MS096aEU0VEFVb0xNVHJVbXVoSlFmVUp5?=
 =?utf-8?B?SnV1VmlzZXpKUGpuNkljWmhVSiszSDJZaGx4WmNJWktqQ1MzTnJ1V2JCcWxn?=
 =?utf-8?B?anJicWpBWm4zbHVhbGZIWDY3OGNTYk5GRytNU0U0NGNvbGZicnR6dXlORjc2?=
 =?utf-8?B?NkhINm5Pajk0RDhubjNOS1gyQndyNTFvTi9lcE5DSGkvVEptVjdrV0lzTW5G?=
 =?utf-8?B?cU1CTFJ6VTBZeUhIVHR2bTRacTBtQVQ5UFBBTVh3TjZ0eloxaEtXcGxBQUtw?=
 =?utf-8?B?OFF1K1IvQ0R5TDM5ZnRaSmprL2hETVZsalBjUlYvemg2KzA0S2NHcXFsM1Zw?=
 =?utf-8?B?RTRGRUNXQ0ZETEZPZlRBS3UzSzdNR1BzZVhndGZMWHRqeVRKOVRieFF2aXZr?=
 =?utf-8?B?MXZNQlJ5M2g1R3ZITkNwUzRFQXA1Z29yM3llOU8wd1h3dC9wNVJ6UVNaaFZK?=
 =?utf-8?B?Y2Z2d3ppZlFQeUN3UFlmL2doL0V4K1ArUDBWQXNPUHRkZEh4S0NJb3hCODJy?=
 =?utf-8?B?b1FuYitpRG5aTlhuSFEyd2l1Zmh3bW9FMHZZcW1RTnZRZmFuM1QxdTd2ckJm?=
 =?utf-8?B?ZFRERnZTRXlFRmVsRzVzSTJsZC96UkI0OXZ0Q2lHTWJleUQxUWFzOHprMGhm?=
 =?utf-8?B?UUdtNGpLenUyRnlwckhZd3QyVjlPOU40emkvK3FVZnpNOHY5VndNbS9oTlJR?=
 =?utf-8?B?RWZZamF1d2RsRmV5UXR5WGRjZ0ZGcFh2OUJhVEhEUVk4c3IvenRhekdMODFW?=
 =?utf-8?B?dmZtNGpLSG14M3RoRU11bEtMdzJWKzlOK2sranh1TUs0Q0JNbnFwbjRySnVz?=
 =?utf-8?B?U0FTdnpIM3kvSDZJNDRhQUIzY2RrMmF2TVRWTTNVQXF2K2R2Z2o4cll6TldH?=
 =?utf-8?B?ZWU2R042SkxkUXVuam5TbTB2d3V1TU05bXpHeGxleTVtSmxHMlU4dzhjN2Qr?=
 =?utf-8?B?TkJGOXJxT2hTQVFjZExGRVZxc2JpV2FvQmp3Y0dVaXljaFpJTjJkSTAzazJq?=
 =?utf-8?B?OG4ySGJDZG9rT3Z3NWRQQmlIczdzbUFHWW40U2V2bHRMTFBmMkNvMjRNMWth?=
 =?utf-8?B?QnhUcmxlUlhhRFJJT2YzRzVKaEF6L1A2VW04MjBhbzZQejhodFRKNUJqa3R1?=
 =?utf-8?B?UGJwRW1NR0oyYWxxemJpcVlzU3hqemJQdlJBdDlwY0Y4cFBRZEd5cXZXTmFF?=
 =?utf-8?B?eFlrZkVVR01nRTdqeGxmTXpIMUFuSG9rNjlHd05tZnlNZ0lqS1FtYmducWVy?=
 =?utf-8?B?RmhkSmJxbnJXV2ZkZ3lhamE4TkxlVGdmSUpxSWhRVS9UVUtlNkJIS1p6TkNJ?=
 =?utf-8?B?WlRiaU9RbFdWQjdjN3NaSm4yQWl6NG9PMU03bFB5V1J5by9SSDlEWWw1Y1do?=
 =?utf-8?B?aXBzUXpIbks2cnk3SG1qNWM4c2lkcW4xM1lNenFuaE5FcUtyRUJWU2lYNGJR?=
 =?utf-8?B?K2ZyY3V4cjhxQURvZ1ZDbllWQi8xRERpVGxZV3lpUjNRSDc5ZjBnVDg4anI0?=
 =?utf-8?B?L1lac2lUM3dZNzJGdVkwYWNxRjhKZHlOU3pFaG5SbThPMUw5N3dUSmdLdm43?=
 =?utf-8?B?Y1ZoUVN1eFlPYVIyL1BheXh3WlZWbVZLVHJiek9oN2xLclNldTlwL21XOWk3?=
 =?utf-8?B?NjNJUE5tZGJOa2l2V1pnK3czRHpUNnpDQU11UytjT2JWVHRhSEhmaVNvVWxU?=
 =?utf-8?B?RHlZV2ZzcEVRZUxyU2gwaXp3RUhRYlliWUxYMXFrNVdiZHl2U2FaQW1Qc3ZE?=
 =?utf-8?B?alA3anZvZnc2Mk1kQUoyNXpXNzgyd2l0aDlZaFFpMXp3Q3JHNm01WGZ0dHpX?=
 =?utf-8?B?S2t5dEVLOWFTbmQ1SEU5elBFVURaS1JMM0FnUjJ3am9RNFNTNXF2TTRPdWVs?=
 =?utf-8?Q?7t/m9NS+9VT+U+3t8RuEi98AQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa532de7-4a1a-4173-c12e-08db4d37540b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 07:07:03.1091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k65q3hfiMvcdr07zLjER9moJkc/IUp3w5MPeHFMsfI19Bd/xRr0Pk7clBnBGBVLPSmPg6UxZbhh9whZaFLxI/cN0B5YOSfaGhJuShZz8pFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBUaGUgZGF0YXNoZWV0ICJNQ1AyNXh4RkQgRmFtaWx5IFJlZmVyZW5jZSBNYW51YWwiIHNheXMg
aXQgbmVlZHMgYW4gaWRsZQ0KPiBidXMuDQoNClRlY2huaWNhbGx5IHdoYXQncyBuZWVkZWQgaXMg
YW4gaWRsZSBjb25kaXRpb24gb24gdGhlIGJ1cyBhcyBzcGVjaWZpZWQgaW4gdGhlIElTTy4gaS5l
LiAxMSBjb25zZWN1dGl2ZSBzYW1wbGVkIHJlY2Vzc2l2ZSBiaXRzIGFmdGVyIGEgZnVsbCBmcmFt
ZSAoaWYgb25lIGlzIGN1cnJlbnRseSBpbiB0cmFuc21pc3Npb24pLg0KDQo+ID4gVGhpcyBzZWVt
cyB0byBiZSBuZWNlc3Nhcnkgd2hlbiBjb25maWd1cmluZyBsb3cNCj4gPiBiaXQgcmF0ZXMgbGlr
ZSAxMCBLYml0L3MgZm9yIGV4YW1wbGUuIE90aGVyd2lzZSBkdXJpbmcgcG9sbGluZyBmb3INCj4g
PiB0aGUgQ0FOIGNvbnRyb2xsZXIgdG8gZW50ZXIgJ05vcm1hbCBDQU4gMi4wIG1vZGUnIHRoZSB0
aW1lb3V0IGxpbWl0DQo+ID4gaXMgZXhjZWVkZWQgYW5kIHRoZSBjb25maWd1cmF0aW9uIGZhaWxz
IHdpdGg6DQo+ID4NCj4gPiAkIGlwIGxpbmsgc2V0IGRldiBjYW4xIHVwIHR5cGUgY2FuIGJpdHJh
dGUgMTAwMDANCj4gPiBbICA3MzEuOTExMDcyXSBtY3AyNTF4ZmQgc3BpMi4xIGNhbjE6IENvbnRy
b2xsZXIgZmFpbGVkIHRvIGVudGVyIG1vZGUgQ0FODQo+IDIuMCBNb2RlICg2KSBhbmQgc3RheXMg
aW4gQ29uZmlndXJhdGlvbiBNb2RlICg0KSAoY29uPTB4MDY4YjA3NjAsDQo+IG9zYz0weDAwMDAw
NDY4KS4NCj4gPiBbICA3MzEuOTI3MTkyXSBtY3AyNTF4ZmQgc3BpMi4xIGNhbjE6IENSQyByZWFk
IGVycm9yIGF0IGFkZHJlc3MgMHgwZTBjDQo+IChsZW5ndGg9NCwgZGF0YT0wMCAwMCAwMCAwMCwg
Q1JDPTB4MDAwMCkgcmV0cnlpbmcuDQo+ID4gWyAgNzMxLjkzODEwMV0gQSBsaW5rIGNoYW5nZSBy
ZXF1ZXN0IGZhaWxlZCB3aXRoIHNvbWUgY2hhbmdlcyBjb21taXR0ZWQNCj4gYWxyZWFkeS4gSW50
ZXJmYWNlIGNhbjEgbWF5IGhhdmUgYmVlbiBsZWZ0IHdpdGggYW4gaW5jb25zaXN0ZW50IGNvbmZp
Z3VyYXRpb24sDQo+IHBsZWFzZSBjaGVjay4NCj4gPiBSVE5FVExJTksgYW5zd2VyczogQ29ubmVj
dGlvbiB0aW1lZCBvdXQNCj4gPg0KPiA+IEZpeGVzOiA1NWU1Yjk3ZjAwM2U4ICgiY2FuOiBtY3Ay
NXh4ZmQ6IGFkZCBkcml2ZXIgZm9yIE1pY3JvY2hpcA0KPiBNQ1AyNXh4RkQgU1BJIENBTiIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogRmVkb3IgUm9zcyA8ZmVkb3Iucm9zc0BpZm0uY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+IC0tLQ0KPiA+IENj
OiAiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4NCj4gPiBDYzogRXJpYyBE
dW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiA+IENjOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiA+IENjOiBMaWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29t
Pg0KPiA+IENjOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gPiBD
YzogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gPiBDYzogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+ID4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVs
Lm9yZz4NCj4gPiBDYzogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiA+IENjOiBU
aG9tYXMgS29wcCA8dGhvbWFzLmtvcHBAbWljcm9jaGlwLmNvbT4NCj4gPiBDYzogV29sZmdhbmcg
R3JhbmRlZ2dlciA8d2dAZ3JhbmRlZ2dlci5jb20+DQo+ID4gQ2M6IGxpbnV4LWNhbkB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4ZmQvbWNw
MjUxeGZkLWNvcmUuYyB8IDQgKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2Fu
L3NwaS9tY3AyNTF4ZmQvbWNwMjUxeGZkLWNvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L2Nhbi9zcGkv
bWNwMjUxeGZkL21jcDI1MXhmZC1jb3JlLmMNCj4gPiBpbmRleCA2OGRmNmQ0NjQxYjVjLi45OTA4
ODQzNzk4Y2VmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeGZk
L21jcDI1MXhmZC1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXhm
ZC9tY3AyNTF4ZmQtY29yZS5jDQo+ID4gQEAgLTIyNyw2ICsyMjcsNyBAQCBzdGF0aWMgaW50DQo+
ID4gIF9fbWNwMjUxeGZkX2NoaXBfc2V0X21vZGUoY29uc3Qgc3RydWN0IG1jcDI1MXhmZF9wcml2
ICpwcml2LA0KPiA+ICAJCQkgIGNvbnN0IHU4IG1vZGVfcmVxLCBib29sIG5vd2FpdCkNCj4gPiAg
ew0KPiA+ICsJY29uc3Qgc3RydWN0IGNhbl9iaXR0aW1pbmcgKmJ0ID0gJnByaXYtPmNhbi5iaXR0
aW1pbmc7DQo+ID4gIAl1MzIgY29uID0gMCwgY29uX3JlcW9wLCBvc2MgPSAwOw0KPiA+ICAJdTgg
bW9kZTsNCj4gPiAgCWludCBlcnI7DQo+ID4gQEAgLTI1MSw3ICsyNTIsOCBAQCBfX21jcDI1MXhm
ZF9jaGlwX3NldF9tb2RlKGNvbnN0IHN0cnVjdA0KPiBtY3AyNTF4ZmRfcHJpdiAqcHJpdiwNCj4g
Pg0KPiBGSUVMRF9HRVQoTUNQMjUxWEZEX1JFR19DT05fT1BNT0RfTUFTSywNCj4gPiAgCQkJCQkJ
IGNvbikgPT0gbW9kZV9yZXEsDQo+ID4gIAkJCQkgICAgICAgTUNQMjUxWEZEX1BPTExfU0xFRVBf
VVMsDQo+ID4gLQkJCQkgICAgICAgTUNQMjUxWEZEX1BPTExfVElNRU9VVF9VUyk7DQo+ID4gKwkJ
CQkgICAgICAgbWF4KE1DUDI1MVhGRF9QT0xMX1RJTUVPVVRfVVMsDQo+ID4gKwkJCQkJICAgNTc2
ICogVVNFQ19QRVJfU0VDIC8gYnQtPmJpdHJhdGUpKTsNCj4gDQo+IExldCdzIHVzZSBDQU5GRF9G
UkFNRV9MRU5fTUFYICogQklUU19QRVJfQllURSBpbnN0ZWFkIG9mIDU3Ni4gSSBjYW4gZml4DQo+
IHRoaXMgd2hpbGUgYXBwbHlpbmcuDQo+IA0KU28sIEknZCBzdWdnZXN0IENBTkZEX0ZSQU1FX0xF
Tl9NQVggKiBCSVRTX1BFUl9CWVRFICsgMTEgKyBzdHVmZmJpdHMsIGFzIGZhciBhcyBJIGNhbiB0
ZWxsIHRoZSBDQU5GRF9GUkFNRV9MRU5fTUFYIGlnbm9yZXMgc3R1ZmZiaXRzLCBzbyBhcyBhbiBv
dmVyYXBwcm94aW1hdGlvbiBzb21ldGhpbmcgbGlrZSAoQ0FORkRfRlJBTUVfTEVOX01BWCAqIEJJ
VFNfUEVSX0JZVEUpICogMS4yICsgMTEuIEl0J3MgdW5saWtlbHkgdGhhdCBpdCB3aWxsIGFjdHVh
bGx5IGJlIG5lY2Vzc2FyeSBidXQgaXQgbWFrZXMgaXQgY2xlYXIgd2hlcmUgdGhlIG51bWJlcnMg
YXJlIGNvbWluZyBmcm9tLg0KIA0KQmVzdCBSZWdhcmRzLA0KVGhvbWFzDQo=
