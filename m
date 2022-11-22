Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D0634166
	for <lists+linux-can@lfdr.de>; Tue, 22 Nov 2022 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiKVQYv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Nov 2022 11:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiKVQYt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Nov 2022 11:24:49 -0500
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2100.outbound.protection.outlook.com [40.107.127.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CA31AF3F
        for <linux-can@vger.kernel.org>; Tue, 22 Nov 2022 08:24:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1LZECmKJLEQhJjd+6tOkvQmFu1/7R4ta1btoYrJ6InLCp7nRRysiSfPozyEqttR+8Jma2vgL4LIH+PeGbn64MXG07xyHIcrqYrcvfYWYlL19SWat8rIOTrJhemfiAsId1NB+PcWPigTcnIrNWv1vOissuyXArW94M8j4PYtUGuLS9j1DQNN7qEEn7L7ecB3f28wARfpIqvWLi2qJo1lIpP1XCFwh4sBIgb5CGQd3CQmh9a0OEdmnu2ogpCXYwJPWEO8V/+9F3pefKv8r4qWjNIqNeksZyevHqyBkCMdRh5DsdyQ8+vkqbDf2oKt2KTUtmGLR1+NbxsK95QeCQwKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cWuBNDUXfCaSjcvbillp9OCJl0cCfNslgawJlc/hvY=;
 b=oJxOkbpgHkrB2FfllgLxfyQuoxK3v7zb6bNEmvsymMPHojG5PkcAOgHPeBvSC4gvf6QLyGaLt0tBtwbSx+nn2xpRzYIee7M+x5+r5OCk4WIO89WmlDDQLhOVp3aOLsTJgr6Sp5Hyvrxr0iDskA+b9lnHdLeAM8VD+i+3Gz4bSywfitOCvGszAq9hvMdTkGBL2JyT3iV3B9FN2BEv+ehzucdhk5FjeguWkCGoafQtp79yK2DAlpCe3nk1j5v7BR2fTWZGdM6JFT7PPnZHqH14zlNfMuuIcEjJPEZK70Wd0L8Qnp+zFw3aahf5Rsw3A1jnyKsMQV9EEA8bSO38EiGorQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dintec.solutions; dmarc=pass action=none
 header.from=dintec.solutions; dkim=pass header.d=dintec.solutions; arc=none
Received: from FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8e::7) by
 FR3P281MB1790.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 16:24:45 +0000
