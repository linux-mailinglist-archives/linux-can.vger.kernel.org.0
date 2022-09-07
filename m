Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2627C5B0D19
	for <lists+linux-can@lfdr.de>; Wed,  7 Sep 2022 21:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIGTTx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Sep 2022 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGTTv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 15:19:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E205632044
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662578389; x=1694114389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JCe7tmerDZ0LC+uU+rVjtcevNqB7B3osBdLsazSeCQo=;
  b=WYVxrSItokLQiymS2akmPpCCShPQBGxDR0LJXAuTxjNzGagOffPzt1gI
   4I6k7ZKeMdizMyTM+mBfddemrtzZzvxQsR+fHmamyoQU+UD/GtYQGC/n7
   C0u6mJ6RLyE2SGfNGNBKBjKrJLHlbgDcig4Atmex+t0hUKZ74yDdyEIMV
   ZckpG6n/X57JrsZt6DrSAZx5RnVLtrNV3dBPV7kwzXfvaYy+H1LH7AJyk
   nwo16QBIQrvGr9Yf7nGLaTDDFTN3fQBijjbv4/XeN2l9Jdc9ih3+wj7s6
   bsf+lswz/8vvozR8IyoxYik6sRAzCtnhTyTPOQsCi7Mn+MEjEZGhR/w9r
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="176084219"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 12:19:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 12:19:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 12:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqtYjI18wfUdHbZRQEBfGjanF0xMEJCvQ0zSgc3/hlmTJgcTjrisRaC+ijOzccuPi+FOXhjj7na7OLQjv74Jq2dJYgldWCmryaT90UhEJE1fuqc1gZqR6Bm4VDgDm0+0JxAUuydveih5wWhSUF6/iKaJiSbUMO4YCfpndOKcxJjhl4a1pRIfEquS7VtaM6Rxsj+Aqdo/SdYb/d2SvqJ1jHP+ssnyIcQYaIkO+HJ/Ds20a3hyon5dGwYlgpgVEcy1zmAhnkJo90Pm+f4yztM9SrpXADYT+9wSV870vyGJrl9cmHmVuWgJh81rv3wlsCcmCLald9dS2XuJS4WJ+LaEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCe7tmerDZ0LC+uU+rVjtcevNqB7B3osBdLsazSeCQo=;
 b=frVSi4TrEyyfYCm7OSayL9kkBMTIzi5PlZdc00rBdBBKSwWv4+6m7QX+aHsAGDEeAExVk50fle5MxqX21cYdhOxb8+psYM8kKuaiPhlmLsQhgZN4T5/jCjDYJwgqGtnax/Y+w7iCe2xhhFf0z9M8x+tEJe/UYezXkYYooSc8OCE23JWO6ixrDbCzTkd47gzOFocPEUsUuHDebhhiNTnYKZgmEuGdCUu6yzL6SXyFN8BjAsUQv0+UJjTGH7VOdQmv18Hofte96zASO1PsNgMflwhxgU3FfBTgldEKO6uEpWaloQyNJo++TiG+KTjj01xbrG1ZPcjpgu6x11FwbuZ0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCe7tmerDZ0LC+uU+rVjtcevNqB7B3osBdLsazSeCQo=;
 b=Z8io5016DOM2USvTbYplADXoOAevQ8TypInGlLm62e/vfsTlAZElQ12CsHkCo6Q0OdliAHcVJA6ogalJt+1/3FuXIxjdezoLZ1+PWlLNzVhV2lY3R+c9Zqj6sjmYHdS5Vizfl5PGa1XtszM/GO0WvUKzW11dTZrxLYd9IqWMIKQ=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by BN6PR11MB1316.namprd11.prod.outlook.com (2603:10b6:404:3c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Wed, 7 Sep
 2022 19:19:43 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::a87f:f853:52d8:9378]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::a87f:f853:52d8:9378%5]) with mapi id 15.20.5588.016; Wed, 7 Sep 2022
 19:19:43 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <mark@baggywrinkle.co.uk>
Subject: RE: [PATCH 5/5] can: bittiming: can_calc_bittiming(): use Phase Seg2
 / 2 as default for SJW
