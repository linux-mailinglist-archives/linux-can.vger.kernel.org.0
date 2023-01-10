Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620276640EA
	for <lists+linux-can@lfdr.de>; Tue, 10 Jan 2023 13:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbjAJMuZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Jan 2023 07:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjAJMuW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2023 07:50:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9CC5004F
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2023 04:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673355022; x=1704891022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zATDKQZJMDOS4iKt7shVfXgAb7QWXtuwJaosSYKj+mo=;
  b=BtVWVi4RFvO2ELJgmqfdFNucNxdWJ6a9U40AJguD6wr0L5eDSfzHRLl0
   irIO4BGBZI0K/LmDighPvnFJN651pXYdnFtHS7lbMUVet+rZ1lG2kbrwY
   2Lc0nkywA0As84pKYN9HJuTRS87/2JNxAQYbBkLLp+bBMrRssk2vWuUky
   jdA9o/iTdAX+k6Pf0HeAlpxtYS+7Qj125V2Fbe6G1RPswPQ9gtpGUGWDb
   hbnMI2gb7i2mZWpIijN5f0ynsqVmlzTx16Qa0LRXPtG2ihqY18PJCi18i
   zAJq9/24ek7e3Lte3YjV+tFi/25aPy1FDcPuiGDjyXKq3Hn/CnkziYSp6
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="195079098"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jan 2023 05:50:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 05:50:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 10 Jan 2023 05:50:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH69r8LBLasF9Net31SQNC/LfgflcWUvhJ405YrOJf0ZFm9qlTP4IM5R6FHx46q6Pq8julGG8fmpyuIGVOdUzMRNWG+yqfh/lnJm42Bdqha5LIItN33senD/Eb45baH/8a6C3lTDdyx3On1OC+j0ZOKu/LMzglmJso7/6P97iXb1MFgHFdnaLqCUBEqn/6R3UQy72BopwR3W94nf6m45NtEC4TYtwVM438ODaD7N1DFA3ezQ+yS9m05DLOHZz1Hc2oQfoDLjVkOrzYNAEqeyafoYh0kYgRGWZryMsOqFnvah5v4+7soVNJibAznzBbcz2TGHlCmPRVgVBAFtnRrTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zATDKQZJMDOS4iKt7shVfXgAb7QWXtuwJaosSYKj+mo=;
 b=gNo9BYm809JNu2oa0cfbdoNrYND+EcCxZTTzZV2dCqmSFOc4nAl/BoOHro+hSmZoFyQ8/TWyVxhHQyp7+tWgB+DsaW5XX5L5KRQSsZa5P6R/mF4ciRgQlTYMEgVufXg9HrR4fBTmdGyVXu1cs74bvXeNHABdCpHs7sHnX962mszcvweay4QWFNcyY7pfJGyVdsihjp9eB0YBRjrHt42AA96pJ/m9EmnwzU7QZ35Rqlq0Y3KJ63CFwCHZ+nkhaftQ0ckDk4GqHEj2JQ2sIOw+nQzAGZ0SQDv07IqvVnj4VzBHKhkTqKHrUP718FpKUm1z5sqqmeTKQErsGWoKAVOX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zATDKQZJMDOS4iKt7shVfXgAb7QWXtuwJaosSYKj+mo=;
 b=qdkpoMg0iCF60e8R1Nu9A1E8UeveFgaXYyb+PLU1tOuARZaSHQUM1osFqfit/FVRBYKnE1SjVo8922iUyT/OnWXdYnRtx3KAAMtbGdE6oGq2V8uPiEz+0w9XfofvHWUyvRNGcnz4AklT8wOMI2g6Q3HyNvuwIjWSJEbrnFkMHgs=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 12:50:18 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 12:50:18 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <Stefan.Althoefer@janztec.com>, <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>
Subject: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Thread-Topic: AW: AW: mcp251xfd: Bad message receiption (1/2)
Thread-Index: AQHZI/l4ok8+oI6xUkm6kTnSDPwpj66Xi/gg
Date:   Tue, 10 Jan 2023 12:50:18 +0000
Message-ID: <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <PH7PR11MB6498DA4A162106BD4ACB7551FBE89@PH7PR11MB6498.namprd11.prod.outlook.com>
 <FR0P281MB1966CA0C12ED24574368A36E97E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221222130219.xrfnm54g6lfjozvs@pengutronix.de>
 <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221224155705.l6qx3xu34nmo3ehn@pengutronix.de>
 <FR0P281MB196615471DB16E566528E7F097F09@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966783A50BDAD455BBC7F1A97F69@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966543302DB6485C49F8A2E97F59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|CO1PR11MB4945:EE_
