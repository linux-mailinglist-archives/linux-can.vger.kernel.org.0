Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56938671CE5
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 14:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjARNFD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 08:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjARNEf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 08:04:35 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2075.outbound.protection.outlook.com [40.107.135.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4638565F2A
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 04:25:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8iYqduaJGgVWnmP0qRurLlzRIK4FZoFUlgEctt803MNpRnL4G5vP9mnLU+SWs84XW4fwszrO0AoN4qu7/nCbc1Ijp69exM1zaPXIi6/ViEPmNNXVTTf6WtGWBUmXbSd1R7T+ynHzq+LJ27qOaIxOiC2z2tc+udK/lgSNBpRqmPDXpWIE2nI+Er9Qhn1Ns0+4KLpM6K3ndCmWpQHfMSCktPDhBEopzQSs36jfri87IvZbqpVm666SH8J/88n6f3k3FuH94KhlDwpd/T1P3GkOK7WE9/Mvdq5stQC7eCzX/7X00cjPv1lWqWlNvr8goBsvLmwCQbKW4kyU52Oq/TKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QPPSpHZ2H+onDDFeFEQGPlyj+0wLhTwWx9XY51TvUE=;
 b=J8mwqCbQ2EnxzOkI8XXwnZS3yGtif6wexIqCka17vKfPCWD8/KBHbeJoft1s0UFSONGCTuWrjVM6QR0uqLBoCBZvcaS+sApAtwBSXhsMU+xEOuYgEPsuoqr+FY6B5HaKT2o3Ya6cAnuoMMwmz6aZqP1DH1Z1aEmAD+FOfdn7NsXjbg8y5EMSE14Gc9A6CMMRgbHUIq16lPkKCUUUmQ2fSQ36gjWQx+kFbrdUN8a00Ps0hsC2UgMe4ZrxI2PgNBmksnxX3YyAYNO4lHf4/yxCjLeFIUWwrJ6W5BaOyRF4ot+e7bl7Y1scXGieoERoK9a8IReUtf1VjuOs9WlPsxWFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QPPSpHZ2H+onDDFeFEQGPlyj+0wLhTwWx9XY51TvUE=;
 b=HbJlw4C90UpuPYJr2Sc0zvGl/hIs4wJCckBc2LQMHHcPKsCqBGDBNnHMge/36yHk7n/JQYTJ4H9PUnBXd1qWRuVrA+ld2EXQJnMR792lE0vIreSB5oZ60A/CJZmz67AMQVO4qmf5yIE+iTvY0aWyipNEc4r86tM+8REdyHx9p+s=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by BE1P281MB2547.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 12:25:21 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%7]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 12:25:21 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>
