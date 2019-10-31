Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0DEB813
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2019 20:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfJaTmB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 31 Oct 2019 15:42:01 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com ([40.107.0.96]:38286
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbfJaTmA (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 31 Oct 2019 15:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8GKXx4mtAtJSuJn5Owp1n56y5HZuGJCU2Gav5RvJV4GvBl+zXkxD/nUMDvYv4HRkkIcEiUtLwGbqoW0vxjPDFXSjjR5K+waXve45nx77ZCwAaPzx4OVjCp1lEJu5qnAIINFaA9m92hI8ll5nzlB0a5Chz1H59KvuUPXCEwQVIIRJye1knw0wszHB44j6sDUYsFIsWv5TscpZyIP3hIrTFDz9/cFlyLVZSH+qJth4W768p8t2GFPWzDrdoF48XNowgoWaP7uSFLMSFSH9ETlEyoRAfSkj1dEpX9iZV3YxnIaQQ/sQlnlYiaKUf/0iGe7Ib1SR+/YQx6cHK85OJxXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eCEtuiaIEmGxC/D8nOyDQLQ/t5aBdSnHQtlmTtdnTQ=;
 b=BsuC5nTrq9i56y0x3H4P4TjH9H3KrVb39XE8FBriI/9hIUSuHsqPtVVVvKFlPpv6m5Z5KeqSuaJGhOiohzH8t67siVxWm6ee7/IXPeXNzIxOnXs02ZELIQJTnfwIsx1SyUWA6jsqCqx2WBh1JrHIZq8oPwNpbyzQx6yf4Efz4pnA/GpjtBD5V/TTwNqmVYtsOfpRn+T24I/1XmqjfzQaSU/uuVfjcxcPpIXWmQMcTL44AP119OPaQb3AMGwD/pfe8oT5bEO4jqBgrZYgKP718+vd9bDDIoBRAeMrhL1sxmO9U+1/es0OaIjSwojcO6EAwcpyYVHBhjF1rxNE6LLIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eCEtuiaIEmGxC/D8nOyDQLQ/t5aBdSnHQtlmTtdnTQ=;
 b=JtsUszgWMiEhU57zovYqkqg9BjkDwks8XVyunLlW+MgCBsScVOn7dH6zypweztSqZtrww8e1QUMXXYbBK4VpeTqhIb1wxZDHHLCrRK0r+1OkJgcLszqeRiqTTSnTmF6K2rWWrhWQfL0LNfVyfUOWjc16VHyr0HLHMFzFmFlJAtM=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2880.eurprd07.prod.outlook.com (10.173.72.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.15; Thu, 31 Oct 2019 19:41:56 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c%9]) with mapi id 15.20.2408.016; Thu, 31 Oct 2019
 19:41:56 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     Jacob Schloss <jacob.schloss@suburbanembedded.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "daniel.santos@pobox.com" <daniel.santos@pobox.com>
Subject: Re: CAN FD support in slcan - protocol extension?
Thread-Topic: CAN FD support in slcan - protocol extension?
Thread-Index: AQHVjDNvVfk/HZhozkyg1cBuUDLVH6dtboOAgAObOICABCRdAA==
Date:   Thu, 31 Oct 2019 19:41:55 +0000
Message-ID: <3839c2b0-e6d3-98db-f774-6165f0c1cdcc@victronenergy.com>
References: <CACj_+4Y8904tbswy76Fpp6wGKZPdNpSrfDq6BvfTAGzs4zHT8w@mail.gmail.com>
 <97900bc5-48cc-b167-203d-ec7735009009@victronenergy.com>
 <CACj_+4aLfS9frR-sVkr1YcpYk+3pMZ85ALOrMWN2k=pVwJDLJw@mail.gmail.com>
In-Reply-To: <CACj_+4aLfS9frR-sVkr1YcpYk+3pMZ85ALOrMWN2k=pVwJDLJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2001:1c01:3bc5:4e00:c1b6:fbbc:1c2d:4357]
x-clientproxiedby: AM4PR0101CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::29) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf9edbe1-ccae-4320-0bb9-08d75e3a62cf
x-ms-traffictypediagnostic: VI1PR0701MB2880:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR0701MB28809EE3CB10E30D657A66C8C0630@VI1PR0701MB2880.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(136003)(346002)(39850400004)(396003)(189003)(199004)(71200400001)(6116002)(31686004)(71190400001)(81166006)(81156014)(229853002)(102836004)(386003)(6506007)(25786009)(446003)(2616005)(11346002)(186003)(46003)(966005)(8676002)(476003)(486006)(53546011)(4326008)(31696002)(305945005)(6246003)(5660300002)(7736002)(2906002)(478600001)(65956001)(65806001)(14444005)(66946007)(256004)(66556008)(14454004)(76176011)(66476007)(316002)(6486002)(6436002)(6306002)(36756003)(8936002)(99286004)(6512007)(66446008)(6916009)(64756008)(54906003)(86362001)(52116002)(58126008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2880;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6fsj+V99RTOaCMi/GVR6eLljurnJrMXpIglQyzDVGCA/v7XpGNQG8+Nrm88UOljEYrJ8cTe+x1+0wbXq4Hyf4dsevqvdAMZ2JFR5GEXBtvHjGS8AZxWj4NLEvBSSj1lx03hCXCCYNhwvzmDoMNtja+v+MfrwnT8sCcneGua6VPdKXguP1txyHE4Fl+5BmG5sTsr8nBaWIYs6KxLTlRveg62SXyoRGDzA/M2vN0zkGZIDtIUBeHkfnO+aL1NFSOZpxvmkxGFwxti1vvcJ71fuOjeaELnXDiIW56r4PEwZiY93Dt2qEkKWI3ynOIIxaTRrSTydj2ECrsRAXHe5aGEIC31AA7LA743ojqKG4g95ldhOkuFr96smpeORSovKTQlKiobhqYMboJLAY8BWICSzpIAYcEy0dA+UdDidcc7YUAawOsra9PRVA1cIOeyVq74EAfi0dv7Z/DOr178FWPZSWc3PNSStQ2DIqtgce2ZH0U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A42AB757CC692041A846EC9BC97ED96F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9edbe1-ccae-4320-0bb9-08d75e3a62cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 19:41:55.8803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLX6d3ctfGORcl9XJMiUlxzEd3mpQatkJcQQ1Oe+I1J7pda6s8QzVZQgkz+Pc+NyhNUDcfej6C/s8CUaAjILzpothkPYUabYnsK/VlYsioM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2880
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gSmFjb2IsDQoNCk9uIDEwLzI5LzE5IDU6MjYgQU0sIEphY29iIFNjaGxvc3Mgd3JvdGU6
DQo+IEhpIEplcm9lbiwNCj4NCj4+IEFyZSB5b3UgYXdhcmUgb2YgaHR0cHM6Ly9naXRodWIuY29t
L2NhbmRsZS11c2IvY2FuZGxlTGlnaHRfZnc/DQo+PiBUaGF0IHVzZXMgYSBvbmUgb24gb25lIGJp
bmFyeSB2ZXJzaW9uIG9mIHRoZSBzb2NrZXRjYW4gZHJpdmVyLg0KPj4NCj4+IFRoYXQgX21pZ2h0
XyBiZSBzdHJhaWdodGZvcndhcmQgdG8gZXh0ZW5kIHRvIEZELiBBbmQgdGhhdCByZWFsbHkNCj4+
IGlzIGEgbWlnaHQsIHNpbmNlIEkgZG9uJ3Qga25vdyBob3cgaXQgaXMgaW1wbGVtZW50ZWQsIGJ1
dCBJIHdvdWxkDQo+PiBndWVzcyBpdCBpcyBhIGZsYWcuDQo+IEkgaGF2ZSB1c2VkIGEgZGV2aWNl
IHRoYXQgdXNlZCB0aGUgY2FuZGxlTGlnaHRfZncsIGJ1dCBvdXIgYm9hcmQgaXMNCj4gbm90IGNv
bXBhdGlibGUgYW5kIHdlIGFscmVhZHkgaGF2ZSBvdXIgb3duIGltcGxlbWVudGF0aW9uIG9mIHRo
ZQ0KPiBMYXdpY2VsIHRleHQgcHJvdG9jb2wgd29ya2luZy4gSSBjb3VsZCBhZGQgc3VwcG9ydCBm
b3IgYW5vdGhlcg0KPiBwcm90b2NvbCwgaXQgbG9va3MgbGlrZSBjYW5kbGVsaWdodCBpcyBkcm9w
cGluZyBhIHN0cnVjdCBkZWZpbmVkIGhlcmUNCj4gaHR0cHM6Ly9naXRodWIuY29tL2NhbmRsZS11
c2IvY2FuZGxlTGlnaHRfZncvYmxvYi9tYXN0ZXIvaW5jbHVkZS9nc191c2IuaCwNCj4gcGFkZGVk
IG91dCB3aXRoIHplcm9zIHRvIGZpbGwgYSBtYXggc2l6ZSBVU0IgcGFja2V0LiBJIGd1ZXNzIHRo
aXMgaXMNCj4gdGhlIGNhbi91c2IvZ3NfdXNiLmMgZHJpdmVyIG9uIExpbnV4J3Mgc2lkZT8NCg0K
DQpJdCBpcyBpbmRlZWQgdGhlIGdzX3VzYiBkcml2ZXIgYW5kIHNlbmQgYSBzdHJ1Y3QgYXMgYmlu
YXJ5DQpjb21wYXRpYmxlIHdpdGggc29ja2V0Y2FuLCBpdCBpcyBub3QgcGFkZGVkIHRob3VnaC4g
SXQgYWxzbw0Kc3VwcG9ydCBzdGF0dXMgZXZlbnRzIC8gZXJyb3IgY291bnRlcnMgLyBsb29wYmFj
ayBldGMuDQoNCj4gSSB0aGluayBpdCB3b3VsZCBiZSBlYXNpZXIgKGZvciBtZSBhdCBsZWFzdCkg
dG8gZXh0ZW5kIHRoZSB0ZXh0IG1vZGUNCj4gcHJvdG9jb2wgdXNlZCBieSBuZXQvY2FuL3NsY2Fu
LmMuIEl0IHdvdWxkIGFsc28ga2VlcCBpdCBwb3NzaWJsZSB0bw0KPiB1c2UgdGhlIGRldmljZSBi
eSBoYW5kIGluIGEgcGluY2guIFNpbmNlIEknbSBoaWdoIHNwZWVkIFVTQiwgdGhlIGV4dHJhDQo+
IHByb3RvY29sIG92ZXJoZWFkIGZvciBhc2NpaSBlbmNvZGluZyBzZWVtcyBvay4NCg0KDQpVbmRl
cnN0b29kLCBJIGhhdmUgbm90aGluZyBhZ2FpbnN0IHRoYXQuIE9ubHkgd2FudGVkIHRvIG1lbnRp
b24NCnRoYXQgdGhlcmUgYXJlIG90aGVyIG9wdGlvbnMuLg0KDQo+IEhtbS4gRXh0ZW5kaW5nIGJv
dGggZ3NfdXNiLmMgYW5kIHNsY2FuLmMgZm9yIENBTiBGRCBtaWdodCBiZSB1c2VmdWwgOg0KPiAp
LiBGb3IgZ3NfaG9zdF9mcmFtZSwgSSBndWVzcyB3aGF0IGlzIG5lZWRlZCBpcyBtYWtpbmcgdGhl
IGRhdGEgZmllbGQNCj4gbG9uZ2VyIGFuZCBhZGRpbmcgY29kZSB0byBkZWNvZGUgY2FuX2RsYyBh
bmQgdXBkYXRlIGFwcHJvcHJpYXRlbHkNCj4gZXZlcnl3aGVyZT8gSSdtIG5vdCBzdXJlIGlmIHRo
ZXJlIGlzIGFueSBvdGhlciBwYWNrZXQgZnJhbWluZy9oZWFkZXINCj4gb3IgaWYgaXQgaXMgYXNz
dW1lZCB0aGF0IGEgcGFja2V0IHN0YXJ0cyBhbmQgZmluaXNoZXMgd2l0aGluIGEgVVNCDQo+IHRy
YW5zYWN0aW9uPyBBIGZ1bGwgc2l6ZSBDQU4gRkQgcGFja2V0IGRvZXNuJ3QgZml0IGluIGEgc2lu
Z2xlIFVTQiBGUw0KPiBwYWNrZXQsIHNvIHdvdWxkIG5lZWQgYSB3YXkgdG8gc3BsaXQgYWNyb3Nz
IDIgVVNCIEZTIHBhY2tldHMuIEl0IG1pZ2h0DQo+IGZvcmNlIHRoZSBwcm90b2NvbCB0byBsb29r
IGEgYml0IGRpZmZlcmVudC4NCj4NCg0KV2hhdCBjb3VsZCBwZXJoYXBzIGJlIGRvbmUsIGlzIGNv
bmNhdGVuYXRlIHRoZSBtZXNzYWdlcywNCnNpbmNlIHRoZSBzaXplIGlzIGtub3duLiBTb21lIGNh
cmUgaGFzIHRvIGJlIHRha2VuIHRob3VnaA0KaG93IHRvIGdldCBpbiAic3luYyIgYWdhaW4gcGVy
aGFwcyBhbmQgbGlrZWx5IHNvbWUNCmhhbmRzaGFraW5nIHRoYXQgYm90aCBzaWRlIHN1cHBvcnQg
dGhhdC4gSSB0aGluayB0aGUga3Zhc2VyDQpkb2VzIHNvbWV0aGluZyBzaW1pbGFyLg0KDQpJIGhh
dmVuJ3QgbG9vayBhdCB0aGF0IGluIGRldGFpbCB0aG91Z2gsIGJ1dCBpdCBtaWdodCBiZQ0KaW50
ZXJlc3RpbmcgZm9yIHRocm91Z2hwdXQgcmVhc29ucyBhcyB3ZWxsLg0KDQpXaXRoIGtpbmQgcmVn
YXJkcywNCg0KSmVyb2VuDQoNCg0K
