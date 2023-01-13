Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA596697B5
	for <lists+linux-can@lfdr.de>; Fri, 13 Jan 2023 13:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbjAMMyG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Jan 2023 07:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbjAMMxH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2023 07:53:07 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2066.outbound.protection.outlook.com [40.107.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A54C3AEA
        for <linux-can@vger.kernel.org>; Fri, 13 Jan 2023 04:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzyGLzoQCy6tFwqUDApWmyr/yyxUrO9Er9TNYQDag74VQKRwyKK3nnf2hdskeNh/hw0tJNbarKATlri2q8d/HdHX6KrHXuSjRtLRhZYlUCqDWcYV3VfEZXkv1XD3wRRwR3sUGp2QJDY1pdkkxXtVgIcnB2L1CXP7QAR7wMtHBNzh0UbIgi6xqaZ0sh4I2QunOZujnB6TaEPE+2Ryk73QW5WSfRjhMrb0OqQJ+L+pLyL4kb1S0NcTncaDlfprVyPXMtprQZPeSNlT3o09h3ZEQrXUACBlaqfO9KnljAd3M0xI0NSCgIV5CpkkOVVdBTm8mIYNgyVCo7OYU1EUd2jm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr/UFkA9lHG3cqslu9lG5CxVodbLdF9AgevZYmnnBJE=;
 b=CjfJoBnaO0hhACU/obmLtyYwS7wXf3BdWtRsa5h+UdvFw2asLRSmOYLJXSSKZ4W+I5F/0eOXCelubG/eSszMUyK2+hAQuGGuIw5PT4Ctm2+NMqtmSgieZQF9ezm9mK9L07zHLbrCd5tv0qo+Psu6IPJepH5mDjqcbQ9xebCOAsoVfymTA2A8Hf0Rbrxrz8DrftS5BvEy6ZHWFobyKvqbuHAB1azm4hbNCLurVhHGVQgWRbxHWfV7g2j4J4qGYVflmRxncQhfJQVgmMSjiwkxDv9774XCBhUp1ZdOUVmz2fSoMiKY/3TpQESuebfC/go16ie3qLhaDDu4jc6lD3a2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr/UFkA9lHG3cqslu9lG5CxVodbLdF9AgevZYmnnBJE=;
 b=ujqtcpgjBgGUZo7bkIqrJ+fVI13AI3sp2eIFp01Mu9Jmj+DOgC/W9OK5TlohdzOy1deP4pqruYSmSK4qYgmOExtxTxkb1N9GFqIkJ6kwtOxRmkhmZplk2BY2ZgQdlAmmZcOEv2eOEWKwyL3XpLmWi1W2VN21kX0GPbXdNIiQPWY=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by BE1P281MB3041.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 12:39:58 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%7]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 12:39:58 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Thomas Kopp <thomas.kopp@microchip.com>
Subject: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Topic: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Index: AQHZJgsgtPZlzMMAzkyw+q4DrZcdvq6ZzGkAgACdzgCAAd34QA==
Date:   Fri, 13 Jan 2023 12:39:58 +0000
Message-ID: <FR0P281MB1966D75DB56E45D225313B5697C29@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
 <20230112075452.4v3ba2hibxx3i5rm@pengutronix.de>