Subject: AW: mcp251xfd: rx frame truncation
Thread-Topic: mcp251xfd: rx frame truncation
Thread-Index: AdkrKgKGt7aB0DDaRvyWRC6jkqk6sQACGbQAAACkqEA=
Date:   Wed, 18 Jan 2023 12:25:21 +0000
Message-ID: <FR0P281MB19661D8535674EB92D142EBE97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230118114550.clfspoo5ziax2gtz@pengutronix.de>
In-Reply-To: <20230118114550.clfspoo5ziax2gtz@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|BE1P281MB2547:EE_
x-ms-office365-filtering-correlation-id: 3a0bbb9a-33b7-4998-2af8-08daf94f1145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9inzuiCYd1CI/z0HLq3ifmWQE72o/tURahXTw7b+qWEusiuwa4Uvef4hgabH7eaMNx1QAQgrQAInp8RYy6GVgDiREqdCZTyXQPS48Nz3uAIH/DpXlbtRrbB0vYp75ddpwelFYcJz+oA/3nKc+w+cbYtpGEYIlRELbIwNlSxa/It4EMXwDc7imS/6rNoQC6cndK/tF8ou46Z8KmmfMHt4yd/nVWyTSGox0TNoJWia6tmexB0i9UU/idka6+YV2UwVTdJrE5WoefpwU06wbJTtjAoyjh7a4oDi/FXgPzpu084EIIQZPwgIUE358dP3VbsN1DF79J+fpZzLwdIABriNkoBga9WYsJPz8VHtIX6QKo5CCJDk5KtfDUNint4QfHAln+L9JHeDmAWn/O3g4rlZWY87PXKS9RS2Le2PJ1NIU6ABnKcJKR2wvmhyh74cjyTgEcxPiVwY7NWKIHwo4tDPBDXo0RiB08VF//2tuK0cgdfLF9gymK44Pea4mqsPjjMAdi78/tZQWLxnqBCTlWPLQVWK0pCZigF45UETbNMgFrytad4owe9OURs4nTKlxznLtJ7vOI5GtbvWXnyOSZWU6zEWxUTdV7JzexuF80zuRbYBUZVi6diPem3hqDdZ0Jw9IVmPtQsL4qw5ryzNL0Cl1l53QYqzSoNo2LcxEc6/YdVdWUAZFYzhLoxsddnGBX5ysjE7E1cwohuoyQ8LchBePg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39840400004)(376002)(366004)(451199015)(6506007)(2906002)(76116006)(5660300002)(8676002)(52536014)(8936002)(122000001)(64756008)(6916009)(4326008)(9686003)(38100700002)(66446008)(33656002)(26005)(558084003)(41300700001)(38070700005)(478600001)(85202003)(85182001)(55016003)(66476007)(7696005)(66946007)(66556008)(86362001)(71200400001)(186003)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVY5WnhQYXJEOXdqS0p0bEl2NTVBdDJYc3J6N004djBiaXJxS0duMUpWMVQw?=
 =?utf-8?B?RnVZMHZQZEozQXpEbjAvb3U0ODh3ZThaSGc5RG1kYUExSnZBVDFwc3kyWW1h?=
 =?utf-8?B?T2QxSVBEREExaXJ0RTFuR29mNk56ZlpMOFF2S1VpUDhMWDE1b3M4SkwwbHlP?=
 =?utf-8?B?UlJRLzZMTHZUSm5qay9KQ2V1MWRGa3oyTDJWZ1VzVDNHY3JYME1hdnNIQzYv?=
 =?utf-8?B?WjZhY0tHQkJLR1RZYm9JT214U2xQV2Z2TzgreXk1UWxjTS9rVmxZOThlYWZJ?=
 =?utf-8?B?amtjeTlGczdDVk0zYkRhS1dyZFZ6T0N2WVQyUEo3NlhpNHo3UDVPQnRDVDlx?=
 =?utf-8?B?S0YzSW5OMWc3VStGQ2RtVWwyQ21pTkRzMk1QOEZ2SUhsTGFnRTN0dHJlK1Vq?=
 =?utf-8?B?UWt1WVB2MjdxNGpnc0NZWnRyMjFqL0NpR1NwSHFsNm42Umc5ZHNROFVPMUVP?=
 =?utf-8?B?S0ZQa0l5N0hHbnNHWk4zTVl6Z2FPWUtDTHAxU0pBRUIrRUNDNW5JckprVjQ4?=
 =?utf-8?B?dG1uMml1RnU2MkRNbmM0STE5K1pEa1lUYll3c0txanFnT0NrVkxIdHFYenFV?=
 =?utf-8?B?RGlNM0N2NmEzWWZFdi9ZaFl6S2MzK1JsZmI1RldVOHFYZ3VTRDF6OW5MdTBa?=
 =?utf-8?B?MDhwVlgwUHhFblRhZlBZL2JuYzNKOE9IUlVBSUl3Si9Gck0yazYrSExKYkc4?=
 =?utf-8?B?VkV5ZmdzY3BmaDlRcXNJdlpNSytFanptNW5lWGliUUZuSEQwRmF6MXptSWZC?=
 =?utf-8?B?TllWYmdRYmREQnZXN2RSdmhTMnRKSzYzVTczTDRtMWdjY3EwMStZRDNVam0w?=
 =?utf-8?B?L29mZVRhTDMxYWNKM2pqWVFzYWpRalpFVkoxNU90OGNSUmRJb1R2SlJ1anZG?=
 =?utf-8?B?Q2JkalFkWWs0bFd6K0pPK1o4VitHWG1OZXVqR2REd01DUnZlWUhvR3VLUWs4?=
 =?utf-8?B?ZWVBZjdCWCt4T3V1c2sxM2hxSEdVeCtaTUFiTEROK0I0WHZoaUZyeFN2VHE3?=
 =?utf-8?B?eFFyNTZ2djRZRU41TmFtL0xFSGh5cVR4ZzA1dXVLeFQvOUx5V0o0czV2ZGw3?=
 =?utf-8?B?VU00Tk15NHRVZW90RFBjaGc1U05nQzRmS0EvVGJPcDVhTTc1ODI1MEVjRFFj?=
 =?utf-8?B?dXUrSHJ5U0RoYm5KcDB0Y1Z0M1JmU2gwQXZ6U3JxZTR5Y3F0NmlSMktWeUJ4?=
 =?utf-8?B?K09zbEt1Um9MNXBQRDhlcjJ3MkM3bjVvb0N0TXFOYVJpNFRVVkdmOXNFS2Jp?=
 =?utf-8?B?V3hqTUt2UlF4TVJ5NmhCWGhVQUU4WGFlVm1MdnlHSlRwSG9NczVEQWY4SjZo?=
 =?utf-8?B?TU9LZTd5LzBzVzU5eTVnV3hHdjBZVGxYVU8ycnc2ZFozdUFES1QzblFkejM1?=
 =?utf-8?B?SGQ5ZlVIaVR6YzMyUDBiby9VdHNHNmpmUUN2djRhK3dYRVo1S1BxSDZEVXN1?=
 =?utf-8?B?VWc1dGtHMDBOWjNmSVAzZS8xNnJHeVJDcXZmdmIzT0FvQ1ZPNjl0TEllM2VD?=
 =?utf-8?B?UkZlUFNwMDZ3SlAvYndaVWplVkZrSkdpRWJrTFVONjl1akFhMHVPRWM3TDNr?=
 =?utf-8?B?cmhrdnlOWnU0VmtQUEs5VG52aUpNTllaSFJ2NmhiWGRrbkVtcERpMFl1bWFq?=
 =?utf-8?B?amQyemF3c2czSjAwU1pmd1Z4Y0JmSU5oWnhRaVh5eGE2MWNqcmFIdW9KTUNZ?=
 =?utf-8?B?RlFqWUhuMHllNnBZa1pXN1NyajA0Q2xMc3B6SGRONCt6L2xWN0ltOHNLeGpB?=
 =?utf-8?B?S205TFpjZE91cmcvcUYzWDZXU3JsaXNTL3RUTmpXSytod2gzVjhuODAxTG9x?=
 =?utf-8?B?aXBJWWRYZzlua1d1dENFb2c5Yi9FeGwyZ3NORzRCazk5Y09ocnZneG5LdElo?=
 =?utf-8?B?b1E0ZmVwWlNEdVNPZlBrT3A2aVBlTDlIa0FIT28xa3FoZ2xsTDhteEd2Rno5?=
 =?utf-8?B?WWROcXM0UEYzSUJoOGdxenQ5dTlkVnNNUU83SC9uWnlNUWxYVHdlS0owTjNv?=
 =?utf-8?B?S0g4TjdaM01KTWlaL3ducHJjcVJpdmJOTEUrbHpEaGRiYTBQMTVLTFRTMEtp?=
 =?utf-8?B?QVJmT3V4ZHBhQytXRlcrN3dta0lUNjA1Nk1rSTVXT3ZtMHFqaHFCVUwzZDk0?=
 =?utf-8?B?YmFzRmNuYmQyKzVMRUdDUUFuV0Y1WEpEeTl6VzU5VjNyd1VKL24xQU9LNURs?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0bbb9a-33b7-4998-2af8-08daf94f1145
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 12:25:21.3668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J95hURbT1MIcdx0rj9YNX4LKIMPPeMAoy+amMKbnFm1AXL+S5l4HJLW2rAjQKGoO2QnwsTCrX8DIM03XeY+EYWNBDD4WdDi26adNJWtNPoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2547
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBTdGVmYW4sIGNhbiB5b3UgY2FwdHVyZSB0aGUgU1BJIHRyYWZmaWMgd2l0aCBhIGxvZ2ljIGFu
YWx5emVyLCB0b28/DQoNClNob3VsZCBiZSBwb3NzaWJsZSwgYnV0IEkgbmVlZCB0byBjaGFuZ2Ug
bXkgaGFyZHdhcmUgc2V0dXAgdG8gaGF2ZSBib3RoIG9mIG15IGNsaWNrIGJvYXJkIG9uDQp0aGUg
b24gcGkuIFNvIGhhdmUgc29tZSBwYXRpZW5jZSA7LSkgSSBjYW4gc2F2ZSBhcyB2Y2QsIHdoaWNo
IHlvdSBjYW4gaW1wb3J0IGluIHNpZ3Jvay4NCg0KLS0NClN0ZWZhbg0K