Received: from FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM
 ([fe80::18e:f41d:d97c:6f43]) by FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM
 ([fe80::18e:f41d:d97c:6f43%4]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 16:24:45 +0000
From:   Marvin Ludersdorfer <marvin.ludersdorfer@dintec.solutions>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
CC:     Patrick Menschel <menschel.p@posteo.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Andre Naujoks <nautsch2@gmail.com>
Subject: Re: Problem receiving > 8 byte UDS response when using istpsend
Thread-Topic: Problem receiving > 8 byte UDS response when using istpsend
Thread-Index: Adj9oXS9XKrdsZ8wSP6hlXFXAyCoOgAADfAwAAiQN4AAAS+vgAAqKCsAAAdofNI=
Date:   Tue, 22 Nov 2022 16:24:45 +0000
Message-ID: <23FE2E04-B85D-42E0-8DF0-102C54EA5172@dintec.solutions>
References: <FR2P281MB165556E4F729AC3CDB50F6F69F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <FR2P281MB165503FACCD9894C353ED4CE9F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <49ce15b4-feaf-a519-9172-d0f59a9285ed@gmail.com>
 <40200c08-552e-e6b3-c5c7-f5ee8a4b839c@posteo.de>
 <96a4de81-882b-cd88-ae7a-ca3b7c3b432f@hartkopp.net>
In-Reply-To: <96a4de81-882b-cd88-ae7a-ca3b7c3b432f@hartkopp.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dintec.solutions;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB1655:EE_|FR3P281MB1790:EE_
x-ms-office365-filtering-correlation-id: ce83148c-9c34-487b-6317-08dacca6114c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NssMmEPODd3BqQMzllqgzBpsKOEFhNjjCwYIhqRVetdOYW2Qi4Ws0HcLBRAA6dbEOvpghrBmxlQg0U2jmGKtnVGkfdimxdsnl++Fqo3twxokf2fA9GJwCJ7ObFY3gIf/g8ljql69JYUyP9KRG/V6avJyNVZp/Mk0bkh1GPN7nD2QWOnZJ9+K6hvs+YHBBJGQgxJ4457iyRYrvAnUeuyZ3g2SiABwuosP3LQdNiw0iMmjJBY5LDuCL9LuqpIEsuU295GcwTO0vMyW2yiq/uPFUft8fHr1oA3DjJR2YhJipSfBGMCGX/unIzDpv4mUDdtAqdcXEZ7BsPEtsZd8MhiYSuTHJIwEy9B4552fY+oEEFg0dfLeaxaAx8kFjG3p8zLkvsfxh1j+EaPw46Pm+ql0YM1YX5hWwoskxoLXe/hnO1jcYIlB3iu5k3FA8EqdtX7JZdxvIw6ja27I63ZxyHXlnpeiVRGe5bq0Q1Yj7/V2cgTjcmsnqMddiS3aNjaetc7CPboqq4UNaeItxUG648GCOLcEYM34ccUdS9TKN48vdFXhrUlEyaM6Np4jiuqmlKazIo6QAg3ookHJfROQ0GiO/8xQLLMxwn5b+rmAs3iWnJyr5qFLBnfMflWSHUZxafDyUecmLp3EGqP8/JicaO85G+sU0lyfl0JQFfGLMpENLUAZSimR/+gdHFWGsch4TvnGRIK1fPi8XDyjoPO+q1AIPTBh0lzVv7MVlSyLyHMddp/7MHeAINVNXAZOyPXls8/m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39830400003)(396003)(376002)(451199015)(33656002)(86362001)(38070700005)(64756008)(76116006)(44832011)(5660300002)(2906002)(38100700002)(26005)(186003)(2616005)(6512007)(122000001)(83380400001)(53546011)(54906003)(6486002)(66556008)(6916009)(71200400001)(6506007)(41300700001)(4326008)(66476007)(66446008)(8936002)(478600001)(8676002)(66946007)(316002)(46492015)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHdTRzhLbnlDTXUxUHp3VDBwalFLdklxWlV2eEtxc0tZTEVwcU9TbzdjaXFp?=
 =?utf-8?B?OVFSWHJzMUdOaHRBMlMyMm1lMVVCQnVpSnJOdjFJazhEUTBadDZaaGxBVUN0?=
 =?utf-8?B?cDJZQUc1WHhJV05ndXNURFRNYkxuek85VjlJNC91TEkwSzcxbXA1SHRQZ0pF?=
 =?utf-8?B?YXdlZVVDVEwvcU9yYkRpcDVzZzJBQVlXYkkyeVBucHFYOE1uaGl2cWs4K3Ir?=
 =?utf-8?B?WFcvaXVnMDhLYzdIMWd0bSs2MUhzcnJXOHVKeHlJbnE5elNNVFZIQkg2SHZ3?=
 =?utf-8?B?ZTRvYUpjN1F0OUNCQ0JCV1VWYWpPeDFwUkc3OUhUNGlVSEFTWC9FVC96VUd5?=
 =?utf-8?B?SW4vbTU4d1N1VDZ4OFhuMlRYNmtnaTZ6NGZGVEV4VDNqOC9FRVpIUVJlYytl?=
 =?utf-8?B?dVVGNDFOSXlZRENkbitpWTEzUU8reUxoWjlxRjc2a0RhdEh4cHNOVWN0MW9Y?=
 =?utf-8?B?TU1vNk5jZUdoNlRtMTVuLzdGZkV0d1lXb0l0bm5aQ29UOFFHR0RKTm5rOURF?=
 =?utf-8?B?cGtvdUMyMStrMXY4dlZtckRVZ0VSbENNN3NoTlZRZTZobTRCZUFnQmVSbmxv?=
 =?utf-8?B?L0lGdkhnVnZXSjllbHBEN3R0ZkVxTXZvSlNkYklCWHArbm8vZUtWY1VZZ2h2?=
 =?utf-8?B?TTMzMDhDdmJ6TlhGYlplUVdMcE9XOFhTUndIanlQcjJKL0RPcGJXUmpkMm5w?=
 =?utf-8?B?WUFidmhEVnoxWko4Q1oyZW03aVBmT1plTVgwMDlYbXFwNHVxUGV6bzlhUDZ6?=
 =?utf-8?B?NjB3dWRGSnR5Ny9VNUQvS1pZbjYvckhYTlRodStPUDdSQ1pjUHZhNzUwZ21w?=
 =?utf-8?B?aW92RnRCdTFJV0taNFRYSWI4OTVIa1pwZEF5V1JNakF4VjJkK0R1ZGZ3Smtl?=
 =?utf-8?B?Z045T0tXdFFJeVlqWU5Bckl0YUtpOHVsd3ZFVFVJWnZQSkpndlJhTDdpSGRr?=
 =?utf-8?B?eTdQeU5qcHhTRktCYTF2RmJRcTM4TUE3RDRhdTJPL2NIRW1RKzZBU094bzFS?=
 =?utf-8?B?akl2T0lwOFo3T205YnZWQlRnUHhZNWNtYjNQVnpqMW9JbjFJdFdDYXh6bWdX?=
 =?utf-8?B?K0VZVHd4ZG9HcjFQSEx2QTNHb2xQMzlaYXgrOWJyOTBQT1NCdVJyQ3hrNENP?=
 =?utf-8?B?OFFBTXBwdEtlMGMvNnNqaHh0Wk41TWZaenIvM3dUb3JIT2VRbzUxUGNJdXQ5?=
 =?utf-8?B?SE5CWmpNUlVrN0lCcENvVmY4eUx2L0NHRk1ZZi9jakM2VVNEQnI4OGRoSVpV?=
 =?utf-8?B?dlB5Q2RKUFBhUWsrNTRoNEl3Qmc4cGU0S25TelNidituWFFiM2VPeXEyZHB0?=
 =?utf-8?B?K2pldGFBY0FRcWx0cmIwQ1pPZG8rcXRBSmIyM3ZuOER5M0kyOEdQb1RJNTB1?=
 =?utf-8?B?aW90VlA0SFhLWGd4bE5zZWcyZzRDY3EyelBYVDI0cGQ0VDhHaForck1pcCsz?=
 =?utf-8?B?MEdEdXBzUTBycU9nVDF5VG5BOVc0eWRGdFU4MTRCdFduTHJsM01vUFFzS0Fm?=
 =?utf-8?B?b21XdDQ5OXZqb1AwRTdTcUhJRkZreXNLOHZja0RrdlY4b0dZT29VcVorY0h0?=
 =?utf-8?B?NGgyZm5maTBWVVNsVnFLRXdLVytibVZqa0V2TGVJSzllZlhZZXkvZE9ha0ht?=
 =?utf-8?B?QUMxR3JydTU5T1BJbDltZ0sxSW8waE4rZ25YNWZmekNMS1VJalZLTHBscHZT?=
 =?utf-8?B?YzQyaElETzVOMDV5aWNaUEJRMzcxRGUwVEE3dmhpYTFJbFJiTTI3MHFkeDdS?=
 =?utf-8?B?M1NzbTdWbWVvNEpFTmxybWptUzkweVUvOHA3Nml3SmZ4a09yTUhnaHFCeURh?=
 =?utf-8?B?dEZJV1MrVVZxSjhYbDdFSGdUVlRLbkRFTDRVVEJnZVJ0K2NNcDVNM0tPWVRN?=
 =?utf-8?B?c2FHaVVvbmlIdkFTeGZyOHJlaTRJaERHczBXbnpjMk50R0ZzYmZ4akZvRmw5?=
 =?utf-8?B?UncvamJPSlZNSHpYZjIyUFpBQkRNSzEycXJmTlBhY2xTdDRoM2hVNDFXbWtO?=
 =?utf-8?B?Vyt5TTBtUnRsTXNNY292bmNQZ3RQcmU1eC9TNFNibm5TeHdBa3luWWhpb0ZQ?=
 =?utf-8?B?SEM1Vk1VR05VRGd3K1JITktiUmkyWWxnZHdJTTRNbklQcDd6RjJtZG9LeDd2?=
 =?utf-8?B?RG9KSURwOUJYMFpkY3piNXJXb21UbWJkemI3OENOblQ0T0Z4UnlxV25TeG5W?=
 =?utf-8?Q?pbDyq++E+aowuHRDoYPigic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dintec.solutions
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ce83148c-9c34-487b-6317-08dacca6114c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 16:24:45.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aced8699-8899-4f52-b3b1-e68bc99e845d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIrxluVB+cl8sGidm81GzDxI+y4qAw2I6z+3gO15fn7hBHm9CDTBbWyCw6h/6CMtj4D1SpOnWmUzE4MuPbnM+ukQX3mdnloBL2SLEN6L9yEOwbmRRn/vUwqSi4SuMUar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1790
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