x-ms-office365-filtering-correlation-id: 1cb4c037-820b-4db6-0b75-08daf3093a3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHfbe0+OiBEgnMJJBq6jS8I7LPYYS5B+wx7nt9LHEzOtMw6V/jAL5GNUdVQ45F/cqXMP16JBjM11GaxabDXYom4lAwO3aqQa0cl8nRE8/EgjGH+NO6JjxTOz5+lY8TAhAXqE/iPKoU9dcmCHW7xc07ZfDWQycStp/TZCC8nFjzMKkJkk+wzmkXoyQtfmguvz8jm61VFQoHWG3rQv6+uyCOX7wn8MVu3Rbxy2bRrJzOGnC8fUzjOSnLu+iFkQMI8+dlBnXpUwuu4h5X7uy1kENFOs24321/Z6zlmSjJbewoCKwTGM5jD+I5TDA/6tti6haeoETDafp+t2i+haEvdDHsi33isEQ9blDMLAal3W0/hmXqOyXp7IadU6g7Fqm3eNxVUF410z8HBwxKiUX6ujI4abToPKqayrLFTEoRhWbWnfVvMLnC2dNOMLKH8waxsOMcGGb95nUQOQEykdSlj7MiI+19qCyYpHMUK6kL3oM6F7m+D0A3keXsm8hraqSKOXAQCtjh99ZU/ljZKmGQWIwo6armfB1IjX92i0wD417MD3fWXN+2MlTO6wrpaopktydbmb9zRSttCIMYuvFDKKIy6jyibhwM2CUBZFtcYASo0iHnnJ5EjNpAWVTDqH3Sh3FydXO+NP8241s9X0y3I9iCoDwhAwYSah2HXeHsf3FJb2rIEqOYwq9P3HuTC77Uqn6T9wCzKYywCP0Qj65Rlztg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(64756008)(8676002)(76116006)(66476007)(66946007)(66556008)(66446008)(7696005)(316002)(4326008)(15650500001)(110136005)(38070700005)(2906002)(5660300002)(8936002)(71200400001)(41300700001)(52536014)(83380400001)(478600001)(33656002)(6506007)(122000001)(38100700002)(9686003)(26005)(186003)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3VqaTl0K1RuaFY2ZDhPRGVzaGlESjVUV3FkZFNkdFdyRUJEMUdSSWNTb2JT?=
 =?utf-8?B?Wm9zYlNDSlhUQ0dyeGh0TWlELzFMNDU3R0l2WjkyYUpyckRtcURZL2hmNkhw?=
 =?utf-8?B?SHJ4MzljQWJZMXdZaXg5eTh1L2VidXlrTSt6SXFWVGVZbEVyTStXZXlmMThS?=
 =?utf-8?B?UzJoeGlYNTdZc1hJNk5QRllqSUxsdGZVbmVSSHlUM2pZbElsZjRIeVhzalgw?=
 =?utf-8?B?d3RhZW1BNHZBc3FwUCtYWENLVVk3Z3lSNXdNN1BWTjhKSUwxRlBlYlNzb1hO?=
 =?utf-8?B?bWhPK3FIZFdLd3FQL2JBVWdHL1Y2TFhmbWxPbjVLMGpSZksraTYzdSsxazM3?=
 =?utf-8?B?VDBUWGJCL3J2VC80Sy80SjJZNmkyaTNtNzd1SC9aNDBtdGFRMGIvRzh4b0hz?=
 =?utf-8?B?a0E5Q0pia1VxZGV1dkZ2anJkNGhvL2UxaHJzeW1KSTJwaHdFSEJvMVUvaU1S?=
 =?utf-8?B?eERHOUo4em5tOXA2SEtYT2QzVzUydG1iRklEN0w0cVQxRkxTYmRNa1VkcHlJ?=
 =?utf-8?B?bDhIM0FzcEVZQitsM1V6aFp2VHl6ZzY1QlZ4MDN5UVhseE44dXV1V0hoenRG?=
 =?utf-8?B?aGp2K080ckxTdzNVYy9LNFRLbFFFZ3psZGVGUXJxZHVyK2hQdDZmVURicmpD?=
 =?utf-8?B?UzBvb3Fncm95ZUY0UzlsQ3N1eGlUV3JVbmlwcGw2SkNFRHN2R05HbCtJZkxr?=
 =?utf-8?B?R3IwV1VZcG8yaE9kdUJnN3JKdEpIbDR2NEdPcmd1S0t2bVMwR0wzTTNDVzlE?=
 =?utf-8?B?Z3pwVGp3bzV4TlltTkpaWVFEYVdTQ1pnNDhpSkUvTU9UaGpIaWJoakF2YWJF?=
 =?utf-8?B?WSt2WWk1TGRjbXhSTk5QbEVzSHRIY3MvbGFQbU83WDAxbTlTUG9OTXFUYW1V?=
 =?utf-8?B?WDJ6eFExWHkwaE44UTRYT0l4cjFRUXBnWmZ6YmJSR1lBeHA4dW9YRTQ4ZGE4?=
 =?utf-8?B?cWM2YWhVd3gybWVsVnUvekFETU1kdG9nOUNJdFE2TzMzK1k3SUtZTCtPMkF2?=
 =?utf-8?B?elFJZVllZWZZQS9YNHdjUFlQNFAxUGl4NmJsS2RqQXJiWEtYSXFwbmVUZVM4?=
 =?utf-8?B?ODRNcWFOb2FweVRucFQ5U3c0OXNJRUJMR0hVTjRQU0o5OVIyRFJXb2I2RXU1?=
 =?utf-8?B?VkNpVHBJM3FuTHc4K0N0cGREdkdJV1dqekwwL3dicHRvWmVvQ1BnWktDQk4v?=
 =?utf-8?B?endUTmUrNEIya2w5bE9LdHBIRjdxbFZtWmVVQUlDSWJONjhnbmRHRExJMW5O?=
 =?utf-8?B?eGM4SGFTVUozZzkwajJkT2tyekxNVENkdmlLY0s5TVM1VEtSYVFCKzFuVExI?=
 =?utf-8?B?c1RLZVpyWDVqM0s2MlZKSHhhbWlVZlBlOFVieWQwZXJ1emxXVmJXa3VFUVZl?=
 =?utf-8?B?R0FiTzZERzNsUTRJdFR0QmJtTmw2ZGwvdXUrays4Zzc1SlYxOFdadndhdjNR?=
 =?utf-8?B?c3pXUkIzb2ZwUEVPRHpHYzVweTdOMWNiS2t3cGdRVzZPVlZoTGZPWlVFZE94?=
 =?utf-8?B?ME90TmtWd1ZYVWZuTExNUnZNMmlQR3RQYlpYS1hBRHRDZnRwQU5qZlJwTHVM?=
 =?utf-8?B?ZDRRRlZJQysyYzd0Y0pVZzZMa21rcFA1dXhWa0ZLOExJcEd1am44R0JWRlFQ?=
 =?utf-8?B?U3JKNkpaS2U5ajdBZXNVMzM1R2tBeWUxM2dxclBUQ2ZaVWhtbld4SDJBWlkw?=
 =?utf-8?B?MFUra2VZS1ArUFJodkxrQ01iVHNpZlJBSlExRWZzeHFsRDRuUXJEQ3lnMHd2?=
 =?utf-8?B?c0tFd2p6RnBMUVpIQlR4dk14RDdvS2FLSjlQWWptNkFMWGRFQk9HQ01LbDBZ?=
 =?utf-8?B?dXNURWVZNDJiWUV2cDFYTFoySE1PVkc4QnV5Zy8va1k3S0ZiRnlwcWhDaDAw?=
 =?utf-8?B?OTlJdXBFZzRmMjRUV3MzQ3ltTWJmdzdmczlvM1dwV0Z6M2pMbGZYbXlzcG1i?=
 =?utf-8?B?dmFOZXZsSUJNQVg1cGxudjF6dGxYeDFtQWxISEJoN21HMmVNdUpOQWtEcGNX?=
 =?utf-8?B?U2ZCWHVUc0NuSyt2Tis1TU03UnpUaEVXbnVSN3ZONkZkYmx2c2FsQUhLMFAw?=
 =?utf-8?B?Nkc1T05BQW1KemM0VlNETUloUTd3Ty9obnI1dUdWVGVjcHczY3V4VjRBUHMv?=
 =?utf-8?Q?u7Ql28A/iCP3VBpNpzzwewjuW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb4c037-820b-4db6-0b75-08daf3093a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 12:50:18.3121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ug8zO9GM7vtlN3mL5ALP1phetI+5yleiECifWm0rZscuP2nXAZ8hPpyj+yOlKTh1UtP4QZrQFrj4tiugq6nyxArDla05KY6AfaCpeLPvMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBIb3BlIHRoaXMgZG9lc24ndCBzdGFydCB0byBnZXQgYW5ub3lpbmchDQoNCkFic29sdXRlbHkg