In-Reply-To: <20230112075452.4v3ba2hibxx3i5rm@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|BE1P281MB3041:EE_
x-ms-office365-filtering-correlation-id: 320e49d4-2575-4896-6cc6-08daf5634808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MDcJhIQ1nV5RFKzEYfDJ/YG3YKu1eC0DNW3Vrdi2CTXNb3M/YWeLak3DEoux+qXA843lqdYslx7inrjOQnT3rFm0gUWwPWsqgOnheB4XZtgeP3vvkpZ3im5+BFSWs/zaN08Mz9Vp1s60ynQW6mREKkQQKSalm4R/PzC8oWyTjYitV9rgmHRcl5hebNP47qvcAOmLEj5PzJPRlhhyJyj8M/Kp12W5uMLlLRzjEf0sSECxhKGwqc+ujsCxYMKv8EvUnBm3NgoC1crS9VIJkd6kzJylMhfVul2n+KthDAA67deAoz6FlRVki2ec4Du5KVi91ZeQNqyB3Y7CvyzLU6lfGWDrhlo8qP35kFnhpHjRLvsv9OZ944EPyXMt+RdA4CyjmUmAsDvHci+ZUsgRHSn7BIcL7wQINBZ6IEY5oKp7lKP33ifQaUADSp30mapOPRYJZzuLV8hM6/SLBe4ienSh8uhupfm/IcdpzyxrUmNL5pN7aUld8uO40TiDhyKdvJ2K/ktwIgtG6SwQmHb1nuW/yQxta9bmImjflgy/AsuK9qx03p6ehfDz//DRAHrVFfdhVR9pC6dEFiW8tLiaxLRaSXZgMJwNUviqNA4X8CQrjVx4ebLWgJcphgZs+n+pSx713Drn1HtUSVs5MVow1S5T2rsfA6J2dpKMOTS5KhElQT69APFkpWmsgkJW9YxwFULI+OY2JfYl5jl56aJbwUwoAfHfPWmO6mi5yyIoAsAe7rA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39840400004)(451199015)(85182001)(41300700001)(4744005)(6506007)(5660300002)(8936002)(2906002)(52536014)(83380400001)(66556008)(8676002)(4326008)(76116006)(71200400001)(33656002)(122000001)(38100700002)(85202003)(38070700005)(66476007)(66946007)(316002)(64756008)(478600001)(7696005)(110136005)(66446008)(86362001)(186003)(966005)(55016003)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Kzl1UXRVcHJmMEZmaWQwTjlOTWE5U0JoQkF6WVRGZDRQYzJFWVRqeVZ5TG5E?=
 =?utf-8?B?TVV1SDF1aDNKdEVvS0pEdk9ramlEYUk2OGpkekR1b2FIK01aOXZ4VXpkcDJ2?=
 =?utf-8?B?eGVvaW9ESzliL1BpVVhFUURVQ1pHelpSbUpSR3RDRU5yemRhM0syWkJXUTJi?=
 =?utf-8?B?SWJkNVkxTm92REpHS3FyZVVBcndWUzh2VW1laWNBSHM4U29yQmp2NnZiSHJq?=
 =?utf-8?B?WlFWRGVXM3loZWdEbVFDWXk0RXU5MUpPMzkrdGY2UjBMbTlpbzNvcXRoZWhX?=
 =?utf-8?B?ZmxHMkFWRldxK00xUU8rT0ZZRjI5d0oxUGUyc3AzOXJLcVBSQ0tIblI1Tnc3?=
 =?utf-8?B?VHBsZnd4dWRHSGZyanZ0K3JHRFAzd2orQUQrRkh3ZmZPdjFYbXNVVGxFOWxS?=
 =?utf-8?B?SmFVdmNFSXhpMkF6bEJJNExIajBTbmhUb0lGR1N2WXJ0alRnL290Y3ZxZCtz?=
 =?utf-8?B?RmdnSTZybE5manpmYUVidy93YlZIWFRtZk1tb3pZcW5GQTB2ZHNpT0UzYzJX?=
 =?utf-8?B?QlZLZmIwdUZzVEhSNElub0FiQXFtTER1c0ROQ3g3bk5Tc2dqOFZmN2FHODdh?=
 =?utf-8?B?VkNXUEE0UHA2ZWNPUDA1SE9MLzBZWXNEZG44MGtBSzdzTS9OSFdUeHVqZUNw?=
 =?utf-8?B?SVJQM21ENmtYRkVpejVpcXRLbFN2YmhKbkhCK0VwL0lSVEx3R0hzTE56OG1X?=
 =?utf-8?B?OUtXbXl3V21aeWVKdFNMcGppWU1UMkxxOThCYWJYSmtuSkRrNU1sRmNBMjNz?=
 =?utf-8?B?RFlha1g4bzZmaStjL200eG5Ham9DUXU4dW4zdGRjSE9YcHJGWWhyeDgyZkJO?=
 =?utf-8?B?TGlseEJQaWNRbVFLZ2U4WXlVK3RLVTFFUmVqLzg5NUpldGxFN1JPclFPWGZu?=
 =?utf-8?B?ZklIVzlrYzJ3bHZtN1BlZ2k4UWloRlFKMzFwYUdiMjYwV1N5b1QvYWVRbHY5?=
 =?utf-8?B?YlNOc0tjWElBd1ozT0dZeXZ0TmYrME1pNGc1Vk9HcTk4M1hKRmNaRll6eHRH?=
 =?utf-8?B?S1B1TVBYTTZZN21LTVQ1YU96a0s1RFFwaGxTOGRmQ1V2NThTMnFRT0hOYjhL?=
 =?utf-8?B?dkF3U2ZZdG0xZ2RCOEFxanVseDU2d0VUcjFuZG9aL05XazNueWZTQkUzWVBj?=
 =?utf-8?B?VGtCWDNLQnc4cWRzMDdBZFhXaXJzekRVK0JvbHRJNlhDZnFaTHVpbDZuWk5l?=
 =?utf-8?B?VkFvaVZ3Ni83WEtiOU95WDhFUE9sK3ZneTVhaDJZU09SbXRjK2VGNkhqN3hI?=
 =?utf-8?B?NVN5b2hONUlXdFlJZUZYQTRhZmZSTmd2VUdDWHJHTXc0ajEzcm5pK0w4MzVy?=
 =?utf-8?B?Nk9NWnN5VEpjR2JkWEVnWXRaWkxWZXByak9UMHhsSC9JcHczMzFURVo1NnI0?=
 =?utf-8?B?anNBanJXL25tZjlGaExuejVHLzd2eHVPRit3REEzUEtGbUJxbmhvSHU0MUph?=
 =?utf-8?B?dExiSnhjZzYxdUpiaUEvTWVaYUJQS3JoSTRDd2tqOTZ4UUYwS3NhYVQ3d3dy?=
 =?utf-8?B?OS9DWDN6YVB5Zk9aNGEyaUo0V3BJaTU1aC9rNnhVT2gyTVdDUjY0ZElObFd0?=
 =?utf-8?B?bUtEdXdCTkgwZVB4dlV0VGkvMktxVitMc3pBSVIwMjVJYjkybkJPZ1pzZk1l?=
 =?utf-8?B?LzBPY09RM1BXVXRtTGJxRUpob2s0V3pTL3JGaEtkeC85L0VQNUxJL2YxbDQ5?=
 =?utf-8?B?b0ppc3Y0Tm4xNFlCU3lCY2RjUGE0TXNBR2YrdThMWTJ4WGZ4MktQcXQ0Zzg5?=
 =?utf-8?B?Nnk5VXcwNEVXbDFIWVRmazBPbFJhTWJiK1lOSXQ4TkZZMEMyUTJTbFJGdlRP?=
 =?utf-8?B?M1l1eWtrVy8wdnBJc2U0UXZQMGNkK3BYSW15bG9qQ0pNY0hEZW1HWGozMitv?=
 =?utf-8?B?bTJFOUpDUXVXRlNOQjVnajBmeGUrYW5BR0ozTzdETVNBYmNOcjQrelBiQzV0?=
 =?utf-8?B?L044NjBoZ3dvaUI2bUh5N1ROZ0lUZ3lWa2p1RzhkekZ5MVp3UkNvdUhHKzJ0?=
 =?utf-8?B?cGp0QkFVTXBjSWNoMzVDMlF5RjZqYXMxbVhmZjlDZmpicEpwYXJtQllMdDRk?=
 =?utf-8?B?RHVmVWZWTnNiRDRhZGs5K3J5aFJpMnlxeTdRVW9udUpnejFLMkhqOFA0L3Mx?=
 =?utf-8?B?WnIzd1RZRi9SMjN2MDJxckZBK0pjdWE0V0djWW4yVU5yVS9pSW1yd3orT0py?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 320e49d4-2575-4896-6cc6-08daf5634808
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 12:39:58.5269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIirfQPjahnQrJhtPsDWml8L7RELiqKDeQR8hMR2IeQ/O0iVaPNyr/LLjHJXE1Sq4R7IeQ5GNTJiGEuzIBFE06Atn2vRea8Xv1mBZPgW2zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3041
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBJbiBteSBvdmVyIG5pZ2h0IHRlc3QgdGhlIHdvcmthcm91bmQgdHJpZ2dlcmVkIDMxIHRpbWVz
LiBUaGUgdGVzdCBoYXMgZm91bmQgbm8gcHJvYmxlbXMuDQoNClRoaXMgaXMgZnJ1c3RyYXRpbmc6
IGhvdyBkaWQgeW91IG1hbmFnZSB0byBnZXQgdGhhdCBtdWNoIHRyaWdnZXJzIDstKSAgSSByYW4g
NCB0YXJnZXRzIGluIHBhcmFsbGVsIGFuZCBnb3QgMyBmaWZvIGVycm9ycyBpbg0KdG90YWwgYWZ0
ZXIgMjAgaCBhbmQgbm8gdGVzdCBmYWlsdXJlcy4gSSB3aWxsIG5vdyBzd2l0Y2ggbXkgc2V0dXAg
ZnJvbSBkb2luZyB0aGUgc2VsZnQtcmVjZWlwdGlvbiB0ZXN0IHRvIGEgdHdvLW5vZGUtc2FtZS1o
b3N0IHRyYW5zbWlzc2lvbiB0ZXN0DQp3aGljaCBpcyB3aGVyZSBJIGZpcnN0IGRldGVjdGVkIHRo
ZSBlcnJvci4NCg0KQlRXOiAiLi4uIChhcHBsaWVzKSBhZ2FpbnN0IGN1cnJlbnQgbmV0L21haW4i
IC0gaXMgdGhpcyBraC1saW5nbyBmb3IgdXNpbmcgdGhpczogZ2l0IGNsb25lIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQuZ2l0LyA/DQoN
Ck9oIGFuZCBJICJiYWNrcG9ydGVkIiB0aGUgcGF0Y2hlZCBkcml2ZXIgc291cmNlIGludG8gbXkg
Ni4wLjEyIHJhc3BiaWFuIGtlcm5lbC4NCg0KbWZnDQpTdGVmYW4NCg==