VGhhbmtzIHRvIGFsbCB0aHJlZSBvZiB5b3UgZm9yIHRoZSBxdWljayByZXBseSEgSSB0aGluayBJ
IHVuZGVyc3RhbmQgdGhlIHByb2JsZW0gIG5vdyDigKYgd2lsbCB0ZXN0IGl0IG9uY2UgSeKAmG0g
YmFjayBpbiB0aGUgbGFiLg0KDQpAT2xpdmVyOiB5ZXMsIHVzZSBvZiAyOSBiaXQgQ0FOIElEcyBp
cyBpbnRlbnRpb25hbC4NCg0KUmVnYXJkcywNCk1hcnZpbg0KDQpWb24gbWVpbmVtIGlQaG9uZSBn
ZXNlbmRldA0KDQo+IEFtIDIyLjExLjIwMjIgdW0gMTM6NTggc2NocmllYiBPbGl2ZXIgSGFydGtv
cHAgPHNvY2tldGNhbkBoYXJ0a29wcC5uZXQ+Og0KPiANCj4g77u/DQo+IA0KPj4gT24gMjEuMTEu
MjIgMTc6NDUsIFBhdHJpY2sgTWVuc2NoZWwgd3JvdGU6DQo+Pj4gQW0gMjEuMTEuMjIgdW0gMTc6
MTEgc2NocmllYiBBbmRyZSBOYXVqb2tzOg0KPj4+IEFtIDIxLjExLjIyIHVtIDEzOjA4IHNjaHJp
ZWIgTWFydmluIEx1ZGVyc2RvcmZlcjoNCj4+Pj4gDQo+Pj4+IEluIGFub3RoZXIgdGVybWluYWws
IEkgcnVuIGVjaG8gMjIgRjEgOTUgfCBpc290cHNlbmQgLXMgMDAwMDA2ODAgLWQgMDAwMDA3ODAg
Y2FuMCAtcCAweDAwDQo+PiBUeXBpY2FsIGVycm9yLA0KPj4gZXhjaGFuZ2UgLXMgYW5kIC1kDQo+
PiBpc290cHJlY3Ygd29ya3MgdGhlIG90aGVyIHdheSBhcm91bmQuDQo+IA0KPiA6LUQgWWVzLiBU
cmFwcGVkIGludG8gdGhpcyBteXNlbGYgc29tZSB0aW1lcy4NCj4gDQo+IEJ0dy4gQE1hcnZpbiBh
cmUgeW91IHJlYWxseSBzdXJlIHdpdGggdGhlIGdpdmVuIHZhbHVlcyBmb3IgdGhlIENBTiBJRHM/
DQo+IA0KPiBUaGUgaGVscCB0ZXh0IHNheXM6DQo+IA0KPiBVc2FnZTogaXNvdHBzZW5kIFtvcHRp
b25zXSA8Q0FOIGludGVyZmFjZT4NCj4gT3B0aW9uczoNCj4gICAgICAgICAtcyA8Y2FuX2lkPiAg
KHNvdXJjZSBjYW5faWQuIFVzZSA4IGRpZ2l0cyBmb3IgZXh0ZW5kZWQgSURzKQ0KPiAgICAgICAg
IC1kIDxjYW5faWQ+ICAoZGVzdGluYXRpb24gY2FuX2lkLiBVc2UgOCBkaWdpdHMgZm9yIGV4dGVu
ZGVkIElEcykNCj4gDQo+IFNvIHlvdXIgSURzIDAwMDAwNjgwIGFuZCAwMDAwMDc4MCBhcmUgMjkg
Yml0IENBTiBpZGVudGlmaWVycyENCj4gDQo+IElzIHRoaXMgaW50ZW50aW9uYWxseT8NCj4gDQo+
IFNvbWUgcGVvcGxlIG1peCB1cCB0aGUgbm9taW5hbCB2YWx1ZXMgd2l0aCB0aGUgMTEvMjktYml0
IElEcyBhbmQgdGhpbmsgZXZlcnkgQ0FOIElEIGJlbG93IDB4ODAwIGlzIGEgMTEgYml0IENBTiBJ
RC4NCj4gDQo+IFJlZ2FyZHMsDQo+IE9saXZlcg0K