bm90LCBoYXZpbmcgdGhlIGRhdGEgYW5kIHlvdSBkZWJ1Z2dpbmcgdGhpcyBpcyBoZWxwZnVsLg0K
DQogDQo+IEZvciB0aGUgbGFzdCBjYXNlLCBJIGF0dGFjaGVkIGRlYnVnZ2VyIGFmdGVyIHRoZSBm
YWlsIGFuIHRyaWVkIHRvIHJlYWQgZnJvbSB0aGUNCj4gc29ja2V0IHVudGlsIHJlYWQgcmV0dXJu
ZWQgLTE6DQo+ICAgICAoZ2RiKSBwIG1hbGxvYyg3MikNCj4gICAgIChnZGIpIHAgcmVhZChzb2Nr
ZmQsJDEsNzIpDQo+ICAgICAoZ2RiKSBwcmludCBmcHJpbnRfY2FuZnJhbWVfbXR1KHN0ZG91dCwg
JDEsICJcbiIsIDQsIDcyKSBBbmQgc3VycHJpc2UNCj4gc3VycHJpc2UsIHRoZXJlIHdlcmUgbW9y
ZSBDQU4gZnJhbWVzIGluIHN0b3JlLiBSZWZlciB0byB0aGUgbG9nL3BkZi4NCg0KDQpJIHdhcyBm
aW5hbGx5IGFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSBhbmQgY2FwdHVyZSBhIGZ1bGwgU1BJ
L0NBTiBsb2cgd2hlbiBpdCBoYXBwZW5zLiBBdCB0aGlzIHBvaW50IGl0IGxvb2tzIGxpa2UgdGhl
IHRhaWwgcG9pbnRlciBvZiB0aGUgRklGTyBpbiB0aGUgTUNQMjUxOEZEIGdldHMgY29ycnVwdGVk
IGFuZCB0aGUgZHJpdmVyIGRvZXMgd2hhdCBpdCdzIHN1cHBvc2VkIHRvIGRvIGFuZCByZWFkcyBv
dXQgbG90cyBvZiBmcmFtZXMuLi4gU28geWVhaCwgSSBzZWUgYWxsIHRoZSBmcmFtZXMgYmVpbmcg
cmVhZCB2aWEgU1BJIG11bHRpcGxlIHRpbWVzIHdoaWNoIG1hdGNoZXMgd2hhdCB5b3UgZm91bmQg
d2l0aCB5b3VyIGdkYiBhcHByb2FjaC4NCkl0J3MgaW50ZXJlc3RpbmcgdG8gc2VlIHRoYXQgdGhp
cyB3YXNuJ3Qgbm90aWNlZCBiZWZvcmUgLSBJIGhhdmUgcmVwcm9kdWNlZCB0aGlzIGlzc3VlIGFs
c28gd2l0aCBjYW5nZW4gKHdoZW4gbWFudWFsbHkgY29tcGFyaW5nIFRYL1JYIGNvdW50ZXJzKQ0K
DQpJJ2xsIHRyeSB0byBmaW5kIHRoZSByb290Y2F1c2UgYW5kIHdoYXQgY2FuIGJlIGRvbmUgdG8g
bWl0aWdhdGUgdGhpcy4NCg0KQmVzdCBSZWdhcmRzLA0KVGhvbWFzDQo=