Thread-Topic: [PATCH 5/5] can: bittiming: can_calc_bittiming(): use Phase Seg2
 / 2 as default for SJW
Thread-Index: AQHYwqZka3m5utakhUurCga9Z9T8Y63UUyGw
Date:   Wed, 7 Sep 2022 19:19:42 +0000
Message-ID: <BL3PR11MB64844BD45DE7FDE94BDE47BCFB419@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-6-mkl@pengutronix.de>
In-Reply-To: <20220907103845.3929288-6-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7ca1d12-bcde-4289-f2ea-08da9105eb07
x-ms-traffictypediagnostic: BN6PR11MB1316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S2qWR9aPxPPOS2Ev2bYacUIGd7kM8BJYqOXb0aGyi9mkeziefy3MMh+2mCsNQQGKNDfhMB55qDePigX82rv5uH3tkbDHZG5jyBQQsyGIpuK21xcAVXQFy0asn/uXKyCBu5JbcbSTODZTzTR0XvtDj0/6bXkUeiJTmiBFLDSbR6p6D/iKDpalFSCD/p8PfkYj4hsUZScL/hJx0z9jSJd8Q9te8Pjx2Vw+KKpJv81omSXBi43TnpxiiTzguA+7ey6zAnkZcS1XAk9EA6l4rnDvE7gEoZGX2wEjf02jSSVZHdLHivdbRDtJR3+l0VEuqFh0ov8oXROSQN5ZMvKvRQ6bGObQyeXL0xIyo/DrbZ4IRccXfLg4vn42GxgaMptag3MFVvkM8DZ9/kLVzUa48QBNcplHefNNzMKpmgg362/uEu3AyaYhx+a6z18zeLeyS6hRk6G0RdGjojxe/C7CvSNCXmK6veQk55xBWBOrLgw1qxxyRDOd7mKxwjlbleiwICzsHHA5Ql50yF+pbqOZ8pNrFCcm4r/JkRRBDoljWW35uzfsik7wCwgWnRSJJ1cKwqdwi7MSJmtuy+BCa1qZIgG/C4mDyPU9A+nk7VNQ6D4rbGJ2iKmTjA5HW1okxrxmhPlXP1Qfk69XT1qzXS5mm706HkTQjlqR1jRMdF8+hibqdQ94JYCMa1boFJZY6GcjXilGN+/QATPm/yApkOtfMkfUOsUyeJ8lvW6oNH+x6iiLZYvaAloR1cPjO7SU1qioUOhkLQgiyQVNSk/PlR7akkZYmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(136003)(39860400002)(346002)(366004)(8936002)(186003)(55016003)(52536014)(33656002)(86362001)(71200400001)(9686003)(26005)(478600001)(7696005)(6506007)(38070700005)(122000001)(41300700001)(83380400001)(4326008)(8676002)(316002)(110136005)(38100700002)(5660300002)(2906002)(64756008)(66446008)(76116006)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTBXQjZnQnBPY0ZISWR5ZGpMUWNiRmFJRDlvUUZMRTRvZkNVVFJvMzgyaDlL?=
 =?utf-8?B?VzV1UHhrQWQrWGtWcXZCQ3ZxYWR0VFA5d2hmeEp1cUZMUU5rUzlmRlBOaFBL?=
 =?utf-8?B?WFFwVUFOMjY1N2pSdGxmN3NsOTJ3UUp1UFFuOEZUM2JzS3NzVEdzck5keWNI?=
 =?utf-8?B?YkRKT0RlK0M3aXA3eEVidUNFUDJKTjNkdFlTNHIrbmsweXF0eFNFcU9KL3py?=
 =?utf-8?B?eGtnZHZtc3lleG8xSC9iZ2xRdTRHR2E5ZzNYMFkrN0x2QWI2Vm9uSWpjUkRP?=
 =?utf-8?B?R2hRbW1WWElWa29OczRTTWNBUW04TmdwcFhvcWQxUWNVdVVQQS9WMzRFTzRS?=
 =?utf-8?B?MWJ0ekhHSVVlbXN1QkZHTmRXcUVnQmJhNHMySTF2akJRUlk4UGlza3FYaUJ2?=
 =?utf-8?B?NFJZUnF5Vm0rM1U5bjJxWXoxNVRFMmdjbDRqQm9vVjRBOWpOMVpKKzdtL1dk?=
 =?utf-8?B?YVVIVmpmUzBmcEZvSE83U0ZPcHNOVTNzdCtaZW12REx0dFVST2dZQXUxMncv?=
 =?utf-8?B?d25aUEJWd3hCeFArTkc2VmNrSEF4QnZhMVFVNFZjRytqbUZtTjRnTlBkQnJ4?=
 =?utf-8?B?TXFMNTdjd2wwdmlrd3psZ2NUT3NBeCtCK3ZlaFFsa09VSk9INnptemowR2tK?=
 =?utf-8?B?RXprNnY2emVTOW1ZMnFtWmhjMk1TOWRVK1ZjZkRmRUJTUEN0ZzE2eWpoOXl4?=
 =?utf-8?B?TTc1U0o1TW9jeG9HdjZPVGVJdVhKbFdJOENNR1VMWW9WeW9EMVFyaUljbUZT?=
 =?utf-8?B?UnlmMjJLcDBFR1dmZ0g2dWxtaEtVbkFEdlpwZUxSaS9DZ0wyZ3pHeGJrOGxO?=
 =?utf-8?B?YWdYSExnYzVSQXZERDVjZGNFbGdDL0pWOEdkQWF4TnJBYXV3Zm1KbWgwYjJS?=
 =?utf-8?B?WW9rcCtuRWVNdkdkVXIvdGNKOVZhUm5nZ1drSDFFUjltRXpibFVwYjA5MXRp?=
 =?utf-8?B?YXdKcUdVRU9HSzBXZlQ5TDZnYmxYbHEzQUJ5SCtaNEVQa05WV3Ixa3R6VVhG?=
 =?utf-8?B?bXVWMkdqODdBc1c0TmtPbTAxYkpxM3lXdzNaMEdjRzNHZ0NOQWhkTkhON0Vp?=
 =?utf-8?B?QWtzc2dlTThGd3lleGNrV0tvWUlUcGNycUZHKzlLYmkveitsSXdvSjNBMjFi?=
 =?utf-8?B?TVZXdzdhamZ6Q081aEEySEtPRURnN2N1R0pSTFdXZ054b1A2WnpveWpNUlVD?=
 =?utf-8?B?aVN6UGRsUFBZWXltNVdKUlRQVmxpWUl4ZUoySVJQNHIvNWo0UmwvZ2Z5bDlE?=
 =?utf-8?B?ZG5PVW1tZjhmc1cyQUZhUDhzTDNzSnFwOGpNeFA1VFRUYTJPUWVsYTk2aUtD?=
 =?utf-8?B?em9ienUyU0RBV1hxYk9iTWhxSDdjcm9rd01kcUc5SFBkL0RvdWhjUjBHc1V2?=
 =?utf-8?B?aG5NYlQyNjlraW95d3NIOC8vUE80V0NBWTlyZnF5ZmpiTlhOakZPdVRNQWNB?=
 =?utf-8?B?OFczQnhsbEFRc0QxZXoxbTd4NklhalJTdmRDdUFZajBuSnV4NmRBbWRFRlJB?=
 =?utf-8?B?SmdTS1VJaCttSWZ1a2RUbWZkRjdTajk0d1VJWTdDS3d1Mmo5RnF5c0k0RVp1?=
 =?utf-8?B?OU9YdUlvY2JZaGR6QzhsN3U5cmFqaHJVNGd3Mm1CMTJXZEFOV2x4cnFDQTZi?=
 =?utf-8?B?ZTh0aldjMGtBbDZYeDNFV1JNSVVzWjZ1WUVORXB3b2gyY3doZ2xKWmhpRXY0?=
 =?utf-8?B?eThGSi9BeWRWV0ZyTWlSMFpoVWtlNUhZWVQ2cTRYajVVQzN3cEFSOFQ4YUpW?=
 =?utf-8?B?enQzejVSN1ZCOE81WEhiektTMTJxR0FycHg5MDE3bjBBV21hdDYzdXFXckc2?=
 =?utf-8?B?b0ZBd1NUZW41VW0zSmpCRjhsUTF2TUN2V2lrY2NuWDFtOU1xbUtueGVORWN5?=
 =?utf-8?B?N0ZYZUQrK0MwS21ialZIdDEvVVh1cHY1NTJ4MXBmRmwvMFJ6dXd6ZngxdVU4?=
 =?utf-8?B?UjdsMElBQ0k2R1M5aDJSTDM5dnJWSk91TWNOeXJ6Wm9hTjd4cHFjcjdjYXhl?=
 =?utf-8?B?cytlV2FkUVZNZkx6b05KU2lmS3QwdWl6d2NYdXVvdzUzRzBCUXozbVFVaGtF?=
 =?utf-8?B?SFhmSDJUbVdjeXVxOThXaDZscmFxREkvSkRlOC9keXVycFV4bnFDcml0UHFj?=
 =?utf-8?B?Sm1ZRjV6NlBCNnRNNHpKQVNCVGR6R2ZsbTY5MlFxNU5kSU44ckQyOFJ6UzNH?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ca1d12-bcde-4289-f2ea-08da9105eb07
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 19:19:42.9908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzNBdJtCi7LyoWxGrsYr4r+YuNJgXANxKpKXn3qUvNRTK8x+DZIgZB815EeRbzzHUv3tutx3/+wRrCdKdk5NWR0AQqOVX4fizVG4LEYwxw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1316
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KPiBJbiBvdGhlciB3b3JkcyB0aGlzIG1lYW5zIHRoZSBTSlcgcGFyYW1ldGVy
IGNvbnRyb2xzIHRoZSB0b2xlcmFuY2Ugb2YNCj4gdGhlIENBTiBjb250cm9sbGVyIGFnYWluc3Qg
dGhlIGZyZXF1ZW5jeSBlcnJvciBjb21wYXJlZCB0byBvdGhlciBDQU4NCj4gY29udHJvbGxlcnMu
DQo+IA0KPiBJZiB0aGUgdXNlciBzcGFjZSBkb2Vzbid0IHByb3ZpZGUgYSBTSlcgcGFyYW1ldGVy
LCB0aGUga2VybmVsIGNob29zZXMNCj4gYSBkZWZhdWx0IHZhbHVlIG9mIDEuIFRoaXMgcHJvdmVk
IHRvIGJlIGEgZ29vZCBkZWZhdWx0IHZhbHVlIGZvciBDQU4NCj4gY29udHJvbGxlcnMsIGJ1dCBu
b3QgYW55bW9yZSB3aXRoIG1vZGVybiBjb250cm9sbGVycy4NCj4gDQo+IA0KPiBUbyBnZXQgdGhl
IHNhbWUgb3NjaWxsYXRvciB0b2xlcmFuY2VzIG9uIGNvbnRyb2xsZXJzIHdpdGggd2lkZSBiaXQN
Cj4gdGltaW5nIHJlZ2lzdGVycywgY2hvb3NlIGEgZGVmYXVsdCBTSlcgdmFsdWUgb2YgUGhhc2Ug
U2VnMiAvIDIuIFRoaXMNCj4gcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIGJpdCB0aW1pbmcgcGFy
YW1ldGVyczoNCg0KDQpUaGFua3MgZm9yIHlvdXIgd29yayBvbiB0aGlzISBNYXkgSSBhc2sgd2h5
IFBoYXNlIFNlZzIgLyAyIGlzIGNob3Nlbj8NCg0KSW4gZ2VuZXJhbCB0aGUgcmVjb21tZW5kYXRp
b24gaXMgdG8gY2hvc2UgU0pXIGFzIGJpZyBhcyBwb3NzaWJsZS4gSGVyZSdzIGFuIGV4Y2VycHQg
ZnJvbSB0aGUgQ2lBIDYwMS0zIChVbmZvcnR1bmF0ZWx5IEkgY2FuJ3Qgc2hhcmUgdGhlIGVudGly
ZSBkb2N1bWVudCkgDQoiUmVjb20yOiBDaG9vc2Ugc2p3QSBhcyBsYXJnZSBhcyBwb3NzaWJsZS4g
DQotIFRoZSBtYXhpbXVtIHBvc3NpYmxlIHZhbHVlIGlzIHNqd0EgPSBtaW4ocHMxQSwgcHMyQSku
IA0KLSBEdXJpbmcgYXJiaXRyYXRpb24gcGhhc2UsIGEgbGFyZ2Ugc2p3QSBhbGxvd3MgYSBDQU4g
bm9kZSB0byByZXN5bmNocm9uaXplIHF1aWNrbHkgb24gdGhlIGxlYWRpbmcgdHJhbnNtaXR0aW5n
IG5vZGUuIA0KLSBJZiB0aGUgQ0FOIGNvbnRyb2xsZXIgZG9lcyBub3QgYWxsb3cgY29uZmlndXJp
bmcgdGhlIG1heGltdW0gcG9zc2libGUgc2p3QSANCmJlY2F1c2UgdGhlIHZhbHVlIHJhbmdlIGZv
ciBzandBIGlzIGxpbWl0ZWQgaW4gdGhlIENBTiBjb250cm9sbGVyLCB0aGVuIGNvbnNpZGVyIA0K
aW5jcmVhc2luZyBCUlBBLiBUaGlzIGFsbG93cyBjb25maWd1cmluZyBhIGxhcmdlciBzandBLCB1
bmxlc3MgdGhpcyBjYW4gaW1wYWN0IA0KcGhhc2UgZXJyb3IgdG9sZXJhbmNlIGluIGFuIHVud2Fu
dGVkIHdheSwgc2VlIFJlY29tNC4iDQoNCkkgdGhpbmsgd2UgZGlzY3Vzc2VkIHRoaXMgYSB3aGls
ZSBhZ28gYWxyZWFkeSBhbmQgdGhlIGJpZ2dlc3QgcmVhc29uaW5nIGFnYWluc3QgbWF4aW5nIFNK
VyB3YXMgYnJlYWtpbmcgImNvbXBhdGliaWxpdHkiIHRvIG9sZCBrZXJuZWwgdmVyc2lvbnMuIFRo
ZSBjb21wYXRpYmlsaXR5IGluIHRoaXMgaXMgbm90IGJlaW5nIGFibGUgdG8gc3luYyB0aG91Z2gu
Li4NCk5vdywgaWYgYSBjaGFuZ2UgdG8gYSBsYXJnZXIgZGVmYXVsdCB2YWx1ZXMgaXMgYWdyZWVk
IHVwb24gd2UgbWlnaHQgYXMgd2VsbCBjaG9zZSBtaW4ocGhhc2VzZWcxLCBwaGFzZXNlZzIpIGRp
cmVjdGx5IHRvIG1heGltaXplIHJvYnVzdG5lc3MgZm9yIHRoZSB1c2VyIHRoYXQgZG9lc24ndCBz
ZXQgaXQgZXhwbGljaXRseS4gR2l2ZW4gdGhhdCBtb3N0IG9mIHRoZSBnZXR0aW5nIHN0YXJ0ZWQg
d2l0aCBTb2NrZXRjYW4gcmVzdWx0cyBvbiB5b3VyIGZhdm9yaXRlIFNlYXJjaCBlbmdpbmUgZG9u
J3QgZXZlbiBtZW50aW9uIFNKVyB0aGF0J3MgcHJvYmFibHkgYSBzaWduaWZpY2FudCBwb3J0aW9u
IG9mIHRoZSB1c2Vycy4gRnJvbSBhIHB1cmUgY29tbXVuaWNhdGlvbiBzdGFuZHBvaW50IEkgY2Fu
J3Qgc2VlIGFueSBkb3duc2lkZSB0byBkb2luZyB0aGlzLCB0aGUgb25seSBoeXBvdGhldGljYWwg
Y2FzZSB3b3VsZCBiZSBpZiBhIENBTiBjb250cm9sbGVyIGhhZCBhbiBlcnJhdHVtIGFib3V0IGhp
Z2hlciBTSldzIGFuZCB0aGUgZHJpdmVyIG5vdCBoYW5kbGluZyBpdC4NCg0KU28sIGluIGVzc2Vu
Y2UsIEknZCBwcm9wb3NlIHRvIHVzZSBtaW4ocDEscDIpLg0KDQpCZXN0IFJlZ2FyZHMsDQpUaG9t
YXMNCg==
